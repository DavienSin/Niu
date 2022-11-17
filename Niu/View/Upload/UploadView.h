//
//  UploadView.h
//  Niu
//
//  Created by Davien Sin on 2022/11/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UploadView : UIView

//选中的上传图片
@property (nonatomic,strong) UIImageView *imageView;

//上传按钮
@property (nonatomic,strong) UIButton *uploadBtn;

//打开相册按钮
@property (nonatomic,strong) UIButton *albumBtn;

//文件名字输入框
@property (nonatomic,strong) UITextField *nameField;

//成功上传后服务端返回的文件hash值
@property (nonatomic,strong) UILabel *hashLabel;

//成功上传后服务端返回的文件Key值
@property (nonatomic,strong) UILabel *keyLabel;

@end

NS_ASSUME_NONNULL_END
