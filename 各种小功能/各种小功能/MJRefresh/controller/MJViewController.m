//
//  MJViewController.m
//  各种小功能
//
//  Created by iOSDev on 17/4/5.
//  Copyright © 2017年 iOSDev. All rights reserved.
//

#import "MJViewController.h"
#import "MJRefresh.h"
#import <objc/runtime.h>
@interface MJViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end
static NSString * tableViewCellId=@"tableViewCellId";

@implementation MJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self.view addSubview:self.tableview];
    
}
-(void)setupData{
    _dataArray=[NSMutableArray arrayWithObjects:@"gif图片",@"仿新浪微博",@"仿虎牙",@"仿饿了么",@"仿斗鱼TV",@"仿哔哩哔哩",@"仿熊猫TV",@"仿熊猫TV",@"仿熊猫TV",@"仿熊猫TV",@"仿熊猫TV", nil];



}
-(UITableView *)tableview{
    if (!_tableview) {
        UITableView *tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        tableView.delegate=self;
        tableView.dataSource=self;
        _tableview=tableView;
        
    }
    return _tableview;
}
#pragma mark--UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableViewCellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellId];
    }
    cell.textLabel.text=_dataArray[indexPath.row];
  
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        NSArray *imageArray=@[[UIImage imageNamed:@"效果1.1"],[UIImage imageNamed:@"效果1.2"],[UIImage imageNamed:@"效果1.3"]];
        MJRefreshGifHeader *header=[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshController)];
        [header setImages:imageArray forState: MJRefreshStateIdle];
        [header setImages:imageArray forState: MJRefreshStatePulling];
        [header setImages:imageArray forState: MJRefreshStateRefreshing];
        header.stateLabel.hidden=YES;
        header.lastUpdatedTimeLabel.hidden=YES;
        tableView.mj_header=header;
  
    }else if (indexPath.row==1){
        
        
    
    }else if (indexPath.row==2){
        
        
    }
    else if (indexPath.row==3){
        
        
    }
    else if (indexPath.row==4){
        
    }
    else if (indexPath.row==5){
        
    }






}
-(void)refreshController{
    [self.tableview.mj_header endRefreshing];




}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
