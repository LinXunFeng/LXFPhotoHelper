//
//  ViewController.m
//  LXFPhotoHelper
//
//  Created by 林洵锋 on 2017/4/21.
//  Copyright © 2017年 林洵锋. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "LXFPhotoHelper.h"

@interface ViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/** imageView */
@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    _imageView = imgView;
    imgView.backgroundColor = [UIColor redColor];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    CGFloat imgW = SCREEN_WIDTH * 0.5;
    CGFloat imgH = SCREEN_HEIGHT * 0.5;
    CGFloat imgX = (SCREEN_WIDTH - imgW) * 0.5;
    CGFloat imgY = (SCREEN_HEIGHT - imgH) * 0.5;
    imgView.frame = CGRectMake(imgX, imgY, imgW, imgH);
    [self.view addSubview:imgView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 创建UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"相册");
        [self getSourceWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"相机");
        [self getSourceWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    // 弹出
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)getSourceWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    
    LXFPhotoConfig *config = [[LXFPhotoConfig alloc] init];
    config.navBarTintColor = [UIColor greenColor];
    config.navBarBgColor = [UIColor purpleColor];
    config.navBarTitleColor = [UIColor yellowColor];
    
    [[LXFPhotoHelper creatWithSourceType:sourceType config:config] getSourceWithSelectImageBlock:^(id data) {
        if ([data isKindOfClass:[UIImage class]]) { // 图片
            [self.imageView setImage:(UIImage *)data];
        } else {
            NSLog(@"所选内容非图片对象");
        }
    }];
}


@end
