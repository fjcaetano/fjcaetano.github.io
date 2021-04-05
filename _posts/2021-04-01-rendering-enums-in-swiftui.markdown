---
layout: post
title: "Rendering enums in SwiftUI"
date: 2021-04-01 15:33:00 -0400
comments: true
categories: 
  - swiftui
  - swift
  - ios
  - macos
share: true
published: true
image:
  feature: /assets/images/abstract-6.jpg
---

Enums are an excellent way to leverage Swift's value-types and immutability principles for handling states. Imagine you have a view that fetches a list of items from an API. You can represent that view's state as the following enum:

``` swift
enum ViewState {
  case idle,          // next state: .loading
       loading,       // next states: .items or .error
       items([Item]), // next state: .loading
       error(Error)   // next state: .loading
}
```

Your view is idle before fetching your list. When it does so, you update your view's state to `.loading` and add an appropriate indicator. From there you'll either have a successful state with the list you just loaded, or an error, much like a Result.

Now if your View, or ViewModel has a ViewState attribute, how would you render that in SwiftUI?

``` swift
struct ItemsListView: View {
  @State var state: ViewState = .idle

  var body: some View {
    // TODO: render `state`
  }
}
```

<!-- more -->

You could add a switch-case to your view's `body`, but that'd be mixing imperative programming with the SwiftUI's declarative syntax. It works, but it's less than ideal and just ugly, in my honest opinion.

You could also add a method that returns a View for the given state. Something like:

```swift
struct ItemsListView: View {
  @State var state: ViewState = .idle

  var body: some View {
    stateView()
  }

  private func stateView() -> some View {
    switch state {
      case .idle: return EmptyView().eraseToAnyView()
      case .loading: return Spinner().eraseToAnyView()
      case .items(let list): return ItemsList(list).eraseToAnyView()
      case .error(let error): return ErrorView(error).eraseToAnyView()
    }
  }
}
```

> Do yourself a favor and add the much needed modifier that wraps a View into AnyView and erases its type, making it semantically consistent to Combine's `eraseToAnyPublisher()`

This is better, but still not great since you need to refer to code outside your View's `body` to know what is being rendered. Don't get me wrong: componentizing is great when you're grouping views into containers like "header", "footer", "hero", "left panel", but you should only group components that make sense to be grouped. States are not containers. They represent different possibilities and, therefore, shouldn't be grouped. So how do we fix that in order to have our state being rendered within our View's `body`? The answer is to make ViewState provide the correct view:

```swift
private extension ViewState {
  func render<Idle: View, Loading: View, Items: View, ErrorView: View>(
    idle: () -> Idle,
    loading: () -> Loading,
    items: ([Item]) -> Items,
    error: (Error) -> ErrorView
  ) -> some View {
    switch self {
      case .idle: return idle().eraseToAnyView()
      case .loading: return loading().eraseToAnyView()
      case .items(let list): return items(list).eraseToAnyView()
      case .error(let err): return error(err).eraseToAnyView()
    }
  }
}
```

> Make sure to add this **private** extension in your View's file, **not** where you declared the ViewState enum. You can also wrap any of `render`'s arguments in `@ViewBuilder` if it makes sense for your use-case.

Now all we have to do is call `render` in our View's `body`:
```swift
struct ItemsListView: View {
  @State var state: ViewState = .idle

  var body: some View {
    state.render(
      idle: { EmptyView() },
      loading: { Spinner() },
      items: { list in
        ItemsList(list)
      },
      error: { error in
        ErrorView(error)
      }
    )
  }
}

// ViewState's private extension can go here
```

Isn't that much better? Our View's organization is on-point by keeping things where they should be, while still leveraging what Swift offers best (immutability, switch-cases exhaustiveness, and generics). That's the pattern I've being going for with great success in both SwiftUI apps I've implemented so far.

### Bonus

If you want to add that AnyView modifier I mentioned above, here's the code:

```swift
extension View {
  func eraseToAnyView() -> AnyView {
    AnyView(self)
  }
}
```
