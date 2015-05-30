//
//  ICCircleToggle.m
//  iOSChallenge
//
//  Created by Nicholas Kraft on 5/29/15.
//  Copyright (c) 2015 Nicholas Kraft. All rights reserved.
//

#import "ICCircleToggle.h"

#define LABEL_PROPORTION 4
#define INDICATOR_GAP 0.1

@interface ICCircleToggle ()
@property (nonatomic, strong) UILabel* textLabel;
@property (nonatomic) CGRect indicatorRect;
@property (nonatomic) CGRect circleRect;
@end

@implementation ICCircleToggle

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    _circleColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:.15];
    _activeArcColor = [UIColor colorWithRed:0.96 green:0.42 blue:0.39 alpha:1.0];
    _inactiveArcColor = [UIColor colorWithRed:0.38 green:0.0 blue:0.14 alpha:1.0];
    _textColor = [UIColor whiteColor];
    _arcWidthPoints = 1;
    _textLabel = [[UILabel alloc] init];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.numberOfLines = 0;
    _textLabel.adjustsFontSizeToFitWidth = YES;
    _textLabel.textColor = [UIColor whiteColor];
    [self addSubview:_textLabel];
}

#pragma mark - Methods

- (void)next {
    if (_labelStrings) {
        self.currentIndex = (_currentIndex + 1) % [_labelStrings count];
    }
}

#pragma mark - Drawing and Layout

- (void)layoutSubviews {
    CGRect rect = self.bounds;
    
    // figure out the largest squre that fits in the bounds
    CGFloat squareDimension = MIN(rect.size.width, rect.size.height);
    CGRect centerSquare = CGRectMake(rect.origin.x + (rect.size.width - squareDimension) / 2.0, rect.origin.y + (rect.size.height - squareDimension) / 2.0, squareDimension, squareDimension);
    
    // calculate the square to draw the circle and teh indicators within
    CGRect centerCircle = CGRectInset(centerSquare, self.arcWidthPoints * 4, self.arcWidthPoints * 4);
    centerSquare = CGRectInset(centerSquare, self.arcWidthPoints * 1.5, self.arcWidthPoints * 1.5);
    
    // Label size proportional to the size of the circle, inset so it won;t clip edges
    CGRect textBounds = CGRectMake(0, 0, sqrt(pow(centerCircle.size.width, 2.0) - pow(centerCircle.size.height / LABEL_PROPORTION, 2.0)), centerCircle.size.height / LABEL_PROPORTION);
    CGPoint textCenter = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    
    self.textLabel.bounds = textBounds;
    self.textLabel.center = textCenter;
    
    self.circleRect = centerCircle;
    self.indicatorRect = centerSquare;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // Stroke the circle
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.circleColor.CGColor);
    CGContextFillEllipseInRect(context, self.circleRect);

    // Stroke the arcs
    CGContextSetLineWidth(context, self.arcWidthPoints);

    CGFloat arcRadius = self.indicatorRect.size.width / 2;
    CGPoint arcOrigin = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    NSUInteger segmentCount = self.count;
    NSUInteger activeSegment = _currentIndex;
    
    if (segmentCount) {
        CGFloat segmentSize = (2 * M_PI) / segmentCount;
        CGFloat drawStart = M_PI - segmentSize / 2;//(segmentCount == 2)?0 - segmentSize/2:0 - segmentSize;
        
        for (NSUInteger segment = 0; segment < segmentCount; ++segment) {
            CGContextSetStrokeColorWithColor(context, (segment == activeSegment)?self.activeArcColor.CGColor:self.inactiveArcColor.CGColor);
            CGContextAddArc(context, arcOrigin.x, arcOrigin.y, arcRadius, drawStart + INDICATOR_GAP, drawStart + segmentSize - INDICATOR_GAP, 0);
            CGContextStrokePath(context);
            drawStart += segmentSize;
        }
    }
}

#pragma mark - Getters and Setters

- (void)setLabelStrings:(NSArray *)labelStrings {
    _labelStrings = [labelStrings copy];
    _currentIndex = 0;
    
    if (_labelStrings) {
        _textLabel.text = _labelStrings[_currentIndex];
    }
    else {
        _textLabel.text = nil;
    }
    
    [self setNeedsDisplay];
}

- (NSString *)currentLabel {
    NSString *retString = nil;
    if (_labelStrings) {
        retString = _labelStrings[_currentIndex];
    }
    
    return retString;
}

- (void)setCurrentIndex:(NSUInteger)currentIndex {
    if (_labelStrings && currentIndex < [_labelStrings count]) {
        _currentIndex = currentIndex;
        _textLabel.text = _labelStrings[_currentIndex];
        [self setNeedsDisplay];
    }
}

- (NSUInteger)count {
    if (_labelStrings) {
        return [_labelStrings count];
    }
    return 0;
}

#pragma mark - Event Handling

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (touch.view == self && touch.phase == UITouchPhaseEnded) {
        CGPoint location = [touch locationInView:self];
        if (CGRectContainsPoint(_circleRect, location)) {
            [self next];
        }
    }
}


@end
