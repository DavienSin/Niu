//
//  ViewController.m
//  Niu
//
//  Created by Davien Sin on 2022/11/6.
//

#import "MainViewController.h"
#import "MainTableView.h"
#import "NiuStorage.h"
#import "NiuRequest.h"
#import "NavigationController.h"
#import "UploadViewController.h"
#import "NSData+block.h"
#import "XYQNToken.h"


@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) MainTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
//@property (nonatomic,strong) NSString *token;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self loadTableView];
    
    //_dataSource = [[NSMutableArray alloc] initWithArray:@[@"datest3"]];
    
    [self loadNavigationBar];
  //  [self getScpoeList];
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)getScpoeList{
    NiuRequest *request =  [[NiuRequest alloc] init];
    [request getSpoceListFromServerWithKey:@"" secretKey:@""];
}

-(void)loadNavigationBar{
    NavigationController *navController = (NavigationController *)self.navigationController;
    navController.navigationBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"uploadFile" style:UIBarButtonItemStylePlain target:self action:@selector(addNewSpoce)];
    
    navController.navigationBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"uploadImage" style:UIBarButtonItemStylePlain target:self action:@selector(test)];
    
}


// init the tableView
-(void)loadTableView{
    _tableView = [[MainTableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = [UIScreen mainScreen].bounds;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"d"];
    [self.view addSubview:_tableView];
}

// return the number of the special section
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

// return the tableView's section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// display cell's data
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"d";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];      //   1
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: identifier];    //  2
    }
    
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

// select the special cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UploadViewController *uploadController = [[UploadViewController alloc] init];
   // uploadController.navigationController.navigationBar = _dataSource[indexPath.row];
    [self.navigationController pushViewController:uploadController animated:YES];
}

-(void)addNewSpoce{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"13" ofType:@"tar"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *a = [NSData cutDataIntoBlockWithSize:data blockSize:1024 * 1024 * 4];
    NSString * token = [XYQNToken createTokenWithScope:@"datest3" accessKey:@"8Z-kuG8I94-2wxVDUgHYM6bMeZA1QvZK1uba44E1" secretKey:@"unhxmNvwA3Gwolf2HXPQolUNVaZdVKCyJpBnTrsR"];
   
    NiuRequest *request = [[NiuRequest alloc] init];

    __block NSString *uploadId;
    [request initiateMultipartUpload:token BucketName:@"datest3" EncodedObjectName:@"" progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"operation1----->%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *respone = responseObject;
        uploadId = respone[@"uploadId"];
        NSLog(@"%@",respone);
        [self uploadBlock:token fileData:a BucketName:@"datest3" EncodedObjectName:@"" UploadId:uploadId];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"operation1----->%@",error);
    }];

}

-(void)uploadBlock:(NSString *)token fileData:(NSArray *)data BucketName:(NSString *)bucketName EncodedObjectName:(NSString *)encodedObjectName UploadId:(NSString *)uploadId{
    NiuRequest *request = [[NiuRequest alloc] init];
    NSMutableArray *relayOperations = [[NSMutableArray alloc] init];
    NSBlockOperation *relayOperation;
    __block NSMutableArray *parts = [[NSMutableArray alloc] init];
    __block NSInteger PartNumber = 1;
    //forin 结果出来是无序的
    
    for(NSInteger i = 1;i < data.count + 1;i++){
        NSBlockOperation *temp = [NSBlockOperation blockOperationWithBlock:^{
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            [request uploadPart:token fileData:data[i-1] BucketName:@"datest3" EncodedObjectName:@"" UploadId:uploadId PartNumber:PartNumber progress:^(NSProgress * _Nonnull uploadProgress) {
              //  NSLog(@"operation----->%@",uploadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [parts addObject:@{@"partNumber":[NSNumber numberWithInteger:PartNumber],@"etag":responseObject[@"etag"]}];
                PartNumber++;
                dispatch_semaphore_signal(sema);
                if([data.lastObject isEqualToData:data[i-1]]){
                    [self completeMultipartUpload:token BucketName:@"datest3" EncodedObjectName:@"" UploadId:uploadId parts:parts isCompleted:YES];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"operation1----->%@",error);
            }];
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }];
        if(relayOperation){
            [temp addDependency:relayOperation];
        }else{
            relayOperation = temp;
        }
        [relayOperations addObject:temp];
    }
    
   NSOperationQueue *queue = [[NSOperationQueue alloc] init];
   [queue addOperations:relayOperations waitUntilFinished:NO];
}



-(void)completeMultipartUpload:(NSString *)token BucketName:(NSString *)bucketName EncodedObjectName:(NSString *)encodedObjectName UploadId:(NSString *)uploadId parts:(NSArray *)parts isCompleted:(BOOL)isCompleted{
    // 完成文件上传
    if(isCompleted){
        NiuRequest *request = [[NiuRequest alloc] init];
       [request completeMultipartUpload:token BucketName:@"datest3" EncodedObjectName:@"" UploadId:uploadId parts:parts fname:@"gg" mimeType:@"tar" progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"%@",uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
}

//-(void)getPartList:(NSInteger)sender{
//    NiuRequest *req = [[NiuRequest alloc] init];
//        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//        [req getPartList:token BucketName:@"datest3" EncodedObjectName:@"" UploadId:@"637c8ebc1051db82bdc22d59region02z2" maxparts:@[] partNumberMarker:@"" progress:^(NSProgress * _Nonnull uploadProgress) {
//            //NSLog(@"%@",uploadProgress);
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            dispatch_semaphore_signal(sema);
//            NSLog(@"%lu",sender);
//          //  NSLog(@"%@",responseObject);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        //    NSLog(@"%@",error);
//            NSLog(@"%lu",sender);
//
//            dispatch_semaphore_signal(sema);
//        }];
//        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//
//
//}

-(void)test{
    UploadViewController *uploadController = [[UploadViewController alloc] init];
   [self.navigationController pushViewController:uploadController animated:YES];
}


@end
