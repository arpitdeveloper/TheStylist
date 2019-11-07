//
//  WelcomController.m
//  TheStylist
//
//  Created by Apple on 16/02/19.
//  Copyright © 2019 Rajesh Shinde. All rights reserved.
//

#import "WelcomController.h"
#import "SingUpController.h"
@interface WelcomController ()
@property (weak, nonatomic) IBOutlet UIButton *me_btn;

@end

@implementation WelcomController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)meAction:(id)sender {
    
    SingUpController *sign = [self.storyboard instantiateViewControllerWithIdentifier:@"SingUpController"];
    [self.navigationController pushViewController:sign animated:NO];
}

@end
