//
//  LHMCode.m
//  各种小功能
//
//  Created by iOSDev on 17/3/11.
//  Copyright © 2017年 iOSDev. All rights reserved.
//

#import "LHMCode.h"

@implementation LHMCode
#pragma mark - Private Methods
void ProviderReleaseData (void *info, const void *data, size_t size){
        free((void*)data);
  }

 #pragma mark - Public Methods
+ (CIImage *)createQRCodeImage:(NSString *)source {
        NSData *data = [source dataUsingEncoding:NSUTF8StringEncoding];
   
        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        [filter setValue:data forKey:@"inputMessage"];
     [filter setValue:@"Q" forKey:@"inputCorrectionLevel"]; //设置纠错等级越高；即识别越容易，值可设置为L(Low) |  M(Medium) | Q | H(High)
    CIImage *image=filter.outputImage;
       return filter.outputImage;
    }

+ (UIImage *)resizeQRCodeImage:(CIImage *)image withSize:(CGFloat)size {
     
    //
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CGColorSpaceRelease(cs);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    UIImage *aImage = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    return aImage;

     }

+ (UIImage *)specialColorImage:(UIImage*)image withRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
        const int imageWidth = image.size.width;
        const int imageHeight = image.size.height;
         size_t bytesPerRow = imageWidth * 4;
        uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
        //Create context
         CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGContextRef contextRef = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
         CGContextDrawImage(contextRef, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
       //Traverse pixe
        int pixelNum = imageWidth * imageHeight;
       uint32_t* pCurPtr = rgbImageBuf;
        for (int i = 0; i < pixelNum; i++, pCurPtr++){
                if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
                        //Change color
                        uint8_t* ptr = (uint8_t*)pCurPtr;
                         ptr[3] = red; //0~255
                        ptr[2] = green;
                        ptr[1] = blue;
                   }else{
                           uint8_t* ptr = (uint8_t*)pCurPtr;
                            ptr[0] = 0;
                       }
             }
    
         //Convert to image
         CGDataProviderRef dataProviderRef = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
         CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpaceRef,kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProviderRef,NULL, true, kCGRenderingIntentDefault);
        CGDataProviderRelease(dataProviderRef);
        UIImage* img = [UIImage imageWithCGImage:imageRef];
    
         //Release
         CGImageRelease(imageRef);
         CGContextRelease(contextRef);
         CGColorSpaceRelease(colorSpaceRef);
        return img;
    }

 +(UIImage *)addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withIconSize:(CGSize)iconSize {
         UIGraphicsBeginImageContext(image.size);
         //通过两张图片进行位置和大小的绘制，实现两张图片的合并；其实此原理做法也可以用于多张图片的合并
         CGFloat widthOfImage = image.size.width;
         CGFloat heightOfImage = image.size.height;
         CGFloat widthOfIcon = iconSize.width;
         CGFloat heightOfIcon = iconSize.height;
    
         [image drawInRect:CGRectMake(0, 0, widthOfImage, heightOfImage)];
         [icon drawInRect:CGRectMake((widthOfImage-widthOfIcon)/2, (heightOfImage-heightOfIcon)/2,widthOfIcon, heightOfIcon)];
         UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
        UIGraphicsEndImageContext();
         return img;
     }

 +(UIImage *)addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withScale:(CGFloat)scale {
        UIGraphicsBeginImageContext(image.size);
    
        //通过两张图片进行位置和大小的绘制，实现两张图片的合并；其实此原理做法也可以用于多张图片的合并
        CGFloat widthOfImage = image.size.width;
         CGFloat heightOfImage = image.size.height;
        CGFloat widthOfIcon = widthOfImage/scale;
         CGFloat heightOfIcon = heightOfImage/scale;
     
        [image drawInRect:CGRectMake(0, 0, widthOfImage, heightOfImage)];
         [icon drawInRect:CGRectMake((widthOfImage-widthOfIcon)/2, (heightOfImage-heightOfIcon)/2,widthOfIcon, heightOfIcon)];
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
     
         UIGraphicsEndImageContext();
         return img;
     }
@end
