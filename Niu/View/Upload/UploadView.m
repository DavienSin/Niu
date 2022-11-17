//
//  UploadView.m
//  Niu
//
//  Created by Davien Sin on 2022/11/17.
//

#import "UploadView.h"

@implementation UploadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


//初始化普通View
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        _uploadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_uploadBtn setTitle:@"上传" forState:0];
        [_uploadBtn setTitleColor:[UIColor blackColor] forState:0];
        [self addSubview:_uploadBtn];
        
        _albumBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_albumBtn setTitle:@"选择" forState:0];
        [_albumBtn setTitleColor:[UIColor blackColor] forState:0];
        [self addSubview:_albumBtn];
        
        _nameField = [[UITextField alloc] init];
        _nameField.placeholder = @"file名称(可选)";
        _nameField.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameField];
        
        _hashLabel = [[UILabel alloc] init];
        _hashLabel.text = @"hash:";
        [self addSubview:_hashLabel];
        
        _keyLabel = [[UILabel alloc] init];
        _keyLabel.text = @"key:";
        [self addSubview:_keyLabel];
        
    }
    return self;
}

@end
