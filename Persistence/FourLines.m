//
//  FourLines.m
//  Persistence
//
//  Created by wanghuiyong on 27/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

#import "FourLines.h"

static NSString * const kLinesKey = @"kLinesKey";	// 常量字符串, 不能指向其他字符串

@implementation FourLines

#pragma mark - Coding

// 使用相同的键对 lines 属性进行解码, 返回解码后的对象
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.lines = [aDecoder decodeObjectForKey:kLinesKey];
    }
    return self;
}

// 对 lines 属性进行编码, 并指定一个键, 存储为 aCoder 实例
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.lines forKey:kLinesKey];
}

#pragma mark - Copying

// 使用深副本进行拷贝
- (id)copyWithZone:(NSZone *)zone {
    FourLines *copy = [[[self class] allocWithZone:zone] init];	// 对象副本
    NSMutableArray *linesCopy = [NSMutableArray array];			// 对象的属性的副本
    // 拷贝数组中的每个对象
    for (id line in self.lines) {
        [linesCopy addObject:[line copyWithZone:zone]];
    }
    copy.lines = linesCopy;
    return copy;
}

@end
