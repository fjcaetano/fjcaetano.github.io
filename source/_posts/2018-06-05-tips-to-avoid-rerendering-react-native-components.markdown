---
layout: post
title: "Tips To Avoid Rerendering React-Native Components"
date: 2018-06-05 17:30:00 -0300
comments: true
categories:
- react-native
share: true
published: true
image:
  feature: /images/abstract-11.jpg
---

Building a production-ready fully architectured React-Native app means sending and updating lots of
props to your components. This means the `shouldUpdate -> render -> didUpdate` flow gets called a
lot. Here are a few steps on how to optimize your components to avoid rerendering unnecessarily.

<!-- more -->

## Use Pure Components

Pure components are, much like pure functions, components that always produce the same output, given
an input. This usually means no input side-effects, i.e., no selectors, no fetching props that were
not passed by its parent, _etcetera_.

You can tag your components for this performance optimization either by using stateless components
(with arrow functions), or by extending `React.PureComponent`. `FlatList` and `SectionList` are some
examples of vanilla React-Native pure components.

Being pure means the component is optimized to only be rendered when its input changes. In other
words, if the props don't change, the component won't be rerendered.

```js
const NameComponent = ({ name }) => <Text>{name}</Text>;

class NameButton extends React.PureComponent {
    render() {
        return <NameComponent name={this.props.name} />;
    }
}

class NameScreen extends React.Component {
    render() {
        return
            <NameButton
                name={this.props.name}
                onPress={this.handleNamePress}
            />;
    }
}

export default connect(selector)(NameScreen);

```

In the example above, both `NameComponent` and `NameButton` are pure components, while `NameScreen`
isn't because it gets its props from a selector.

## Don't Create Objects Within `render`

Pure components check for shallow equality of their props, therefore, if you create an object in your
`render()` method, when the interpreter compares it against the previous object, it will detect an
inequallity which will cause your component to rerender.

{% raw %}

```js
const Role = ({ name, age, address, permissions: { isAdmin } }) => (
    <Profile profile={{ name, age, address, isAdmin }} />
);

const User = ({ name, age, permissions }) => (
    <Role name={name} age={age} permissions={permissions} />
);

export default connect(selector)(User);
```
{% endraw %}

In the example above, `Profile` will be rendered everytime, even if the props don't change. Instead,
it'd be ideal if `Role` received the `profile` object all the way down from the selector, ready to
be passed down to `Profile` instead.

```js
const Role = ({ profile }) => (
    <Profile profile={profile} />
);

const User = ({ profile }) => (
    <Role profile={profile} />
);

export default connect(selector)(User);
```

Bare in mind that the value returned by `selector` changed to better accomodate our props.

## Arrow Functions Are Objects

It's easy to forget that arrow (anonymous) functions are objects too, so when you create a new one
in your `render()` method, you're doing the same as above.

{% raw %}
```js
const PictureButton = ({ pictureURL }) => (
    <TouchableHighlight
        onPress={() => {
            // Did press picture
        }}
    >
        <Image source={{ uri: pictureURL }} />
    </TouchableHighlight>
);
```
{% endraw %}

In this example, `TouchableHighlight` is always receiving a new function object, regardless of it
being hardcoded. In this case, we should have a method to handle pressing and pass it down like
`onPress={this.handlePicturePress}`.

You may have also noticed that we're sending a source object to `Image`. As described in the
previous bullet, this is also troublesome. Maybe we need to revisit how `Image` receive its props.

## Avoid Render Handlers

By render handlers, I mean methods that render components. When you have your `render()` calling
other methods, it's easy to get lost on the good practices mentioned above and end up with something
you'd normally avoid if you were writing directly in it.

```js
class Profile extends React.Component {
    renderPicture = () => {
        const source = { uri: this.props.pictureURL };
        return <PictureButton image={source}/>l
    }

    render() {
        return (
            <View>
                {this.renderPicture}
                <Button>
            </View>
        );
    }
}
```

It may look like we have fixed the `Image.source` issue, but we haven't. That's because we are
creating a new `source` object everytime `renderPicture` gets called, which happens when `render()` gets
called.

However, avoiding this practice doesn't mean you should never do it. One good exception to this rule
is how to define a list's item renderer. Since we should absolutely never use arrow functions, this
renderer should be defined as a handler:

```js
class ObjectList extends React.Component {
    renderItem = ({ item }) =>
        <Text>{item.title}</Text>;

    render() {
        return <FlatList renderItem={this.renderItem} />;
    }
}
```

---

_These are just a few examples of good practices for writing components. The list is endless, if
there's anything you'd like to see here, comment below._
