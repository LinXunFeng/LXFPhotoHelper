# LXFPhotoHelper
一行代码实现调用系统相机与相册，可配置导航栏背景与字体颜色

```
// 配置
LXFPhotoConfig *config = [[LXFPhotoConfig alloc] init];
config.navBarTintColor = [UIColor blueColor];
config.navBarBgColor = [UIColor purpleColor];
config.navBarTitleColor = [UIColor yellowColor];

// sourceType : 
// UIImagePickerControllerSourceTypeCamera 
// UIImagePickerControllerSourceTypePhotoLibrary 等
[[LXFPhotoHelper creatWithSourceType:sourceType config:config] getSourceWithSelectImageBlock:^(id data) {
    if ([data isKindOfClass:[UIImage class]]) { // 图片
        [self.imageView setImage:(UIImage *)data];
    } else {
        NSLog(@"所选内容非图片对象");
    }
}];
```