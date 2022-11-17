//
//  UploadViewController.m
//  Niu
//
//  Created by Davien Sin on 2022/11/17.
//

#import "UploadViewController.h"
#import "UploadView.h"
#include <Masonry/Masonry.h>
#import "UIDevice+VGAddition.h"
#include <PhotosUI/PhotosUI.h>
#import "NiuRequest.h"

@interface UploadViewController ()<PHPickerViewControllerDelegate>
@property (nonatomic,strong) UploadView *uploadView;

@end

@implementation UploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadUploadView];
}

-(void)loadUploadView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _uploadView = [[UploadView alloc] init];
    [self.view addSubview:_uploadView];
    
    [_uploadView mas_makeConstraints:^(MASConstraintMaker *make) {
       CGFloat navHeight = [UIDevice vg_navigationFullHeight];
       make.top.equalTo(self.view.mas_top).offset(navHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [_uploadView.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(_uploadView);
        make.height.mas_equalTo(400);
    }];
    
    [_uploadView.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_uploadView.imageView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    
    [_uploadView.albumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_uploadView);
        make.top.equalTo(_uploadView.nameField.mas_bottom);
        make.height.mas_equalTo(50);
        CGFloat width = self.view.frame.size.width / 2;
        make.width.mas_equalTo(width);
    }];
    [_uploadView.albumBtn addTarget:self action:@selector(openAlbumActioin) forControlEvents:UIControlEventTouchDown];
    
    [_uploadView.uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_uploadView.albumBtn.mas_right);
        make.top.equalTo(_uploadView.nameField.mas_bottom);
        make.height.mas_equalTo(50);
        CGFloat width = self.view.frame.size.width / 2;
        make.width.mas_equalTo(width);
    }];
    [_uploadView.uploadBtn addTarget:self action:@selector(uploadAction) forControlEvents:UIControlEventTouchDown];
    
    [_uploadView.hashLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_uploadView.uploadBtn.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    [_uploadView.keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_uploadView.hashLabel.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
}

-(void)uploadAction{
    NiuRequest *request = [[NiuRequest alloc] init];
    NSData *data = UIImageJPEGRepresentation(_uploadView.imageView.image, 1);
    [request uploadFiletToSpoceWithoutName:data scope:@"datest3" progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%lld",uploadProgress.completedUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      //  NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]);
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

-(void)openAlbumActioin{
    if (@available(iOS 14, *)) {
        PHPickerConfiguration *pickerConfig = [[PHPickerConfiguration alloc] initWithPhotoLibrary:[PHPhotoLibrary sharedPhotoLibrary]];
        //过滤只显示图片，可选择只显示视频
        pickerConfig.filter = [PHPickerFilter imagesFilter];
        pickerConfig.selectionLimit = 1;
        
        PHPickerViewController *pickerVC = [[PHPickerViewController alloc] initWithConfiguration:pickerConfig];
        pickerVC.delegate = self;
        pickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:pickerVC animated:YES completion:^{}];
    } else {
        // Fallback on earlier versions
    }
    NSLog(@"openAlbum");
}

-(void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results API_AVAILABLE(ios(14)){
    if (results.count<=0) {//点击返回
            
        }else{
            PHPickerResult *imgResult = [results objectAtIndex:0];//可多选
            if ([imgResult.itemProvider canLoadObjectOfClass:UIImage.class]) {
                [imgResult.itemProvider loadObjectOfClass:[UIImage class] completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImage *image = object;
                        self.uploadView.imageView.image = image;
                    });
                }];
            }
        }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    NSLog(@"uploadController delloc");
}



@end
