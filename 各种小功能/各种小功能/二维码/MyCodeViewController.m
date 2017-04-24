//
//  MyCodeViewController.m
//  各种小功能
//
//  Created by iOSDev on 17/3/11.
//  Copyright © 2017年 iOSDev. All rights reserved.
//

#import "MyCodeViewController.h"

@interface MyCodeViewController ()
@property(nonatomic,strong)UIImageView *LHMImageView;
@end

@implementation MyCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _LHMImageView =[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:_LHMImageView];
    //[self layoutUI];
    [self creatQRCodeWith:self.LHMImageView openUrl:@"http://www.shougege.com/index.php?g=user&m=Share&a=index&u=129644" logoImg:[UIImage imageNamed:@"min.jpg"]];
}
-(void)creatQRCodeWith:(UIImageView *)showImgView openUrl:(NSString *)url logoImg:(UIImage *)logo{
    //使用iOS 7后的CIFilter对象操作，生成二维码图片imgQRCode（会拉伸图片，比较模糊，效果不佳）
    CIImage *imgQRCode = [LHMCode createQRCodeImage:url];
    //使用核心绘图框架CG（Core Graphics）对象操作，进一步针对大小生成二维码图片imgAdaptiveQRCode（图片大小适合，清晰，效果好）
    UIImage *imgAdaptiveQRCode = [LHMCode resizeQRCodeImage:imgQRCode withSize:showImgView.frame.size.width];
    //默认产生的黑白色的二维码图片；我们可以让它产生其它颜色的二维码图片，例如：蓝白色的二维码图片
    //imgAdaptiveQRCode = [LHMCode specialColorImage:imgAdaptiveQRCode withRed:0 green:0 blue:0]; //0~255
    //使用核心绘图框架CG（Core Graphics）对象操作，创建带圆角效果的图片
    UIImage *imgIcon = [UIImage createRoundedRectImage:logo withSize:CGSizeMake(50, 50)withRadius:10];
    //使用核心绘图框架CG（Core Graphics）对象操作，合并二维码图片和用于中间显示的图标图片
    imgAdaptiveQRCode = [LHMCode addIconToQRCodeImage:imgAdaptiveQRCode withIcon:imgIcon withIconSize:imgIcon.size];
        imgAdaptiveQRCode = [LHMCode addIconToQRCodeImage:imgAdaptiveQRCode
                                                  withIcon:imgIcon
                                                 withScale:3];
    
    showImgView.image = imgAdaptiveQRCode;
    //设置图片视图的圆角边框效果
    //showImgView.layer.masksToBounds = YES;
    //showImgView.layer.cornerRadius = 10.0;
    //showImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //showImgView.layer.borderWidth = 4.0;
}
- (void)layoutUI {
        //用于生成二维码的字符串source
         NSString *source = @"www.baidu.com";
   
        //使用iOS 7后的CIFilter对象操作，生成二维码图片imgQRCode（会拉伸图片，比较模糊，效果不佳）
         CIImage *imgQRCode = [LHMCode createQRCodeImage:source];
    
        //使用核心绘图框架CG（Core Graphics）对象操作，进一步针对大小生成二维码图片imgAdaptiveQRCode（图片大小适合，清晰，效果好）
        UIImage *imgAdaptiveQRCode = [LHMCode resizeQRCodeImage:imgQRCode withSize:_LHMImageView.frame.size.width];
    
       //默认产生的黑白色的二维码图片；我们可以让它产生其它颜色的二维码图片，例如：蓝白色的二维码图片
        //imgAdaptiveQRCode = [LHMCode specialColorImage:imgAdaptiveQRCode withRed:0 green:0 blue:0]; //0~255
    
        //使用核心绘图框架CG（Core Graphics）对象操作，创建带圆角效果的图片
        UIImage *imgIcon = [UIImage createRoundedRectImage:[UIImage imageNamed:@"min.jpg"]withSize:CGSizeMake(50, 50)withRadius:10];
        //使用核心绘图框架CG（Core Graphics）对象操作，合并二维码图片和用于中间显示的图标图片
         imgAdaptiveQRCode = [LHMCode addIconToQRCodeImage:imgAdaptiveQRCode withIcon:imgIcon withIconSize:imgIcon.size];
    
    //    imgAdaptiveQRCode = [KMQRCode addIconToQRCodeImage:imgAdaptiveQRCode
    //                                              withIcon:imgIcon
    //                                             withScale:3];
    
         _LHMImageView.image = imgAdaptiveQRCode;
         //设置图片视图的圆角边框效果
         _LHMImageView.layer.masksToBounds = YES;
         _LHMImageView.layer.cornerRadius = 10.0;
         _LHMImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _LHMImageView.layer.borderWidth = 4.0;
     }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
