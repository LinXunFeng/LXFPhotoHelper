# LXFPhotoHelper

一行代码实现调用系统相机与相册，可配置导航栏背景与字体颜色

简书链接： [iOS - 一行代码实现调用系统相机与相册，可配置导航栏背景与字体颜色](http://www.jianshu.com/p/2e3a75aab4f1)

## 自定义样式

```objc
// 配置
LXFPhotoConfig *config = [[LXFPhotoConfig alloc] init];
config.navBarTintColor = [UIColor greenColor];
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
![image](https://github.com/LinXunFeng/LXFPhotoHelper/raw/master/Screenshots/1.png)


## 默认样式
默认样式可避免自定义导航栏后出现的问题（导航栏背景、标题、按键皆为白色，看不清楚）

```objc
// config 传入 nil
[[LXFPhotoHelper creatWithSourceType:sourceType config:nil] getSourceWithSelectImageBlock:^(id data) {
    if ([data isKindOfClass:[UIImage class]]) { // 图片
        [self.imageView setImage:(UIImage *)data];
    } else {
        NSLog(@"所选内容非图片对象");
    }
}];
```

![image](https://github.com/LinXunFeng/LXFPhotoHelper/raw/master/Screenshots/2.png)



