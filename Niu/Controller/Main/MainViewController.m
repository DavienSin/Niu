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
    navController.navigationBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addNewSpoce)];
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
    NSString *token = [XYQNToken createTokenWithScope:@"datest3" accessKey:@"8Z-kuG8I94-2wxVDUgHYM6bMeZA1QvZK1uba44E1" secretKey:@"unhxmNvwA3Gwolf2HXPQolUNVaZdVKCyJpBnTrsR"];
   
    NiuRequest *request = [[NiuRequest alloc] init];
//    [request createUploadBlockWithSize:token blockData:a[0] blockSize:4194304 progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"%@",uploadProgress);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
    NSData *d = a[1];
    [request uploadBlockWithCtx:token blockData:[d subdataWithRange:NSMakeRange(0, 1024)] ctx:@"VfPHEsLBAOqF95NdRUaybQGLmXen91opF4wtnQGZrZ0ywRnWv7xDcIofpJ98fCRwSIl6WEiNckiDPfYwnwAAdQ5Ii5wkcAEAAEiJDQotLUJvdW5kYXJ5KzEzNUM0MzQ2MkQzMzZFODgtLQ0KBT8AAAD__z8AAAAAAAAAQAD__z8AAQAAAHFOM2NCQUFBQUFBRUhBTUFqR2Y0Rl9fX1B3QT0=" nextChunkOffset:4194303 progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
}




@end
