//
//  ViewController.m
//  oauth
//
//  Created by Yuhua Mai on 2/7/14.
//  Copyright (c) 2014 Yuhua Mai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, GoogleOAuthDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)showProfile:(id)sender;
- (IBAction)revokeAccess:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    _arrProfileInfo = [[NSMutableArray alloc] init];
    _arrProfileInfoLabel = [[NSMutableArray alloc] init];
    
    _googleOAuth = [[GoogleOAuth alloc] initWithFrame:self.view.frame];
    [_googleOAuth setGOAuthDelegate:self];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrProfileInfo count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        
        [[cell textLabel] setFont:[UIFont fontWithName:@"Trebuchet MS" size:15.0]];
        [[cell textLabel] setShadowOffset:CGSizeMake(1.0, 1.0)];
        [[cell textLabel] setShadowColor:[UIColor whiteColor]];
        
        [[cell detailTextLabel] setFont:[UIFont fontWithName:@"Trebuchet MS" size:13.0]];
        [[cell detailTextLabel] setTextColor:[UIColor grayColor]];
    }
    
    [[cell textLabel] setText:[_arrProfileInfo objectAtIndex:[indexPath row]]];
    [[cell detailTextLabel] setText:[_arrProfileInfoLabel objectAtIndex:[indexPath row]]];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

- (IBAction)showProfile:(id)sender {
//    [_googleOAuth authorizeUserWithClienID:@"746869634473-hl2v6kv6e65r1ak0u6uvajdl5grrtsgb.apps.googleusercontent.com"
//                           andClientSecret:@"_FsYBVXMeUD9BGzNmmBvE9Q4"
//                             andParentView:self.view
//                                 andScopes:[NSArray arrayWithObjects:@"https://www.googleapis.com/auth/userinfo.profile", nil]
//     ];
    [_googleOAuth authorizeUserWithClienID:@"4881560502-uteihtgcnas28bcjmnh0hfrbk4chlmsa.apps.googleusercontent.com"
                           andClientSecret:@"R02t8Pk-59eEYy-B359-gvOY"
                             andParentView:self.view
                                 andScopes:[NSArray arrayWithObjects:@"https://www.googleapis.com/auth/youtube", @"https://www.googleapis.com/auth/youtube.readonly",@"https://www.googleapis.com/auth/youtubepartner",@"https://www.googleapis.com/auth/youtubepartner-channel-audit", nil]
     ];
}
- (IBAction)revokeAccess:(id)sender {
    [_googleOAuth revokeAccessToken];
}

-(void)authorizationWasSuccessful{
    [_googleOAuth callAPI:@"https://www.googleapis.com/youtube/v3/channels"
           withHttpMethod:httpMethod_GET
       postParameterNames:[NSArray arrayWithObjects:@"part",@"mine",nil] postParameterValues:[NSArray arrayWithObjects:@"contentDetails",@"true",nil]];
    
//    [_googleOAuth callAPI:@"https://www.googleapis.com/oauth2/v1/userinfo"
//           withHttpMethod:httpMethod_GET
//       postParameterNames:nil postParameterValues:nil];
}
-(void)accessTokenWasRevoked{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"Your access was revoked!"
                                                   delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    
    [_arrProfileInfo removeAllObjects];
    [_arrProfileInfoLabel removeAllObjects];
    
    [_tableView reloadData];
}
-(void)errorOccuredWithShortDescription:(NSString *)errorShortDescription andErrorDetails:(NSString *)errorDetails{
    NSLog(@"%@", errorShortDescription);
    NSLog(@"%@", errorDetails);
}


-(void)errorInResponseWithBody:(NSString *)errorMessage{
    NSLog(@"%@", errorMessage);
}
-(void)responseFromServiceWasReceived:(NSString *)responseJSONAsString andResponseJSONAsData:(NSData *)responseJSONAsData{
    NSError *error;
    NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseJSONAsData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&error];
    if (error) {
        NSLog(@"An error occured while converting JSON data to dictionary.");
        return;
    }
    NSLog(@"%@", dictionary);
    
//    if ([responseJSONAsString rangeOfString:@"family_name"].location != NSNotFound) {
//        NSError *error;
//        NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseJSONAsData
//                                                                          options:NSJSONReadingMutableContainers
//                                                                            error:&error];
//        if (error) {
//            NSLog(@"An error occured while converting JSON data to dictionary.");
//            return;
//        }
//        else{
//            if (_arrProfileInfoLabel != nil) {
//                _arrProfileInfoLabel = nil;
//                _arrProfileInfo = nil;
//                _arrProfileInfo = [[NSMutableArray alloc] init];
//            }
//            
//            _arrProfileInfoLabel = [[NSMutableArray alloc] initWithArray:[dictionary allKeys] copyItems:YES];
//            for (int i=0; i<[_arrProfileInfoLabel count]; i++) {
//                [_arrProfileInfo addObject:[dictionary objectForKey:[_arrProfileInfoLabel objectAtIndex:i]]];
//            }
//            
//            [_tableView reloadData];
//        }
//    }
}
@end
