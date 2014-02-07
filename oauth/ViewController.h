//
//  ViewController.h
//  oauth
//
//  Created by Yuhua Mai on 2/7/14.
//  Copyright (c) 2014 Yuhua Mai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleOAuth.h"

@interface ViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *arrProfileInfo;
@property (nonatomic, strong) NSMutableArray *arrProfileInfoLabel;
@property (nonatomic, strong) GoogleOAuth *googleOAuth;
@end
