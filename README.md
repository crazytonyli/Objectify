# ObjectEquality

[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/crazytonyli/ObjectEquality/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/crazytonyli/ObjectEquality.svg?branch=master)](https://travis-ci.org/crazytonyli/ObjectEquality)

Override `isEqual:` and `hash` methods with one line of code:

```objc
@interface Person : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

@end

@implementation Person

equality_properties(Person, firstName, lastName);

@end
```

The `equality_properties` macro will generate `isEqual:` and `hash` methods,
and also add an `isEqualToXxx:` (`isEqualToPerson:` in this case) method.

## Equality

* Objects are not equal if they are not same class.
* Objects are equal if values of specified properties are all equal.

## Hash

The hash algorithm is from [Mike Ash's blog post].

## License

ObjectEquality is available under the MIT license. See the LICENSE file for
more info.


[Mike Ash's blog post]: https://www.mikeash.com/pyblog/friday-qa-2010-06-18-implementing-equality-and-hashing.html
