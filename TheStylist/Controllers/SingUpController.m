//
//  SingUpController.m
//  TheStylist
//
//  Created by Apple on 16/02/19.
//  Copyright © 2019 Rajesh Shinde. All rights reserved.
//

#import "SingUpController.h"
#import "ListController.h"
#import <Firebase/Firebase.h>

@interface SingUpController ()

@property (weak, nonatomic) IBOutlet UITextField *name_TF;
@property (weak, nonatomic) IBOutlet UITextField *email_TF;
@property (weak, nonatomic) IBOutlet UITextField *phone_TF;

@property (weak, nonatomic) IBOutlet UIButton *next_btn;

@end

@implementation SingUpController

#pragma mark - --------Life cycle-------------

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - --------Button Action-------------


- (IBAction)nextAction:(id)sender {
    
    if ([_name_TF.text isEqualToString:@""] || [_email_TF.text isEqualToString:@""] || [_phone_TF.text isEqualToString:@""]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"Please fill out all section."
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if([self isEmailValid:_email_TF.text] == NO) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Please enter a valid email id." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:_name_TF.text forKey:@"fullName"];
        [defaults setObject:_email_TF.text forKey:@"email"];
        [defaults setObject:_phone_TF.text forKey:@"phone"];
        [defaults setBool:YES forKey:@"isLoggedIn"];
        [defaults synchronize];
        [[FIRAuth auth] createUserWithEmail:_email_TF.text password:_phone_TF.text completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
             if (error != nil) {
                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Email already exists" preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                 [alertController addAction:action];
                 NSLog(@"Error ...%@", error.description);
             }
             else{
                 ListController *list = [self.storyboard instantiateViewControllerWithIdentifier:@"ListController"];
                 [self.navigationController pushViewController:list animated:NO];
             }
         }];
        
    }
    
}

- (BOOL)isEmailValid:(NSString*)emailString {
    if([emailString length] == 0){
        return NO;
    }
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}

@end
