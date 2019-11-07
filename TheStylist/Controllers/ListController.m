//
//  ListController.m
//  TheStylist
//
//  Created by Apple on 16/02/19.
//  Copyright © 2019 Rajesh Shinde. All rights reserved.
//

#import "ListController.h"
#import "ImgViewController.h"

@interface ListController ()<UITableViewDelegate, UITableViewDataSource>

{
    NSMutableDictionary *allfilterDict;
    NSArray *heightArray;
    NSArray *weightArray;
    NSArray *hairArray;
    NSArray *eyeArray;
    NSArray *skinArray;
    NSArray *eventArray;
    BOOL isSelect;
    BOOL eyeSelect;
    BOOL hairSelect;
    BOOL skinSelect;
    BOOL heightSelect;
    BOOL weightSelect;
}

//----------Text Field---------------
@property (weak, nonatomic) IBOutlet UITextField *height_tf;
@property (weak, nonatomic) IBOutlet UITextField *weight_tf;
@property (weak, nonatomic) IBOutlet UITextField *hair_tf;
@property (weak, nonatomic) IBOutlet UITextField *eye_tf;
@property (weak, nonatomic) IBOutlet UITextField *skin_tf;
@property (weak, nonatomic) IBOutlet UITextField *event_tf;

//----------Button---------------
@property (weak, nonatomic) IBOutlet UIButton *next_btn;

//----------Table view---------------
@property (strong, nonatomic) IBOutlet UITableView *eventTV;
@property (strong, nonatomic) IBOutlet UITableView *skinTV;
@property (strong, nonatomic) IBOutlet UITableView *eyeTV;
@property (strong, nonatomic) IBOutlet UITableView *hairTV;
@property (strong, nonatomic) IBOutlet UITableView *weightTV;
@property (strong, nonatomic) IBOutlet UITableView *heightTV;

//----------Table Constraint---------------
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstant;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *weightConstant;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *hairConstant;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *eyeConstant;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *skinConstant;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *eventConstant;

@end

@implementation ListController
#pragma mark - -----------Life Cycle-------------

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //--------alloc init------
    allfilterDict = [[NSMutableDictionary alloc] init];
    
    //----------All BOOL Value--------
    isSelect = NO;
    eyeSelect = NO;
    hairSelect = NO;
    skinSelect = NO;
    heightSelect = NO;
    weightSelect = NO;
    
    //------Show and Hide-------
    [self.navigationController setNavigationBarHidden:YES];
    [_eventTV sizeToFit];
    [_eventTV setHidden:YES];
    [_skinTV setHidden:YES];
    [_eyeTV setHidden:YES];
    [_hairTV setHidden:YES];
    [_weightTV setHidden:YES];
    [_heightTV setHidden:YES];
    
    //-----design--------
    [self tableEdit:_eventTV];
    [self tableEdit:_skinTV];
    [self tableEdit:_eyeTV];
    [self tableEdit:_hairTV];
    [self tableEdit:_weightTV];
    [self tableEdit:_heightTV];
    
    [self textImage:_eye_tf imageName:@"rightArrow"];
    [self textImage:_event_tf imageName:@"rightArrow"];
    [self textImage:_skin_tf imageName:@"rightArrow"];
    [self textImage:_hair_tf imageName:@"rightArrow"];
    [self textImage:_weight_tf imageName:@"rightArrow"];
    [self textImage:_height_tf imageName:@"rightArrow"];

    //------All Array-----
    
    //Height-----
    NSArray *heightArray1 = @[@"59 Inch", @"61 Inch",@"62 Inch", @"64 Inch", @"66 Inch",@"68 Inch", @"70 Inch", @"72 Inch"];
    NSSortDescriptor *valueDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES];
    heightArray = [heightArray1 sortedArrayUsingDescriptors:@[valueDescriptor]];
    
    //Weight-----
    NSArray *weightArray1 = @[@"121 Pound", @"132 Pound",@"143 Pound", @"154 Pound", @"165 Pound",@"176 Pound", @"187 Pound", @"198 Pound"];
    NSSortDescriptor *valueDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES];
    weightArray = [weightArray1 sortedArrayUsingDescriptors:@[valueDescriptor1]];
    
    //Eye-----
    NSArray *eyeArray1 = @[@"GREEN", @"BLUE", @"BROWN", @"AMBER", @"GRAY", @"HAZAL", @"RED AND VIOLET"];
    NSSortDescriptor *valueDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES];
    eyeArray = [eyeArray1 sortedArrayUsingDescriptors:@[valueDescriptor2]];
    
    //Skin-----
    NSArray *skinArray1 = @[@"LIGHT",@"FAIR",@"MEDIUM",@"OLIVE",@"TAN",@"BROWN",@"DARK BROWN",@"BLACK"];
    NSSortDescriptor *valueDescriptor3 = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES];
    skinArray = [skinArray1 sortedArrayUsingDescriptors:@[valueDescriptor3]];
    
    //Event-----
    NSArray *eventArray1 = @[@"ANY EVENT", @"WEDDING PARTY",@"BITHDAY PARTY"];
    NSSortDescriptor *valueDescriptor4 = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES];
    eventArray = [eventArray1 sortedArrayUsingDescriptors:@[valueDescriptor4]];
    
    //Hair-----
    NSArray *hairArray1 = @[@"BLACK", @"BLONDE", @"BROWN", @"RED", @"GREY"];
    NSSortDescriptor *valueDescriptor5 = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES];
    hairArray = [hairArray1 sortedArrayUsingDescriptors:@[valueDescriptor5]];
   
}
-(void)viewWillAppear:(BOOL)animated{
    
    //----------All BOOL Value--------
    isSelect = NO;
    eyeSelect = NO;
    hairSelect = NO;
    skinSelect = NO;
    heightSelect = NO;
    weightSelect = NO;
}

-(void)viewDidLayoutSubviews
{
    //------height table--------
    CGFloat height = MIN(self.view.bounds.size.height, self.heightTV.contentSize.height);
    if (heightArray.count > 4) {
        self.heightConstant.constant = height - height/2;
    }
    else{
        self.heightConstant.constant = height;
    }
    
    //------weight table--------
    CGFloat weight = MIN(self.view.bounds.size.height, self.weightTV.contentSize.height);
    if (weightArray.count > 3) {
        self.weightConstant.constant = weight - weight/2;
    }else{
        self.weightConstant.constant = weight;
    }
    
    //------hair table--------
    CGFloat hair = MIN(self.view.bounds.size.height, self.hairTV.contentSize.height);
     if (hairArray.count > 4) {
        self.hairConstant.constant = hair - hair/2;
     }else{
         self.hairConstant.constant = hair;
     }
    
    //------eye table--------
    CGFloat eye = MIN(self.view.bounds.size.height, self.eyeTV.contentSize.height);
    if (eyeArray.count > 4) {
        self.eyeConstant.constant = eye - eye/2;
    }else{
        self.eyeConstant.constant = eye;
    }
    //------skin table--------
    CGFloat skin = MIN(self.view.bounds.size.height, self.skinTV.contentSize.height);
    if (skinArray.count > 4) {
        self.skinConstant.constant = skin - skin/2;
    }else{
      self.skinConstant.constant = skin;
    }

    //------event table--------
    CGFloat event = MIN(self.view.bounds.size.height, self.eventTV.contentSize.height);
    if (eventArray.count > 4) {
         self.eventConstant.constant = event - event/2;
    }else{
        self.eventConstant.constant = event;
    }
   
    
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - ----------Design Method-------------

-(void)textImage:(UITextField *)tf imageName:(NSString *)nam
{
    tf.rightViewMode = UITextFieldViewModeAlways;
    tf.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:nam]];
    tf.tintColor = [UIColor grayColor];
}

-(void)tableEdit:(UITableView *)img{
    
    img.layer.shadowColor = [UIColor grayColor].CGColor;
    img.layer.shadowOffset = CGSizeMake(3, 3);
    img.layer.shadowOpacity = 1;
    img.layer.shadowRadius = 5;
    img.layer.borderWidth = 0.5;
}
#pragma mark - --------Button Action-------------

- (IBAction)nextAction:(id)sender {
    
    if ([_eye_tf.text isEqualToString:@""] || [_hair_tf.text isEqualToString:@""] || [_event_tf.text isEqualToString:@""]|| [_height_tf.text isEqualToString:@""] || [_weight_tf.text isEqualToString:@""] || [_skin_tf.text isEqualToString:@""]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:@"Fill all the fields"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        ImgViewController *img = [self.storyboard instantiateViewControllerWithIdentifier:@"ImgViewController"];
        img.allDict = allfilterDict;
        [self.navigationController pushViewController:img animated:NO];
    }
}

#pragma mark - -----------Text Field Methods-------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField canResignFirstResponder]) {
        [textField resignFirstResponder];
    }
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    // add your method here
    
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    //--------------Event Text Field------------------
    if (textField == _event_tf) {
        
        if (isSelect == NO) {
            isSelect = YES;
            eyeSelect = NO;
            hairSelect = NO;
            skinSelect = NO;
            heightSelect = NO;
            weightSelect = NO;
            
            [_eventTV setHidden:NO];
            [_skinTV setHidden:YES];
            [_eyeTV setHidden:YES];
            [_hairTV setHidden:YES];
            [_weightTV setHidden:YES];
            [_heightTV setHidden:YES];
            
            [self textImage:_eye_tf imageName:@"rightArrow"];
            [self textImage:_event_tf imageName:@"downArrow"];
            [self textImage:_skin_tf imageName:@"rightArrow"];
            [self textImage:_hair_tf imageName:@"rightArrow"];
            [self textImage:_weight_tf imageName:@"rightArrow"];
            [self textImage:_height_tf imageName:@"rightArrow"];
            
        }
        else{
            isSelect = NO;
            eyeSelect = NO;
            hairSelect = NO;
            skinSelect = NO;
            heightSelect = NO;
            weightSelect = NO;
            
            [_eventTV setHidden:YES];
            
            [self textImage:_event_tf imageName:@"rightArrow"];
        }
        [_eventTV reloadData];
    }
    
    //--------------Skin Text Field------------------
    else if (textField == _skin_tf) {
       
        if (skinSelect == NO) {
            
            skinSelect = YES;
            isSelect = NO;
            eyeSelect = NO;
            hairSelect = NO;
            heightSelect = NO;
            weightSelect = NO;
            
            [_eventTV setHidden:YES];
            [_skinTV setHidden:NO];
            [_eyeTV setHidden:YES];
            [_hairTV setHidden:YES];
            [_weightTV setHidden:YES];
            [_heightTV setHidden:YES];
            
            [self textImage:_eye_tf imageName:@"rightArrow"];
            [self textImage:_event_tf imageName:@"rightArrow"];
            [self textImage:_skin_tf imageName:@"downArrow"];
            [self textImage:_hair_tf imageName:@"rightArrow"];
            [self textImage:_weight_tf imageName:@"rightArrow"];
            [self textImage:_height_tf imageName:@"rightArrow"];
            
        }else{
            skinSelect = NO;
            isSelect = NO;
            eyeSelect = NO;
            hairSelect = NO;
            heightSelect = NO;
            weightSelect = NO;
            
            [_skinTV setHidden:YES];
            
            [self textImage:_skin_tf imageName:@"rightArrow"];
        }
        
        [_skinTV reloadData];
    }
    
    //--------------Eye Text Field------------------
    else if (textField == _eye_tf) {
        if (eyeSelect == NO) {
            
            eyeSelect = YES;
            isSelect = NO;
            hairSelect = NO;
            skinSelect = NO;
            heightSelect = NO;
            weightSelect = NO;
            
            [_eventTV setHidden:YES];
            [_skinTV setHidden:YES];
            [_eyeTV setHidden:NO];
            [_hairTV setHidden:YES];
            [_weightTV setHidden:YES];
            [_heightTV setHidden:YES];
            
            [self textImage:_eye_tf imageName:@"downArrow"];
            [self textImage:_event_tf imageName:@"rightArrow"];
            [self textImage:_skin_tf imageName:@"rightArrow"];
            [self textImage:_hair_tf imageName:@"rightArrow"];
            [self textImage:_weight_tf imageName:@"rightArrow"];
            [self textImage:_height_tf imageName:@"rightArrow"];
            
            
        }else{
            eyeSelect = NO;
            isSelect = NO;
            hairSelect = NO;
            skinSelect = NO;
            heightSelect = NO;
            weightSelect = NO;
            
            [_eyeTV setHidden:YES];
            
            [self textImage:_eye_tf imageName:@"rightArrow"];
        }
        [_eyeTV reloadData];
    }
    
    //--------------Hair Text Field------------------
    else if (textField == _hair_tf) {
        if (hairSelect == NO) {
            
            hairSelect = YES;
            isSelect = NO;
            eyeSelect = NO;
            skinSelect = NO;
            heightSelect = NO;
            weightSelect = NO;
            
            [_eventTV setHidden:YES];
            [_skinTV setHidden:YES];
            [_eyeTV setHidden:YES];
            [_hairTV setHidden:NO];
            [_weightTV setHidden:YES];
            [_heightTV setHidden:YES];
        
            [self textImage:_eye_tf imageName:@"rightArrow"];
            [self textImage:_event_tf imageName:@"rightArrow"];
            [self textImage:_skin_tf imageName:@"rightArrow"];
            [self textImage:_hair_tf imageName:@"downArrow"];
            [self textImage:_weight_tf imageName:@"rightArrow"];
            [self textImage:_height_tf imageName:@"rightArrow"];
            
        }else{
            
            hairSelect = NO;
            isSelect = NO;
            eyeSelect = NO;
            skinSelect = NO;
            heightSelect = NO;
            weightSelect = NO;
            
            [_hairTV setHidden:YES];
            
            [self textImage:_hair_tf imageName:@"rightArrow"];
        }
        [_hairTV reloadData];
    }
    
    //--------------Weight Text Field------------------
    else if (textField == _weight_tf) {
        if (weightSelect == NO) {
            
            weightSelect = YES;
            isSelect = NO;
            eyeSelect = NO;
            hairSelect = NO;
            skinSelect = NO;
            heightSelect = NO;

            [_eventTV setHidden:YES];
            [_skinTV setHidden:YES];
            [_eyeTV setHidden:YES];
            [_hairTV setHidden:YES];
            [_weightTV setHidden:NO];
            [_heightTV setHidden:YES];
            
            [self textImage:_eye_tf imageName:@"rightArrow"];
            [self textImage:_event_tf imageName:@"rightArrow"];
            [self textImage:_skin_tf imageName:@"rightArrow"];
            [self textImage:_hair_tf imageName:@"rightArrow"];
            [self textImage:_weight_tf imageName:@"downArrow"];
            [self textImage:_height_tf imageName:@"rightArrow"];
            
        }else{
            
            weightSelect = NO;
            isSelect = NO;
            eyeSelect = NO;
            hairSelect = NO;
            skinSelect = NO;
            heightSelect = NO;

            [_weightTV setHidden:YES];
            
            [self textImage:_weight_tf imageName:@"rightArrow"];
        }
        [_weightTV reloadData];
    }
    
    //--------------Height Text Field------------------
    else if (textField == _height_tf) {
        if (heightSelect == NO) {
            
            heightSelect = YES;
            isSelect = NO;
            eyeSelect = NO;
            hairSelect = NO;
            skinSelect = NO;
            weightSelect = NO;
            
            [_eventTV setHidden:YES];
            [_skinTV setHidden:YES];
            [_eyeTV setHidden:YES];
            [_hairTV setHidden:YES];
            [_weightTV setHidden:YES];
            [_heightTV setHidden:NO];
            
            [self textImage:_eye_tf imageName:@"rightArrow"];
            [self textImage:_event_tf imageName:@"rightArrow"];
            [self textImage:_skin_tf imageName:@"rightArrow"];
            [self textImage:_hair_tf imageName:@"rightArrow"];
            [self textImage:_weight_tf imageName:@"rightArrow"];
            [self textImage:_height_tf imageName:@"downArrow"];
        }else{
            
            heightSelect = NO;
            isSelect = NO;
            eyeSelect = NO;
            hairSelect = NO;
            skinSelect = NO;
            weightSelect = NO;
            
            [_heightTV setHidden:YES];
            
            [self textImage:_height_tf imageName:@"rightArrow"];
        }
        [_heightTV reloadData];
    }
    
    else{
        
        isSelect = NO;
        eyeSelect = NO;
        hairSelect = NO;
        skinSelect = NO;
        heightSelect = NO;
        weightSelect = NO;
        
        [self textImage:_eye_tf imageName:@"rightArrow"];
        [self textImage:_event_tf imageName:@"rightArrow"];
        [self textImage:_skin_tf imageName:@"rightArrow"];
        [self textImage:_hair_tf imageName:@"rightArrow"];
        [self textImage:_weight_tf imageName:@"rightArrow"];
        [self textImage:_height_tf imageName:@"rightArrow"];
        
        [_eventTV setHidden:YES];
    }
    return NO;  // Hide both keyboard and blinking cursor.
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_eventTV setHidden:YES];
    [_skinTV setHidden:YES];
    [_eyeTV setHidden:YES];
    [_hairTV setHidden:YES];
    [_weightTV setHidden:YES];
    [_heightTV setHidden:YES];
    
    [self textImage:_eye_tf imageName:@"rightArrow"];
    [self textImage:_event_tf imageName:@"rightArrow"];
    [self textImage:_skin_tf imageName:@"rightArrow"];
    [self textImage:_hair_tf imageName:@"rightArrow"];
    [self textImage:_weight_tf imageName:@"rightArrow"];
    [self textImage:_height_tf imageName:@"rightArrow"];
    
    [self.view endEditing:YES];
    
    isSelect = NO;
    eyeSelect = NO;
    hairSelect = NO;
    skinSelect = NO;
    heightSelect = NO;
    weightSelect = NO;
}
/*
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [_eventTV setHidden:YES];
    [_skinTV setHidden:YES];
    [_eyeTV setHidden:YES];
    [_hairTV setHidden:YES];
    [_weightTV setHidden:YES];
    [_heightTV setHidden:YES];
    
    [self textImage:_eye_tf imageName:@"rightArrow"];
    [self textImage:_event_tf imageName:@"rightArrow"];
    [self textImage:_skin_tf imageName:@"rightArrow"];
    [self textImage:_hair_tf imageName:@"rightArrow"];
    [self textImage:_weight_tf imageName:@"rightArrow"];
    [self textImage:_height_tf imageName:@"rightArrow"];
    
    isSelect = NO;
    eyeSelect = NO;
    hairSelect = NO;
    skinSelect = NO;
    heightSelect = NO;
    weightSelect = NO;
    
}*/

#pragma mark - -------------Table View-------------
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //-----------Event Table----------
    if (tableView == _eventTV) {
        
        cell.textLabel.text = [eventArray objectAtIndex:indexPath.row];
    }
    
    //-----------Eye Table----------
    else if (tableView == _eyeTV) {
        
        cell.textLabel.text = [eyeArray objectAtIndex:indexPath.row];
    }
    
    //-----------Weight Table----------
    else if (tableView == _weightTV) {
        
        cell.textLabel.text = [weightArray objectAtIndex:indexPath.row];
    }
    
    //-----------Height Table----------
    else if (tableView == _heightTV) {
        
        cell.textLabel.text = [heightArray objectAtIndex:indexPath.row];
    }
    
    //-----------Hair Table----------
    else if (tableView == _hairTV) {
        
        cell.textLabel.text = [hairArray objectAtIndex:indexPath.row];
    }
    
    //-----------Skin Table----------
    else if (tableView == _skinTV) {
        
        cell.textLabel.text = [skinArray objectAtIndex:indexPath.row];
    }

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //-----------Event Table----------
    if (tableView == _eventTV) {
        
        return eventArray.count;
    }
    
    //-----------Eye Table----------
    else if (tableView == _eyeTV) {
        
        return eyeArray.count;
        
    }
    
    //-----------Weight Table----------
    else if (tableView == _weightTV) {
        
        return weightArray.count;
    }
    
    //-----------Height Table----------
    else if (tableView == _heightTV) {
        
        return heightArray.count;
    }
    
    //-----------Hair Table----------
    else if (tableView == _hairTV) {
        
        return hairArray.count;
    }
    
    //-----------Skin Table----------
    else if (tableView == _skinTV) {
        
        return skinArray.count;
        
    }
    else{
        return 1;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //-----------Event Table----------
    if (tableView == _eventTV) {
        _event_tf.text = [eventArray objectAtIndex:indexPath.row];
        [allfilterDict setValue:[eventArray objectAtIndex:indexPath.row] forKey:@"event"];
        [_eventTV setHidden:YES];
        isSelect = NO;
        eyeSelect = NO;
        hairSelect = NO;
        skinSelect = NO;
        heightSelect = NO;
        weightSelect = NO;
        [self textImage:_event_tf imageName:@"rightArrow"];
    }
    
    //-----------Eye Table----------
    else if (tableView == _eyeTV) {
        
        _eye_tf.text = [eyeArray objectAtIndex:indexPath.row];
        [allfilterDict setValue:[eyeArray objectAtIndex:indexPath.row] forKey:@"eye"];
        [_eyeTV setHidden:YES];
        isSelect = NO;
        eyeSelect = NO;
        hairSelect = NO;
        skinSelect = NO;
        heightSelect = NO;
        weightSelect = NO;
        [self textImage:_eye_tf imageName:@"rightArrow"];
    }
    
    //-----------Weight Table----------
    else if (tableView == _weightTV) {
        
        _weight_tf.text = [weightArray objectAtIndex:indexPath.row];
        [allfilterDict setValue:[weightArray objectAtIndex:indexPath.row] forKey:@"weight"];
        [_weightTV setHidden:YES];
        isSelect = NO;
        eyeSelect = NO;
        hairSelect = NO;
        skinSelect = NO;
        heightSelect = NO;
        weightSelect = NO;
        [self textImage:_weight_tf imageName:@"rightArrow"];
    }
    
    //-----------Height Table----------
    else if (tableView == _heightTV) {
        
       _height_tf.text = [heightArray objectAtIndex:indexPath.row];
        [allfilterDict setValue:[heightArray objectAtIndex:indexPath.row] forKey:@"height"];
        [_heightTV setHidden:YES];
        isSelect = NO;
        eyeSelect = NO;
        hairSelect = NO;
        skinSelect = NO;
        heightSelect = NO;
        weightSelect = NO;
        [self textImage:_height_tf imageName:@"rightArrow"];
    }
    
    //-----------Hair Table----------
    else if (tableView == _hairTV) {
        
        _hair_tf.text = [hairArray objectAtIndex:indexPath.row];
        [allfilterDict setValue:[hairArray objectAtIndex:indexPath.row] forKey:@"hair"];
        [_hairTV setHidden:YES];
        isSelect = NO;
        eyeSelect = NO;
        hairSelect = NO;
        skinSelect = NO;
        heightSelect = NO;
        weightSelect = NO;
        [self textImage:_hair_tf imageName:@"rightArrow"];
    }
    
    //-----------Skin Table----------
    else if (tableView == _skinTV) {
        
        _skin_tf.text = [skinArray objectAtIndex:indexPath.row];
        [allfilterDict setValue:[skinArray objectAtIndex:indexPath.row] forKey:@"skin"];
        [_skinTV setHidden:YES];
        isSelect = NO;
        eyeSelect = NO;
        hairSelect = NO;
        skinSelect = NO;
        heightSelect = NO;
        weightSelect = NO;
        [self textImage:_skin_tf imageName:@"rightArrow"];
    }
    
}

@end

