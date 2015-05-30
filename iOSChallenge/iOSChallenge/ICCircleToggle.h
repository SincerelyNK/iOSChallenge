//
//  ICCircleToggle.h
//  iOSChallenge
//
//  Created by Nicholas Kraft on 5/29/15.
//  Copyright (c) 2015 Nicholas Kraft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICCircleToggle : UIControl
@property (nonatomic, strong) UIColor *circleColor;
@property (nonatomic, strong) UIColor *activeArcColor;
@property (nonatomic, strong) UIColor *inactiveArcColor;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, assign) CGFloat arcWidthPoints;

@property (nonatomic, copy) NSArray *labelStrings;
@property (nonatomic) NSUInteger currentIndex;
@property (nonatomic, readonly) NSString* currentLabel;
@property (nonatomic, readonly) NSUInteger count;

- (void)next;
@end
