//
//  LHMHttpTool.m
//  各种小功能
//
//  Created by iOSDev on 17/3/18.
//  Copyright © 2017年 iOSDev. All rights reserved.
//
#import "LHMHttpTool.h"
#import "AFNetworking.h"
@implementation LHMHttpTool
+(void)GET:(NSString *)url
    params:(NSDictionary *)params
  progress:(void (^)(NSProgress *))progress
   success:(void (^)(id))success
   failure:(void (^)(NSError *))failure {
    // 1.获得请求管理者
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    // 创建GET请求
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}



+ (void)POST:(NSString *)url
      params:(NSDictionary *)params
    progress:(void (^)(NSProgress *))progress
     success:(void (^)(id))success
     failure:(void (^)(NSError *))failure {
    // 1.获得请求管理者
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    // 创建POST请求
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
//// 上传文件请求
+ (void)UploadWithPath:(NSString *)path Params:(NSDictionary *)params DataSource:(FormData *)dataSource Success:(void (^)(id json))success Failure:(void (^)(NSError * error))failure Progress:(void(^)(float percent))percent {
 
    // 1.获得请求管理者
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    
    [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:dataSource.fileData
                                    name:dataSource.name
                                fileName:dataSource.fileName
                                mimeType:dataSource.fileType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

//// 上传多个文件请求
+ (void)UploadWithPath:(NSString *)path Params:(NSDictionary *)params ImgsArray:(NSArray *)ImgsArray Success:(void (^)(id json))success Failure:(void (^)(NSError * error))failure Progress:(void(^)(float percent))percent {
    
    // 1.获得请求管理者
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    
    [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (FormData *data in ImgsArray) {
            [formData appendPartWithFileData:data.fileData
                                        name:data.name
                                    fileName:data.fileName
                                    mimeType:data.fileType];
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
/**
 *  用来封装文件数据的模型
 */

@implementation FormData
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fileType=@"";
        self.name=@"";
    }
    return self;
}
@end
