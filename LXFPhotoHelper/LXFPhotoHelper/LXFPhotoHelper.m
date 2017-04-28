//
//  LXFPhotoHelper.m
//  LXFPhotoHelper
//
//  Created by 林洵锋 on 2017/4/21.
//  Copyright © 2017年 林洵锋. All rights reserved.
//

#import "LXFPhotoHelper.h"
#import <MobileCoreServices/MobileCoreServices.h>

#pragma mark - LXFPhotoDelegateHelper
@interface LXFPhotoDelegateHelper: NSObject  <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, copy) LXFPhotoHelperBlock selectImageBlock;

@end

@implementation LXFPhotoDelegateHelper

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]) {    // 图片
        UIImage *image = nil;
        if ([picker allowsEditing]) {   // 允许修改
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {    // 不允许修改
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        if (_selectImageBlock) {
            _selectImageBlock(image);
        }
    } else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {  // 视频
        NSURL *mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
        if (_selectImageBlock) {
            _selectImageBlock(mediaURL);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end

/** ====================================================================== */

#pragma mark - LXFPhotoHelper
@interface LXFPhotoHelper()

/** delegateHelper */
@property(nonatomic, strong) LXFPhotoDelegateHelper *delegateHelper;

@end

@implementation LXFPhotoHelper

/**
 *  @param sourceType       类型
 */
+ (instancetype)creatWithSourceType:(UIImagePickerControllerSourceType)sourceType config:(LXFPhotoConfig *)config {
    // 创建
    LXFPhotoHelper *imagePicker = [[LXFPhotoHelper alloc] init];
    imagePicker.delegateHelper = [[LXFPhotoDelegateHelper alloc] init];
    imagePicker.delegate = imagePicker.delegateHelper;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
    } else {
        imagePicker.sourceType = sourceType;
    }

    // 配置
    UIColor *navBarTintColor  = nil;
    UIColor *navBarBgColor    = nil;
    UIColor *navBarTitleColor = nil;
    BOOL allowsEditing = NO;
    
    navBarTintColor = config && config.navBarTintColor ?  config.navBarTintColor : [UIColor colorWithRed:0.21 green:0.57 blue:0.98 alpha:1.0];
    navBarBgColor = config && config.navBarBgColor ? config.navBarBgColor : [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0];
    navBarTitleColor = config && config.navBarTitleColor ? config.navBarTitleColor : [UIColor blackColor];
    allowsEditing = config && config.allowsEditing;
    
    imagePicker.allowsEditing = allowsEditing;
    [imagePicker.navigationBar setBarTintColor:navBarBgColor];
    [imagePicker.navigationBar setTranslucent:NO];
    [imagePicker.navigationBar setTintColor:navBarTintColor];
    [imagePicker.navigationBar setBackgroundColor:navBarBgColor];
    // 设置字体颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = navBarTitleColor;
    [imagePicker.navigationBar setTitleTextAttributes:attrs];
    
    return imagePicker;
}

/**
 *  选择照片后回调
 */
- (void)getSourceWithSelectImageBlock:(LXFPhotoHelperBlock)selectImageBlock {
    self.delegateHelper.selectImageBlock = selectImageBlock;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self animated:YES completion:nil];
}

@end

/** ====================================================================== */

#pragma mark - LXFPhotoConfig
@implementation LXFPhotoConfig

@end

