//
//  LHMHttpTool.h
//  各种小功能
//
//  Created by iOSDev on 17/3/18.
//  Copyright © 2017年 iOSDev. All rights reserved.
//

#import <Foundation/Foundation.h>
//用来封装 上传文件 的数据模型
@interface FormData : NSObject
@property(nonatomic,strong)NSData * fileData;//文件数据
@property(nonatomic,copy)NSString * fileName;//文件名.jpg
@property(nonatomic,copy)NSString * name;//参数名
@property(nonatomic,copy)NSString * fileType;//文件类型
@end

@interface LHMHttpTool : NSObject

/**
 *  对GET请求的再次封装
 *
 *  @param url      请求接口
 *  @param params   请求参数
 *  @param progress 请求进度
 *  @param success  成功之后返回（请将请求成功后想做的事情写到这个block中）
 *  @param failure  失败之后返回（请将请求成功后想做的事情写到这个block中）
 */
+ (void)GET:(NSString *)url
     params:(NSDictionary *)params
   progress:(void (^)(NSProgress *progress))progress
    success:(void (^)(id responseObj))success
    failure:(void (^)(NSError * error))failure;

/**
 *  对POST请求的再次封装
 *
 *  @param url      请求接口
 *  @param params   请求参数
 *  @param progress 请求进度
 *  @param success  成功
 *  @param failure  失败
 */
+ (void)POST:(NSString *)url
      params:(NSDictionary *)params
    progress:(void (^)(NSProgress *progress))progress
     success:(void (^)(id responseObj))success
     failure:(void (^)(NSError * error))failure;
/**
 *  发送一个POST请求
 *
 *  @param path     请求路径
 *  @param params   请求参数
 *  @param formData 文件参数 需传入fileData fileName(xxx.jpg)
 *  @param success  请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure  请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 *  @param percent  请求中的回调（上传完成百分比）
 */
+ (void)UploadWithPath:(NSString *)path Params:(NSDictionary *)params DataSource:(FormData *)dataSource Success:(void (^)(id json))success Failure:(void (^)(NSError * error))failure Progress:(void(^)(float percent))percent;


/**
 上传多个图片文件
 
 @param path 请求路径
 @param params 请求参数
 @param ImgsArray 文件参数 需传入fileData fileName(xxx.jpg)
 @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 @param failure 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 @param percent 请求中的回调（上传完成百分比）
 */
+ (void)UploadWithPath:(NSString *)path Params:(NSDictionary *)params ImgsArray:(NSArray *)ImgsArray Success:(void (^)(id json))success Failure:(void (^)(NSError * error))failure Progress:(void(^)(float percent))percent;

@end
