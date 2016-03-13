//
//  ObjectEqualityTestCase.m
//  Objectify
//
//  Created by Tony Li on 4/18/15.
//  Copyright (c) 2015 - 2016 Tony Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ObjectEquality.h"

#pragma mark - Model

@interface PersonEquality : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger age;

@end

@interface StudentEquality : PersonEquality

@property (nonatomic, strong) NSString *school;

@end

@interface NoPropertyClass : NSObject

@end

@implementation PersonEquality

equality_properties(Person, name, age)

@end

@implementation StudentEquality

equality_properties(Student, name, age, school)

@end

@implementation NoPropertyClass

equality_properties(NoPropertyClass)

@end

#pragma mark - Test Case

#define objects_should_be_equal(obj1, obj2) objects_equal_expectation(obj1, obj2, Equal)
#define objects_should_not_be_equal(obj1, obj2) objects_equal_expectation(obj1, obj2, NotEqual)
#define objects_equal_expectation(obj1, obj2, EXPECT) \
    XCTAssert ## EXPECT ##Objects(obj1, obj2); \
    XCTAssert ## EXPECT ##Objects(obj1, obj2); \
    XCTAssert ## EXPECT ([obj1 hash], [obj2 hash]);

@interface ObjectEqualityTestCase : XCTestCase

@property (nonatomic, strong) PersonEquality *person1;
@property (nonatomic, strong) PersonEquality *person2;
@property (nonatomic, strong) PersonEquality *person3;
@property (nonatomic, strong) StudentEquality *student;
@property (nonatomic, strong) StudentEquality *student2;

@end

@implementation ObjectEqualityTestCase

- (void)setUp {
    [super setUp];
    self.person1 = [PersonEquality new];
    self.person2 = [PersonEquality new];
    self.person3 = [PersonEquality new];
    self.student = [StudentEquality new];
}

- (void)testNilPropertiesEqual {
    objects_should_be_equal(self.person1, self.person2);
}

- (void)testEqualObjectMethod {
    XCTAssertEqual([self.person1 isEqual:self.person2],
                   [self.person1 isEqualToPerson:self.person2]);

    self.person1.name = @"Tony";
    XCTAssertEqual([self.person1 isEqual:self.person2],
                   [self.person1 isEqualToPerson:self.person2]);
}

- (void)testPropertiesEqual {
    self.person1.name = @"Tony";
    self.person2.name = @"Tony";
    objects_should_be_equal(self.person1, self.person2);

    self.person2.name = [@"To" stringByAppendingString:@"ny"];
    objects_should_be_equal(self.person1, self.person2);

    self.person2.name = @"Adam";
    objects_should_not_be_equal(self.person1, self.person2);
}

- (void)testEqualTransivity {
    self.person1.name = @"Tony";
    self.person2.name = [@"To" stringByAppendingString:@"ny"];
    self.person3.name = @"Tony";
    objects_should_be_equal(self.person1, self.person2);
    objects_should_be_equal(self.person1, self.person3);
    objects_should_be_equal(self.person2, self.person3);
}

- (void)testSubclassAndSuperClassNotEqual {
    self.person1.name = @"Tony";
    self.student.name = @"Tony";
    objects_should_not_be_equal(self.person1, self.person2);
}

- (void)testNoPropertyClassAreAllEqual {
    objects_should_be_equal([NoPropertyClass new], [NoPropertyClass new]);
}

@end
