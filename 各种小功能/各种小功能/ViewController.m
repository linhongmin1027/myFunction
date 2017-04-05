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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
