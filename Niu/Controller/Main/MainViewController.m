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
    
   // [self loadNavigationBar];
  //  [self getScpoeList];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"12" ofType:@"jpg"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [NSData cutDataIntoBlockWithSize:data blockSize:4096];
    
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
    
}




@end
