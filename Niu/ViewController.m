//
//  ViewController.m
//  Niu
//
//  Created by Davien Sin on 2022/11/6.
//

#import "ViewController.h"
#import "MainTableView.h"
#import "NiuStorage.h"
#import "NiuRequest.h"
#import "NavigationController.h"
#include <Qiniu/QiniuSDK.h>


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) MainTableView *tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  [self loadTableView];
    
    
  //  [self loadNavigationBar];
    
   // [self getScpoeList];
}

-(void)dd{
    
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
    return 1;
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
    return cell;
}

// select the special cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)addNewSpoce{
    
}




@end
