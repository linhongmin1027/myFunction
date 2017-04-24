//
//  LHMImagePicker.h
//  各种小功能
//
//  Created by iOSDev on 17/3/18.
//  Copyright © 2017年 iOSDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger , LMEditType) {
    LMEditTypeSquare =0,  //方形
    LMEditTypeCircle      //圆形


};
@interface LHMImagePicker : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
+(id)sharedInstance;

-(void)getImageFromViewController:(UIViewController *)vc
                            image:(void(^)(UIImage *img))callback;

-(void)getImageFromViewController:(UIViewController *)vc
                            image:(void(^)(UIImage *img))callback
                      editedImage:(void(^)(UIImage *editedImage))edited;

@property (nonatomic,copy) void(^imagecb)(UIImage *image);
@property (nonatomic,copy) void(^editedImage)(UIImage *image);
@property(nonatomic,assign)LMEditType editType;
@end
