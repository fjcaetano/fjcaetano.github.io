---
layout: post
title: "Hooking Your Hooks"
date: 2019-08-28 18:36:39 -0300
comments: true
categories: 
- react-native
- hoc
- hooks
- compose
share: true
published: true
image:
  feature: /assets/images/abstract-2.jpg 
github_repo: https://github.com/fjcaetano/react-hook-hooked
---

Hey, I just wanted to share with you that I built a nifty little HOC to connect a hook to a
component and receive its returned value as props. This helps cleanup your Function Components since
you can split your states and effects into multiple hooks and simplify your code.

Imagine you have the following component:

```js
const MyComponent = ({ userId }) => {
  const [isLoading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [result, setResult] = useState(null);

  const handlePressButton = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);
      
      const result = await fetchDataFromTheAPI(userId);

      setResult(result);
    } catch(error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }, []);

  const [count, setCount] = useState(0);
  
  const handlePressCount = useCallback(() => {
    setCount(count + 1);
  }, [count]);

  return (
    <>
      {error && <RenderError error={error} />}
      {isLoading && <Spinner />}
      {result && <RenderResult result={result}>}
      <Counter
        count={count}
        onPress={handlePressCount}
      />
      <Button onPress={handlePressButton} />
    </>
  )
};

```

The code may look as clean as possible, but it could be better organized, and this is how you can do
that.

<!-- more -->

## Introducing Hooked

Hooked is a HOC that sends props to a hook as argument and return its value as props to the
component. This way we can separate the previous component into two custom hooks:

```js
// hooks.js
const useButtonHandler = ({ userId }) => {
  const [isLoading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [result, setResult] = useState(null);

  const handlePressButton = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);
      
      const result = await fetchDataFromTheAPI(userId);

      setResult(result);
    } catch(error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }, []);

  return { isLoading, error, result, handlePressButton };
};

const useCounter = () => {
  const [count, setCount] = useState(0);
  
  const handlePressCount = useCallback(() => {
    setCount(count + 1);
  }, [count]);

  return { count, handlePressCount };
};

```

The return types will be merged with the previous props and the whole thing will be sent as props
to the component:

```js
// MyComponent.js
const MyComponent = ({
  isLoading,
  error,
  result,
  handlePressButton,
  count,
  handlePressCount
}) => (
  <>
    {error && <RenderError error={error} />}
    {isLoading && <Spinner />}
    {result && <RenderResult result={result}>}
    <Counter
      count={count}
      onPress={handlePressCount}
    />
    <Button onPress={handlePressButton} />
  </>
);

const enhance = compose(
  hooked(useButtonHandler),
  hooked(useCounter),
);

export default enhance(MyComponent);

```

If you're used with HOCs or recompose, you should be familiar with HOC composition. If you've never
seen that before, know that `compose` is a curry function and that the order of the arguments
affects the final result.

### Hooks that receive arguments

Your hooks will receive previous props as its arguments, that's why it's important to be mindful of
the order of your HOCs. If one hook need a prop returned by another hook, the former needs to be
passed after the latter. Let's change `useCountr`, so that we can only increment our counter when
it's not loading:

```js
// hooks.js
const useButtonHandler = ({ userId }) => {
  const [isLoading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [result, setResult] = useState(null);

  const handlePressButton = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);

      const result = await fetchDataFromTheAPI(userId);

      setResult(result);
    } catch(error) {
      setError(error);
    } finally {
      setLoading(false);
    }
  }, []);

  return { isLoading, error, result, handlePressButton };
};

const useCounter = ({ isLoading }) => {
  const [count, setCount] = useState(0);
  
  const handlePressCount = useCallback(() => {
    if (!isLoading) {
      setCount(count + 1);
    }
  }, [count]);

  return { count, handlePressCount };
};

```
```js
// MyComponent.js
const enhance = compose(
  hooked(useButtonHandler),
  hooked(useCounter),
);

```

Note that `useCounter` now receives an object with the attribute `isLoading`. Since we're hooking
it after `useButtonHandler`, it will receive whatever the latter is returning, which includes
`isLoading`. If our `compose` was reversed, `isLoading` would be `undefined` in `useCounter` since
it doesn't exist yet.

#### Custom argument mapping

By default, `hooked` passes through to the hook any props it receives, however, if you need custom
mapping of the props to arguments, you can send an optional function to do so:

```js
// hooks.js
const useCounter = isLoading => {
  const [count, setCount] = useState(0);
  
  const handlePressCount = useCallback(() => {
    if (!isLoading) {
      setCount(count + 1);
    }
  }, [count]);

  return { count, handlePressCount };
};

```
```js
// MyComponent.js
const enhance = compose(
  hooked(useButtonHandler),
  hooked(useCounter, ({ isLoading }) => isLoading),
);

```

`useCounter` now receives `isLoading` directly as the only argument instead of receiving an object,
so we had to map the props to that argument in our call to `hooked`.

## Typescript ❤️

If you're awesome and use Typescript, you'll be glad to know that `hooked` is fully compatible with
Typescript. Actually, `hooked` was implemented considering Typescript as first-class citizen.

Pro-tip: if you need to merge your props with the values returned by your hook, a good idea is to use
Typescript's build-in `ReturnType<>`:

``` ts
// hooks.js
const useCounter = () => {
  ...

  return { count, handlePressCount };
};

export type CounterHookProps = ReturnType<typeof useCounter>;

```
``` ts
// MyComponent.js
interface Props {
  name: string;
  userId: number;
}

type HookedProps = Props & CounterHookProps;

const MyComponent = ({ name, count }: HookedProps) => (
  ...
);

export default hooked(useCounter)(MyComponent);

```