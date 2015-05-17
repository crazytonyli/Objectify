//
//  ObjectDescription.h
//  Objectify
//
//  Created by Tony Li on 5/16/15.
//  Copyright (c) 2015 Tony Li. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "metamacros.h"
#import "EXTKeyPathCoding.h"

/**
 * Generate `description` method based on given properties.
 *
 * The generated `description` method will return string with following format:
 *
 *     <ClassName: PointerAddress, prop0=value0, prop1=value1 ... >
 *
 */
#define description_properties(...) \
    - (NSString *)description { \
        NSMutableString *str = [NSMutableString string]; \
        [str appendFormat:@"<%@: %p", NSStringFromClass(self.class), self]; \
        metamacro_foreach(_description_properties_iter, ;,__VA_ARGS__); \
        [str appendString:@">"]; \
        return [str copy]; \
    } \

#define _description_properties_iter(_, VAL) \
    [str appendFormat:@", %@=%@", @keypath(self, VAL), [self valueForKey:@keypath(self, VAL)]]
