//
//  SearchViewController.m
//  BookMarkSearchMap
//
//  Created by MENG-YI HSU on 4/7/14.
//  Copyright (c) 2014 Marcus. All rights reserved.
//

#import "SearchViewController.h"
#import "ViewController.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *type;
@property (weak, nonatomic) IBOutlet UILabel *radius;

//@property(assign) double radious;
@end

@implementation SearchViewController
- (IBAction)search:(UIButton *)sender {
}
- (IBAction)hideKeyboardForName:(UITextField *)sender {
    [sender resignFirstResponder];
}
- (IBAction)hideKeyboardForType:(UITextField *)sender {
    [sender resignFirstResponder];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"search"]){
        ViewController *dest = segue.destinationViewController;
        dest.name = [self.name.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        dest.type = self.type.text;
        dest.radius = [self.radius.text doubleValue];
    }
}
- (IBAction)slider:(UISlider *)sender {
    self.radius.text = [NSString stringWithFormat:@"%.0f", [sender value]];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    UIColor *backimage = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"image.jpg"]];
    self.view.backgroundColor = backimage;

    UIGestureRecognizer *hide = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:hide];
    

	// Do any additional setup after loading the view.
}

- (void)hideKeyBoard{
    if (self.name.isFirstResponder){
        [self.name resignFirstResponder];
    }
    if (self.type.isFirstResponder){
        [self.type resignFirstResponder];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
