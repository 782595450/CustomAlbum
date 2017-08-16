//
//  QMFileManager.m
//  qumengTest
//
//  Created by 杜蒙 on 2017/2/27.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import "QMFileManager.h"
static NSString *qmCache = @"com.detu.qumeng.cachefile";
static NSString *replace = @"[IOS_DEFAULT_PATH]";

@interface QMFileManager ()

//缓存文件夹名字
@property (copy , nonatomic) NSString *cacheDir;
@property (assign , nonatomic) BOOL isExists;

@end

@implementation QMFileManager
+(QMFileManager *)fileManger{
    static QMFileManager *fileManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fileManager = [[self alloc] initWithCacheDir:qmCache];
    });
    [fileManager createDir];
    return fileManager;
    
}

#pragma mark - dir
-(instancetype)initWithCacheDir:(NSString *)cacheDir{
    if (self=[super init]) {
        self.cacheDir = cacheDir;
        [self createDir];
    }
    return self;
}
- (void)createDir{
    if (![self fileExistsAtPath:[self cacheDirPath]]) {
        self.isExists = [self createDirectoryAtPath:[self cacheDirPath] withIntermediateDirectories:YES attributes:nil error:nil];
    }

}

-(BOOL)isFile:(NSString *)fileName{
    NSString *filePath = [[self cacheDirPath] stringByAppendingPathComponent:fileName];
   BOOL isfile =  [self fileExistsAtPath:filePath];
   return isfile;
}

- (NSString *)replaceFilePathWithFile:(NSString *)file{ 
    NSString *path = [replace stringByAppendingPathComponent:self.cacheDir];
    return [path stringByAppendingPathComponent:file];
  
}

- (NSString *)cacheDirPath{
    @autoreleasepool {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    if (self.cacheDir) {
        return [dir stringByAppendingPathComponent:self.cacheDir];
    }
    return [dir stringByAppendingPathComponent:qmCache];
        
   }
}
-(NSString *)pathFromFileName:(NSString *)fileName{
    NSString *path = [[[QMFileManager fileManger] cacheDirPath] stringByAppendingPathComponent:fileName];
    return path;
}
-(NSURL *)urlFromFileName:(NSString *)fileName{
    NSString *path = [self pathFromFileName:fileName];
    return [NSURL fileURLWithPath:path];
}

#pragma mark - 写入数据
-(void)writeData:(NSData *)data fileName:(NSString *)fileName  block:(void (^)(BOOL, NSString *))block{
    @autoreleasepool {
    if (!data)return;
    if (!block)return;
    NSString *dir = [self cacheDirPath];
    NSString *filepath = [dir stringByAppendingPathComponent:fileName];
    NSString *replacePata = [self replaceFilePathWithFile:fileName];
    if ([self fileExistsAtPath:filepath]) {
        block(1,replacePata);
        return;
    }
    BOOL isw = [data writeToFile:filepath atomically:YES];
    block(isw,replacePata);
   }
    
}
@end
