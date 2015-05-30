//
//  ViewController.m
//  iOSChallenge
//
//  Created by Nicholas Kraft on 5/28/15.
//  Copyright (c) 2015 Nicholas Kraft. All rights reserved.
//

#import "ViewController.h"
#import "ICStyledBarButtonItem.h"
#import "ICCircleToggle.h"

#import <UIKit/UIKit.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet ICCircleToggle *volumeToggle;
@property (weak, nonatomic) IBOutlet ICCircleToggle *tasteToggle;
@property (weak, nonatomic) IBOutlet ICCircleToggle *textureToggle;
@property (weak, nonatomic) IBOutlet ICCircleToggle *spiceToggle;
@property (weak, nonatomic) IBOutlet ICCircleToggle *quantityToggle;
@property (weak, nonatomic) IBOutlet ICCircleToggle *mealToggle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // Add our buttons to the navigation bar
    [_navBar setItems:nil];
    UINavigationItem *navItem = [UINavigationItem new];
    navItem.leftBarButtonItems =@[[[ICStyledBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MON_searchIcon"] style:UIBarButtonItemStylePlain target:nil action:nil],
                                  [[ICStyledBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MON_calendarIcon"] style:UIBarButtonItemStylePlain target:nil action:nil],
                                  [[ICStyledBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MON_compassIcon"] style:UIBarButtonItemStylePlain target:nil action:nil]];
    navItem.rightBarButtonItem = [[ICStyledBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MON_menuIcon"] style:UIBarButtonItemStylePlain target:nil action:nil];
    [_navBar pushNavigationItem:navItem animated:NO];
    
    self.volumeToggle.labelStrings = @[@"ONE OF A KIND", @"SMALL BATCH", @"LARGE BATCH", @"MASS MARKET"];
    self.tasteToggle.labelStrings = @[@"SAVORY", @"SWEET", @"UMAMI"];
    self.textureToggle.labelStrings = @[@"CRUNCHY", @"MUSHY", @"SMOOTH"];
    self.spiceToggle.labelStrings = @[@"SPICY", @"MILD"];
    self.quantityToggle.labelStrings = @[@"A LITTLE", @"A LOT"];
    self.mealToggle.labelStrings = @[@"BREAKFAST", @"BRUNCH", @"LUNCH", @"SNACK", @"DINNER"];
    [self randomizeButton:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goTime:(id)sender {
    return;
}

- (IBAction)randomizeButton:(id)sender {
    self.volumeToggle.currentIndex =  arc4random_uniform(self.volumeToggle.count);
    self.tasteToggle.currentIndex =  arc4random_uniform(self.tasteToggle.count);
    self.textureToggle.currentIndex =  arc4random_uniform(self.textureToggle.count);
    self.spiceToggle.currentIndex =  arc4random_uniform(self.spiceToggle.count);
    self.quantityToggle.currentIndex =  arc4random_uniform(self.quantityToggle.count);
    self.mealToggle.currentIndex =  arc4random_uniform(self.mealToggle.count);
}

@end
