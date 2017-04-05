//
//  ViewController.m
//  各种小功能
//
//  Created by iOSDev on 17/3/11.
//  Copyright © 2017年 iOSDev. All rights reserved.
//

#import "ViewController.h"
#import "MyCodeViewController.h"
#import "LHMImagePicker.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//二维码
- (IBAction)CreatCode:(id)sender {
    MyCodeViewController *myCode=[[MyCodeViewController alloc]init];
    [self presentViewController:myCode animated:YES completion:nil];
}
//选取图片
- (IBAction)selectedImg:(id)sender {
    [[LHMImagePicker sharedInstance] getImageFromViewController:self image:^(UIImage *img) {
        
    } editedImage:^(UIImage *editedImage) {
        
    }];
    
}
#pragma mark--刷新
- (IBAction)MJRefresh:(id)sender {
}
#pragma mark--MBProgress
- (IBAction)MBProgress:(id)sender {
}
#pragma mark--SDWebImage
- (IBAction)SDWebImage:(id)sender {
}
#pragma mark--滚动视图
- (IBAction)circleImg:(id)sender {
}
#pragma mark--网络请求
- (IBAction)netWork:(id)sender {
}
#pragma mark--FMDB
- (IBAction)FMDB:(id)sender {
}
#pragma mark--本地数据存储
- (IBAction)SaveLocalData:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
