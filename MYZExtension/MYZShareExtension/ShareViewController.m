//
//  ShareViewController.m
//  MYZShareExtension
//
//  Created by MA806P on 2017/10/19.
//  Copyright © 2017年 myz. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"********* viewDidLoad");
//    [self.textView resignFirstResponder];
//    UIViewController * vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor redColor];
//    [self presentViewController:vc animated:YES completion:nil];
}

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    NSLog(@"*********isContentValid");
    return YES;
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
    NSLog(@"************didSelectPost");
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    
//    SLComposeSheetConfigurationItem * item= [[SLComposeSheetConfigurationItem alloc] init];
//    item.title = @"zhishiyinweizai renqunzhong ";
//    item.value = @"yes";
    
    
    NSLog(@"**********configurationItems");
    return @[];
}

@end
