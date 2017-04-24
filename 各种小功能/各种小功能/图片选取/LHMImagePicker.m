//
//  LHMImagePicker.m
//  各种小功能
//
//  Created by iOSDev on 17/3/18.
//  Copyright © 2017年 iOSDev. All rights reserved.
//

#import "LHMImagePicker.h"
#import "LMEditController.h"
#import <AssetsLibrary/AssetsLibrary.h>
@implementation LHMImagePicker
{
    UIViewController *_viewController;
    //    void(^_imagecb)(UIImage *image);
    int a;
}
+(id)sharedInstance
{
    static LHMImagePicker *_p = nil;
    if (!_p) {
        _p = [[LHMImagePicker alloc]init];
    }
    return _p;
}

-(void)getImageFromViewController:(UIViewController *)vc
                            image:(void(^)(UIImage *img))callback
{
    _viewController = vc;
    _imagecb = callback;
    [self selectImageEdited:NO];
}

-(void)getImageFromViewController:(UIViewController *)vc
                            image:(void(^)(UIImage *img))callback
                      editedImage:(void(^)(UIImage *editedImage))edited
{
    
    _viewController = vc;
    _imagecb = callback;
    _editedImage = edited;
    [self selectImageEdited:YES];
}

-(void)selectImageEdited:(BOOL)edit
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pickImageFrom:UIImagePickerControllerSourceTypePhotoLibrary edit:edit];
        
    }];
    [alert addAction:action];
    
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pickImageFrom:UIImagePickerControllerSourceTypeCamera  edit:edit];
    }];
    [alert addAction:action2];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action3];
    [_viewController presentViewController:alert animated:YES completion:nil];
}



-(void)pickImageFrom:(UIImagePickerControllerSourceType)type  edit:(BOOL)edit 
{
    //权限
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied) {
        NSString *photoType = type==UIImagePickerControllerSourceTypeCamera?@"相机":@"相册";
        NSString * title = [NSString stringWithFormat:@"%@权限未开启",photoType];
        NSString * msg = [NSString stringWithFormat:@"请在系统设置中开启该应用%@服务\n(设置->隐私->%@->开启)",photoType,photoType];
        NSString * cancelTitle = @"知道了";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
    picker.allowsEditing = edit;
    picker.delegate = self;
    picker.sourceType = type;
    [_viewController presentViewController:picker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"%@",info);
    UIImage *img = info[@"UIImagePickerControllerOriginalImage"];
    UIImage *edit = info[@"UIImagePickerControllerEditedImage"];
    _imagecb(img);
    if (self.editType==LMEditTypeCircle)
    {
        LMEditController *editController=[[LMEditController alloc]init];
        editController.sourceImage=img;
        [picker pushViewController:editController animated:YES];
        
    }else{
        if (_editedImage) {
            _editedImage(edit);
        }

    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
