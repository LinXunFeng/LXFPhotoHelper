//
//  LXFPhotoHelper.h
//  LXFPhotoHelper
//
//  Created by 林洵锋 on 2017/4/21.
//  Copyright © 2017年 林洵锋. All rights reserved.
//

/*
 Localized resources can be mixed = YES         调用系统资源使用中文
 Privacy - Photo Library Usage Description      请求使用相册
 Privacy - Camera Usage Description             请求使用相机
 */


#import <UIKit/UIKit.h>
@class LXFPhotoConfig;

// data可能是image对象，也可能是视频的NSURL
typedef void(^LXFPhotoHelperBlock)(id data);

@interface LXFPhotoHelper : UIImagePickerController

/**
 *  @param sourceType  类型
 */
+ (instancetype)creatWithSourceType:(UIImagePickerControllerSourceType)sourceType config:(LXFPhotoConfig *)config;

/**
 *  选择照片后回调
 */
- (void)getSourceWithSelectImageBlock:(LXFPhotoHelperBlock)selectImageBlock;

@end


#pragma mark - LXFPhotoConfig
@interface LXFPhotoConfig: NSObject
/** 导航条颜色 */
@property(nonatomic, strong) UIColor *navBarBgColor;
/** item的tintcolor */
@property(nonatomic, strong) UIColor *navBarTintColor;
/** titleView的字体颜色 */
@property(nonatomic, strong) UIColor *navBarTitleColor;
/** 图片是否可以编辑 */
@property(nonatomic, assign) BOOL allowsEditing;

@end
