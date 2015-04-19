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
 * @param NAME Name of object class. An `isEqualTo<Name>:` method will be generated.
 *             e.g. for a class named `CTLPerson`, you should pass in `Person`
 *             as the `NAME` argument
 * @param ...  Names of properties which will be used in object value comparison.
 *             You can pass one or many (up to 20) arguments here.
 */
#define equality_properties(NAME, ...) \
    \
    - (BOOL)isEqualTo ## NAME:(id)obj { \
        if (obj == nil) { return NO; } \
        if (self == obj) { return YES; } \
        return metamacro_foreach(_equality_equal_iter, &&, __VA_ARGS__); \
    } \
    \
    - (BOOL)isEqual:(id)obj { \
        if (obj == nil) { return NO; } \
        if (self == obj) { return YES; } \
        if ([obj class] != [self class]) { return NO; } \
        return [self isEqualTo ## NAME:obj]; \
    } \
    \
    - (NSUInteger)hash { \
        NSUInteger hash = 0; \
        metamacro_foreach(_equality_hash_iter,, __VA_ARGS__); \
        return hash; \
    }

#define _equality_equal_iter(INDEX, VAL) \
    ([self valueForKey:@keypath(self, VAL)] == [obj valueForKey:@keypath(self, VAL)] \
        || [[self valueForKey:@keypath(self, VAL)] isEqual:[obj valueForKey:@keypath(self, VAL)]])

// Hash algorithm by Mike Ash:
// https://www.mikeash.com/pyblog/friday-qa-2010-06-18-implementing-equality-and-hashing.html

#define _equality_NSUINT_BIT (CHAR_BIT * sizeof(NSUInteger))
#define _equality_NSUINTROTATE(val, howmuch) \
    ((((NSUInteger)val) << howmuch) | (((NSUInteger)val) >> (_equality_NSUINT_BIT - howmuch)))

#define _equality_hash_iter(INDEX, VAL) \
    hash = _equality_NSUINTROTATE(hash, _equality_NSUINT_BIT / 2) ^ [[self valueForKey:@keypath(self, VAL)] hash];
