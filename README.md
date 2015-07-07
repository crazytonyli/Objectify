# Objectify

[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/crazytonyli/Objectify/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/crazytonyli/Objectify.svg?branch=master)](https://travis-ci.org/crazytonyli/Objectify)

## Features

Objectify contains following features:

- ObjectEquality: Override `isEqual:` and `hash` methods with one line of code
- ObjectDescription: Override `description` method with one line of code

## Object Equality

```objc

@implementation Person

equality_properties(Person, firstName, lastName);

@end
```

The `equality_properties` macro will generate `isEqual:` and `hash` methods,
and also add an `isEqualToXxx:` (`isEqualToPerson:` in this case) method.

### Equality

* Objects are not equal if they are not same class.
* Objects are equal if values of specified properties are all equal.

### Hash

The hash algorithm is from [Mike Ash's blog post].

## Object Description

Override `description` with one line of code:

```objc
@implementation Person

description_properties(firstName, lastName);

@end
```

The `description_properties` macro will generate `description` method
which will return formatted string:

    <ClassName: PointerAddress, prop0=value0, prop1=value1 ... >

## License

Objectify is available under the MIT license. See the LICENSE file for
more info.


[Mike Ash's blog post]: https://www.mikeash.com/pyblog/friday-qa-2010-06-18-implementing-equality-and-hashing.html
