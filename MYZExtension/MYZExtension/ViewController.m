//
//  ViewController.m
//  MYZExtension
//
//  Created by MA806P on 2017/10/12.
//  Copyright © 2017年 myz. All rights reserved.
//

#import "ViewController.h"
#import "MYZTodayDetailViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * tableDataArray;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) NSInteger dataIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataIndex = 4;
    self.tableDataArray = [[NSMutableArray alloc] initWithArray:@[@"1---", @"2---",@"3---"]];
    [self saveShareData];
    
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotificationFromToday:) name:@"MYZTodayActionNotification" object:nil];
    
}


#pragma mark - UITableView dataSource, delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MYZAPPTableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MYZAPPTableViewCellID"];
    }
    cell.textLabel.text = self.tableDataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MYZTodayDetailViewController * todayDetail = [[MYZTodayDetailViewController alloc] init];
    todayDetail.contentString = self.tableDataArray[indexPath.row];
    [self.navigationController pushViewController:todayDetail animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableDataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self saveShareData];
    }
}

#pragma mark - inside

- (void)saveShareData {
    
    NSUInteger index = MIN(self.tableDataArray.count, 3);
    NSArray * saveGroupDataArray = [self.tableDataArray subarrayWithRange:NSMakeRange(0, index)];
    
    NSUserDefaults * groupDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.myzTodayGroup"];
    [groupDefault setObject:saveGroupDataArray forKey:@"myzTodayDataArray"];
}

- (IBAction)addData:(id)sender {
    
    [self.tableDataArray addObject:[NSString stringWithFormat:@"%ld---",self.dataIndex++]];
    [self.tableView reloadData];
    [self saveShareData];
}


#pragma mark - outside

- (void)getNotificationFromToday:(NSNotification *)notification {
    
    MYZTodayDetailViewController * todayDetail = [[MYZTodayDetailViewController alloc] init];
    todayDetail.contentString = [NSString stringWithFormat:@"%@  \n From Today/Widget", notification.object];
    [self.navigationController pushViewController:todayDetail animated:YES];
}




@end
