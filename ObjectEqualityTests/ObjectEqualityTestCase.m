//
//  ObjectEqualityTestCase.m
//  ObjectEquality
//
//  Created by Tony Li on 4/18/15.
//  Copyright (c) 2015 Tony Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ObjectEquality.h"

#pragma mark - Model

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger age;

@end

@interface Student : Person

@property (nonatomic, strong) NSString *school;

@end

@interface NoPropertyClass : NSObject

@end

@implementation Person

equality_properties(Person, name, age)

@end

@implementation Student

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

@property (nonatomic, strong) Person *person1;
@property (nonatomic, strong) Person *person2;
@property (nonatomic, strong) Person *person3;
@property (nonatomic, strong) Student *student;
@property (nonatomic, strong) Student *student2;

@end

@implementation ObjectEqualityTestCase

- (void)setUp {
    [super setUp];
    self.person1 = [Person new];
    self.person2 = [Person new];
    self.person3 = [Person new];
    self.student = [Student new];
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
