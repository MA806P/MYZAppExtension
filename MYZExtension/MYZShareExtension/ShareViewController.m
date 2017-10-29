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
    
    //this show one the view pop after clik the share button
    self.title = @"MYZShare";
    
}

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    
    return YES;
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    
    //public.jpeg
    //public.url
    //public.plain-text
    
    NSMutableArray * shareContentArray = [NSMutableArray array];
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.myzShareGroup"];
    NSMutableArray * oldShareData = [userDefaults objectForKey:@"ShareGroup"];
    if ([oldShareData isKindOfClass:[NSArray class]] && oldShareData.count > 0) {
        [shareContentArray addObjectsFromArray:oldShareData];
    }
    
    
    __weak typeof(self) weakSelf = self;
    [self.extensionContext.inputItems enumerateObjectsUsingBlock:^(NSExtensionItem * _Nonnull extItem, NSUInteger idx, BOOL * _Nonnull stop) {
        [extItem.attachments enumerateObjectsUsingBlock:^(NSItemProvider * _Nonnull itemProvider, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([itemProvider hasItemConformingToTypeIdentifier:@"public.url"]) {
                [itemProvider loadItemForTypeIdentifier:@"public.url"
                                                options:nil
                                      completionHandler:^(NSURL *  _Nullable item, NSError * _Null_unspecified error) {
                                          //NSLog(@"url === %@", item);
                                          if (item) {
                                              NSDictionary * urlDict = @{@"type":@"share_url", @"title":weakSelf.textView.text, @"content":item.absoluteString};
                                              [shareContentArray addObject:urlDict];
                                              
                                              NSUserDefaults *shareUserDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.myzShareGroup"];
                                              [shareUserDefault setValue:shareContentArray forKey:@"ShareGroup"];
                                          }
                                      }];

            } else if ([itemProvider hasItemConformingToTypeIdentifier:@"public.jpeg"]) {

                [itemProvider loadItemForTypeIdentifier:@"public.jpeg"
                                                options:nil
                                      completionHandler:^(NSData *  _Nullable item, NSError * _Null_unspecified error) {
                                          //NSLog(@"jpeg === %@", item);
                                          
                                          if (item) {
                                              NSDictionary * imageDict = @{@"type":@"share_image", @"title":weakSelf.textView.text, @"content":@"", @"image_data":item};
                                              [shareContentArray addObject:imageDict];
                                              
                                              NSUserDefaults *shareUserDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.myzShareGroup"];
                                              [shareUserDefault setValue:shareContentArray forKey:@"ShareGroup"];
                                          }
                                          
                                      }];
            }

        }];

    }];
    
    [self.extensionContext completeRequestReturningItems:self.extensionContext.inputItems completionHandler:nil];
    
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    
//    SLComposeSheetConfigurationItem * item= [[SLComposeSheetConfigurationItem alloc] init];
//    item.title = @"zhishiyinweizai renqunzhong ";
//    item.value = @"yes";
    
    return @[];
}

@end
