# ObjectEuqality

Override `isEqual:` and `hash` methods with one line of code:

```objc
@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger age;

@end

@implementation Person

equality_properties(Person, name, age);

@end

```

The `equality_properties` macro will generate `isEqual:` and `hash` methods, and also add an `isEqualToXxx` (`isEqualToPerson:` in this case) method.

## Equality

* Objects are not equal if they are not same class.
* Objects are equal if values of specified properties are all equal.

## Hash

The hash algorithm is writed by [Mike Ash](https://www.mikeash.com/pyblog/friday-qa-2010-06-18-implementing-equality-and-hashing.html).
