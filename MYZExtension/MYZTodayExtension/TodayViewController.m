//
//  TodayViewController.m
//  MYZTodayExtension
//
//  Created by MA806P on 2017/10/12.
//  Copyright © 2017年 myz. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

static CGFloat const kRowHeiht = 110;

@interface TodayViewController () <NCWidgetProviding, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, copy) NSArray * rowArray;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;//支持折叠,展开
    
    NSUserDefaults * groupDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.myzTodayGroup"];
    self.rowArray = [groupDefault objectForKey:@"myzTodayDataArray"];
    
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kRowHeiht*3.0) style:UITableViewStylePlain];
    tableView.rowHeight = kRowHeiht;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rowArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MYZTodayTableViewCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MYZTodayTableViewCellID"];
    }
    cell.textLabel.text = self.rowArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.extensionContext openURL:[NSURL URLWithString:[NSString stringWithFormat:@"myzwidget://%@",self.rowArray[indexPath.row]]] completionHandler:nil];
}


/**
 activeDisplayMode有以下两种
 NCWidgetDisplayModeCompact, // 收起模式
 NCWidgetDisplayModeExpanded, // 展开模式
 */
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    
    if(activeDisplayMode == NCWidgetDisplayModeCompact) {
        self.preferredContentSize = CGSizeMake(0, 110);
    } else {
        self.preferredContentSize = CGSizeMake(0, kRowHeiht*3.0);
    }
}



- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNewData);
}

@end
