//
//  QMFileManager.h
//  qumengTest
//
//  Created by 杜蒙 on 2017/2/27.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMFileManager : NSFileManager
//单利对象 默认有存放的文件夹  @"com.detu.qumeng.cachefile"
+(QMFileManager *)fileManger;

//初始化文件夹名字
-(instancetype)initWithCacheDir:(NSString *)cacheDir;
/* 
  通过文件名字返回url
*/
- (NSURL *)urlFromFileName:(NSString *)fileName;
/* 
  创建path
 */
-(NSString *)pathFromFileName:(NSString *)fileName;

//判断本地是否有次文件名字的文件
- (BOOL)isFile:(NSString *)fileName;

//缓存的文件加载目录
- (NSString *)cacheDirPath;

//替换播放的url
- (NSString *)replaceFilePathWithFile:(NSString *)file;

//写入本地缓存  回调替换回来的播放器url  @"[IOS_DEFAULT_PATH]"
- (void)writeData:(NSData *)data fileName:(NSString *)fileName block:(void(^)(BOOL isWrite ,NSString *fileUrl))block;

@end
