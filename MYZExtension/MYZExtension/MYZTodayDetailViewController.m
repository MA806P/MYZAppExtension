//
//  MYZTodayDetailViewController.m
//  MYZExtension
//
//  Created by MA806P on 2017/10/12.
//  Copyright © 2017年 myz. All rights reserved.
//

#import "MYZTodayDetailViewController.h"

@interface MYZTodayDetailViewController ()

@end

@implementation MYZTodayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, self.view.frame.size.width-40, 100)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    label.text = self.contentString;
    [self.view addSubview:label];
}




@end
