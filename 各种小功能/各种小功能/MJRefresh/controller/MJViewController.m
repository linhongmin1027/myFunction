//
//  MJViewController.m
//  各种小功能
//
//  Created by iOSDev on 17/4/5.
//  Copyright © 2017年 iOSDev. All rights reserved.
//

#import "MJViewController.h"

#import <objc/runtime.h>
@interface MJViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end
static NSString * tableViewCellId=@"tableViewCellId";
static char kUITableViewIndexKey;
@implementation MJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self.view addSubview:self.tableview];
    
}
-(void)setupData{
    _dataArray=[NSMutableArray arrayWithObjects:@"仿熊猫TV",@"仿熊猫TV",@"仿熊猫TV",@"仿熊猫TV",@"仿熊猫TV",@"仿熊猫TV",@"仿熊猫TV",@"仿熊猫TV",@"仿熊猫TV",@"仿熊猫TV",@"仿熊猫TV", nil];



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
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"这是xx楼" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    objc_setAssociatedObject(alert, &kUITableViewIndexKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [alert show];
    return cell;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSIndexPath *indexPath = objc_getAssociatedObject(alertView, &kUITableViewIndexKey);
        NSLog(@"%@", indexPath);
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
    
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
