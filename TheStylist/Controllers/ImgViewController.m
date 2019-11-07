//
//  ImgViewController.m
//  TheStylist
//
//  Created by Apple on 16/02/19.
//  Copyright © 2019 Rajesh Shinde. All rights reserved.
//

#import "ImgViewController.h"

#import <FirebaseStorage.h>

@interface ImgViewController ()

{
    
    NSMutableArray *imageArray;
    
}

@property (strong, nonatomic) IBOutlet UIImageView *first_iv;
@property (strong, nonatomic) IBOutlet UIImageView *second_iv;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loader;

@end

@implementation ImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //---alloc init----
    imageArray = [[NSMutableArray alloc] init];
    
    //-----Design-------
    [self imageviewSet:_first_iv];
    [self imageviewSet:_second_iv];

    _loader.layer.cornerRadius = 15;
    
    //-------Show and hide--------
    [_loader setHidden:YES];
     [self.navigationController setNavigationBarHidden:YES];

    //-------Method calling-------
    
    if ([[_allDict valueForKey:@"event"] isEqualToString:@"ANY EVENT"]) {
     
        if ([[_allDict valueForKey:@"skin"] isEqualToString:@"BLACK"]) {
           
             [self firebaseCallingWithImageName:@"black.jpg" secondImage:@"black2.jpg"];
        }
    
        else if ([[_allDict valueForKey:@"skin"] isEqualToString:@"LIGHT"]) {
            
            [self firebaseCallingWithImageName:@"light.jpg" secondImage:@"light2.jpg"];
        }
        else if ([[_allDict valueForKey:@"skin"] isEqualToString:@"BROWN"]) {
            
            [self firebaseCallingWithImageName:@"brown.jpeg" secondImage:@"brown.jpg"];
        }
    
        else if ([[_allDict valueForKey:@"skin"] isEqualToString:@"FAIR"]) {
            
            [self firebaseCallingWithImageName:@"fair.jpeg" secondImage:@"fair.jpg"];
        }
        else if ([[_allDict valueForKey:@"skin"] isEqualToString:@"TAN"]) {
            
            [self firebaseCallingWithImageName:@"tan.jpg" secondImage:@"tan2.jpg"];
        }
        else if ([[_allDict valueForKey:@"skin"] isEqualToString:@"MEDIUM"]) {
            
            [self firebaseCallingWithImageName:@"medium.jpg" secondImage:@"medium2.jpg"];
        }
        else if ([[_allDict valueForKey:@"skin"] isEqualToString:@"OLIVE"]) {
            
            [self firebaseCallingWithImageName:@"olive.jpg" secondImage:@"olive2.jpg"];
        }
        else if ([[_allDict valueForKey:@"skin"] isEqualToString:@"DARK BROWN"]) {
            
            [self firebaseCallingWithImageName:@"images.jpeg" secondImage:@"02.jpg"];
        }
        
    }
    else if ([[_allDict valueForKey:@"event"] isEqualToString:@"BITHDAY PARTY"]) {
        
        [self firebaseCallingWithImageName:@"birth.jpeg" secondImage:@"birth2.jpeg"];
    }
    
    else if ([[_allDict valueForKey:@"event"] isEqualToString:@"WEDDING PARTY"]) {
        
        [self firebaseCallingWithImageName:@"wedding.jpg" secondImage:@"wedding2.jpg"];
    }
   //-----------------------------------
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - --------Firebase calling---------

-(void)firebaseCallingWithImageName:(NSString *)firstName secondImage:(NSString *)secondName{
 
    [self startAminamting];
    
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *storageRef = [storage reference];
    
    [[storageRef child:[NSString stringWithFormat:@"images/%@", firstName]] dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData *data, NSError *error) {
        
        [self stopAnimating];
        
        if (error != nil) {
            NSLog(@"ERRor ....%@", error.description);
        }
        else{
            
             self.first_iv.image = [UIImage imageWithData:data];
        }

    }];

    [[storageRef child:[NSString stringWithFormat:@"images/%@", secondName]] dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData *data, NSError *error) {
        
        [self stopAnimating];
        
        if (error != nil) {
            NSLog(@"ERRor ....%@", error.description);
        }
        else{
       
            self.second_iv.image = [UIImage imageWithData:data];
        }
    }];
}

-(void)startAminamting{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [_loader setHidden:NO];
    [_loader startAnimating];
}
-(void)stopAnimating{
    [_loader stopAnimating];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [_loader setHidden:YES];
}
#pragma mark - --------Image editing method--------------

-(void)imageviewSet:(UIImageView *)img{
    img.layer.shadowColor = [UIColor grayColor].CGColor;
    img.layer.shadowOffset = CGSizeMake(0, 0);
    img.layer.shadowOpacity = 1;
    img.layer.shadowRadius = 5;
}


#pragma mark - ---------Button Action---------------


- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
   
}


@end
