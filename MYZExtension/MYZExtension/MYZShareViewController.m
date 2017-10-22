//
//  MYZShareViewController.m
//  MYZExtension
//
//  Created by MA806P on 2017/10/22.
//  Copyright © 2017年 myz. All rights reserved.
//

#import "MYZShareViewController.h"

@interface MYZShareViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * tableDataArray;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIRefreshControl * refresh;

@end

@implementation MYZShareViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSUserDefaults * shareUserDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.myzShareGroup"];
    NSArray * shareArray = [shareUserDefault objectForKey:@"ShareGroup"];
    self.tableDataArray = [NSMutableArray arrayWithArray:shareArray];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;

    UIRefreshControl * refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refresh];
    self.refresh = refresh;
}


- (void)refreshTableView {
    
    [self.refresh beginRefreshing];
    
    NSUserDefaults * shareUserDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.myzShareGroup"];
    NSArray * shareArray = [shareUserDefault objectForKey:@"ShareGroup"];
    [self.tableDataArray removeAllObjects];
    [self.tableDataArray addObjectsFromArray:shareArray];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refresh endRefreshing];
        [self.tableView reloadData];
    });
    
}
                           
               


#pragma mark - UITableView dataSource, delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MYZAPPTableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MYZAPPTableViewCellID"];
    }
    
    NSDictionary * dataDict = self.tableDataArray[indexPath.row];
    if ([dataDict[@"type"] isEqualToString:@"share_image"]) {
        cell.imageView.image = [UIImage imageWithData:dataDict[@"image_data"]];
        cell.textLabel.text = dataDict[@"title"];
        cell.detailTextLabel.text = dataDict[@"content"];
    } else if ([dataDict[@"type"] isEqualToString:@"share_url"]) {
        cell.imageView.image = nil;
        cell.textLabel.text = dataDict[@"title"];
        cell.detailTextLabel.text = dataDict[@"content"];
    } else {
        cell.imageView.image = nil;
        cell.textLabel.text = nil;
        cell.detailTextLabel.text = nil;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableDataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        NSUserDefaults *shareUserDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.myzShareGroup"];
        [shareUserDefault setValue:self.tableDataArray forKey:@"ShareGroup"];
    }
}



@end
