//
//  FourLines.h
//  Persistence
//
//  Created by wanghuiyong on 27/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FourLines : NSObject <NSCoding, NSCopying>	// 数据模型类

@property (copy, nonatomic) NSArray *lines;	// 数据模型对象

@end
