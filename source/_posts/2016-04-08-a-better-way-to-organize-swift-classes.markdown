---
layout: post
title: "A Better Way To Organize Swift Classes"
date: 2016-04-08 16:36:53 -0300
comments: true
categories:
  - Swift
comments: true
share: true
published: true
tags:
- xcode swift organization
image:
  feature: /images/abstract-1.jpg
---

{% blockquote Mattt Thompson http://nshipster.com/pragma/#organizing-your-code %}
Code organization is a matter of hygiene
{% endblockquote %}

Having a clean, organized code means that anyone can easily maintain it. There
will be no hassles when trying to read and understand it. Being able to rapidly
find a method based on it's scope is a gift. So I thought I'd show you my way of
organizing properties and methods within a class.

<!-- more -->

## Always use MARK

If you don't use the source navigator to browse through your classes' methods,
you're doing it wrong.

[![Scope Grouping](/images/swift-organization/scope-grouping.png)](/images/swift-organization/scope-grouping.png){:target="_blank"}

Absolutely **always** use `// MARK:` to segment your code. Use it followed by hyphen to separate your
extensions and without it to separate your code logic. Use mark to separate your
properties from your methods. You may also use it to group your methods by their scope. Use
comments to group your properties by their meaning.

![// MARK:](/images/swift-organization/mark.png)

## Properties And Overridden Methods Go First

One of the most important things of a subclass is knowing how it differs from its
parent, therefore, what should come first in your class file are your class'
properties and overridden methods.

``` swift
class UserTableViewCell: UITableViewCell {
  var user: UserViewModel! {
    didSet {
      setupUser()
    }
  }

  // MARK: Outlets

  @IBOutlet private weak var titleLabel: UILabel!

  // MARK: - Overridden Methods

  override func prepareForReuse() {
    super.prepareForReuse()

    cleanUp()
  }
}
```

Using this organization methodology, it'd be of great advantage if we could declare
properties in class extensions, however, since it's not possible for obvious reasons,
all your properties must be declared inside the class declaration.

## Put Your Public Methods In An Extension

Right after your class declaration, add an extension to implement your public
methods. That will make clear that they're not protocol nor private methods.

``` swift
// MARK: - Public Methods
extension UserTableViewCell {
  // View Manipulation
  func disable() {
    alpha = 0.3
  }

  func select() {
    backgroundColor = UIColor.greenColor()
  }

  // MARK: Update User
  func setUserStatus(status: UserStatus) {
    user.status = status
    backgroundColor = UIColor.blueColor()
  }
}
```

## Use Extensions For Implementing Protocols

This way you're automatically grouping methods by their scope. Also, thanks to
Swift compiler, this way it's easier to navigate through errors.

[![Protocol Errors](/images/swift-organization/delegate-error.png)](/images/swift-organization/delegate-error.png){:target="_blank"}

## Leave Your Private Methods Last

Put your helpers and private methods in the last extension of the file. This way
you can scroll directly to the bottom to add a new method and you'll know exactly
where to look at when searching for a helper method. Again: don't forget to group
the methods by what they do.

``` swift
// MARK: - Private Methods
extension PromotedUsersTableViewCell {
  // Resource Methods
  private func loadUser() {
    UserResource.load() { user in
      self.user = user
    }
  }

  private func loadMoreStuff() {
    // Load it
  }

    // MARK: View Setup
  private func setupUser() {
    titleLabel.text = user.name
    backgroundColor = UIColor.whiteColor()
  }
}
```

## Conclusion

I hope this makes your code as clear as possible. Since I've started doing this,
I never have to scroll through a class looking for some method or property. Honestly,
few things get me more upset than random properties thrown around some class.

If you have any suggestions to this organization methodology, let me know. The
cleaner the better.
