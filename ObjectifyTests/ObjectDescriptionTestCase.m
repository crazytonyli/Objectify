//
//  ObjectDescriptionTestCase.m
//  Objectify
//
//  Created by Tony Li on 5/16/15.
//  Copyright (c) 2015 Tony Li. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ObjectDescription.h"

@interface PersonDesc : NSObject

@property (nonatomic, strong) NSString *name;

@end

@implementation PersonDesc

description_properties(name)

@end

@interface ObjectDescriptionTestCase : XCTestCase
@end

@implementation ObjectDescriptionTestCase

- (void)testDescription {
    PersonDesc *p = [PersonDesc new];
    p.name = @"Tony Li";
    XCTAssertTrue([p.description containsString:p.name]);
}

@end
