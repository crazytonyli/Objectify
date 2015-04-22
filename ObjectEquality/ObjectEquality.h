//
//  ObjectEquality.h
//  ObjectEquality
//
//  Created by Tony Li on 4/18/15.
//  Copyright (c) 2015 Tony Li. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EXTKeyPathCoding.h"
#import "metamacros.h"

/**
 * Generate `isEqualToXxx:`, `isEqual:` and `hash` methods based on properties.
 *
 * Say we have a class named `CTLPerson` which has two properties: `firstName`
 * and `lastName`, and we decide that if two person have same first name and
 * last name, then they are same person. All we need to do is put following
 * code in the implementation of `CTLPerson`.
 *
 * > equality_properties(Person, firstName, lastName)
 *
 * Now `CTLPerson` class implementes `isEqualToPerson:`, `isEqual:` and `hash` methods.
 *
 *
 * First argument:  Name of object class. An `isEqualTo<Name>:` method will be
 *                  generated. e.g. For a class named `CTLPerson`, you should
 *                  pass in `Person` as the `NAME` argument
 * Other arguments: Names of properties which will be used in object value
 *                  comparison. You can pass none or many (up to 20) arguments here.
 *                  No property passed indicates objects are equal if they are
 *                  exactly some class.
 *                  One or many properties passed indicates objects are equal if
 *                  all value of the passed properties are equal.
 */
#define equality_properties(...) \
    \
    - (BOOL)metamacro_concat(isEqualTo, metamacro_at(0, __VA_ARGS__)):(id)obj { \
        if (obj == nil) { return NO; } \
        if (self == obj) { return YES; } \
        metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
            (return [self class] == [obj class];) \
            (return metamacro_foreach(_equality_equal_iter, &&, metamacro_tail(__VA_ARGS__));) \
    } \
    \
    - (BOOL)isEqual:(id)obj { \
        if ([obj class] != [self class]) { return NO; } \
        return [self metamacro_concat(isEqualTo, metamacro_at(0, __VA_ARGS__)):obj]; \
    } \
    \
    - (NSUInteger)hash { \
        NSUInteger hash = 0; \
        metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
            (hash = [[self class] hash];) \
            (metamacro_foreach(_equality_hash_iter,, metamacro_tail(__VA_ARGS__));) \
        return hash; \
    }

#define _equality_equal_iter(INDEX, VAL) \
    ({ \
        id value1 = [self valueForKey:@keypath(self, VAL)]; \
        id value2 = [obj valueForKey:@keypath(self, VAL)]; \
        (value1 == value2 || [value1 isEqual:value2]); \
    })

// Hash algorithm by Mike Ash:
// https://www.mikeash.com/pyblog/friday-qa-2010-06-18-implementing-equality-and-hashing.html

#define _equality_NSUINT_BIT (CHAR_BIT * sizeof(NSUInteger))
#define _equality_NSUINTROTATE(val, howmuch) \
    ((((NSUInteger)val) << howmuch) | (((NSUInteger)val) >> (_equality_NSUINT_BIT - howmuch)))

#define _equality_hash_iter(INDEX, VAL) \
    hash = _equality_NSUINTROTATE(hash, _equality_NSUINT_BIT / 2) ^ [[self valueForKey:@keypath(self, VAL)] hash];
