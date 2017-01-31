//
//  ViewController.m
//  Persistence
//
//  Created by wanghuiyong on 27/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

#import "ViewController.h"
#import "FourLines.h"

static NSString * const kRootKey = @"kRootKey";

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *lineFields;

@end

@implementation ViewController

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.archive"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [self dataFilePath];
    NSLog(@"View Did Load, file at: %@", filePath);
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        // 解归档: 文件 -> data -> object
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        FourLines *fourlines = [unarchiver decodeObjectForKey:kRootKey];
        [unarchiver finishDecoding];
        // 显示在标签中
        for (int i = 0; i < 4; i++) {
            UITextField *thefield = self.lineFields[i];
            thefield.text = fourlines.lines[i];
        }
    }
    // 应用在进入后台前保存数据
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
}

- (void)applicationWillResignActive: (NSNotification *) notification {
    // 从标签中写入数据到文件
    NSString *filePath = [self dataFilePath];
    FourLines *fourLines = [[FourLines alloc] init];
    fourLines.lines = [self.lineFields valueForKey:@"text"];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] init];
    [archiver encodeObject:fourLines forKey:kRootKey];
    [archiver finishEncoding];
    [data writeToFile:filePath atomically:YES];
    NSLog(@"Will Resign Active");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
