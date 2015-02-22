//
//  HamburBtn.m
//  Hambur
//
//  Created by Dmytro on 2/16/15.
//  Copyright (c) 2015 Dmytro. All rights reserved.
//

#import "HamburBtn.h"

@interface HamburBtn()

@property (nonatomic, strong) CAShapeLayer *medium;
@property (nonatomic, strong) CAShapeLayer *upper;
@property (nonatomic, strong) CAShapeLayer *lower;
@property (nonatomic, assign) BOOL shown;

#define menuStrokeStart 0.325
#define menuStrokeEnd 0.9
#define hamburgerStrokeStart 0.028
#define hamburgerStrokeEnd 0.111

@end

@implementation HamburBtn

@synthesize medium, upper, shown, lower;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.shown = NO;
        self.medium = [[CAShapeLayer alloc] init];
        self.medium.path = [self outlinePath];
        self.upper = [[CAShapeLayer alloc] init];
        self.upper.path = [self strokePath];
        self.lower = [[CAShapeLayer alloc] init];
        self.lower.path = [self strokePath];
        for (CAShapeLayer *layer in @[self.upper, self.medium, self.lower])
        {
            layer.fillColor = nil;
            layer.strokeColor = [[UIColor whiteColor] CGColor];
            layer.lineWidth = 4;
            layer.miterLimit = 4;
            layer.lineCap = kCALineCapRound;
            layer.masksToBounds = YES;
            CGPathRef strokePath = CGPathCreateCopyByStrokingPath(layer.path, nil, 4, kCGLineCapRound, kCGLineJoinMiter, 4);
            layer.bounds = CGPathGetPathBoundingBox(strokePath);
            layer.actions = @{@"strokeStart" : [NSNull null], @"strokeEnd" : [NSNull null], @"transform" : [NSNull null]};
            [self.layer addSublayer:layer];
        }
        self.upper.anchorPoint = CGPointMake(28.0 / 30.0, 0.5);
        self.upper.position = CGPointMake(40, 18);
        self.medium.position = CGPointMake(27, 27);
        self.medium.strokeStart = hamburgerStrokeStart;
        self.medium.strokeEnd = hamburgerStrokeEnd;
        self.lower.anchorPoint = CGPointMake(28.0 / 30.0, 0.5);
        self.lower.position = CGPointMake(40, 36);
    }
    return self;
}

- (CGMutablePathRef)outlinePath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 10, 27);
    CGPathAddCurveToPoint(path, nil, 12.00, 27.00, 28.02, 27.00, 40, 27);
    CGPathAddCurveToPoint(path, nil, 55.92, 27.00, 50.47,  2.00, 27,  2);
    CGPathAddCurveToPoint(path, nil, 13.16,  2.00,  2.00, 13.16,  2, 27);
    CGPathAddCurveToPoint(path, nil,  2.00, 40.84, 13.16, 52.00, 27, 52);
    CGPathAddCurveToPoint(path, nil, 40.84, 52.00, 52.00, 40.84, 52, 27);
    CGPathAddCurveToPoint(path, nil, 52.00, 13.16, 42.39,  2.00, 27,  2);
    CGPathAddCurveToPoint(path, nil, 13.16,  2.00,  2.00, 13.16,  2, 27);
    return path;
}

- (CGMutablePathRef)strokePath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 2, 2);
    CGPathAddLineToPoint(path, nil, 28, 2);
    return path;
}

- (void)toggleAnimation
{
    CABasicAnimation *strokeStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    CABasicAnimation *strokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    if (!self.shown)
    {
        strokeStart.toValue = [NSNumber numberWithFloat:menuStrokeStart];
        strokeStart.duration = 0.5;
        strokeStart.timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.25: -0.4: 0.5: 1];
        strokeEnd.toValue = [NSNumber numberWithFloat:menuStrokeEnd];
        strokeEnd.duration = 0.6;
        strokeEnd.timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.25: -0.4: 0.5: 1];
        self.shown = YES;
    }
    else
    {
        strokeStart.toValue = [NSNumber numberWithFloat:hamburgerStrokeStart];
        strokeStart.duration = 0.5;
        strokeStart.timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.25: 0: 0.5: 1.2];
        strokeStart.beginTime = CACurrentMediaTime() + 0.1;
        strokeStart.fillMode = kCAFillModeBackwards;
        strokeEnd.toValue = [NSNumber numberWithFloat:hamburgerStrokeEnd];;
        strokeEnd.duration = 0.6;
        strokeEnd.timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.25: 0.3: 0.5: 0.9];
        self.shown = NO;
    }
    [self.medium applyCustomAnimation:strokeStart];
    [self.medium applyCustomAnimation:strokeEnd];
    
    CABasicAnimation *upperTransform = [CABasicAnimation animationWithKeyPath:@"transform"];
    upperTransform.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :-0.8 :0.5 :1.85];
    upperTransform.duration = 0.4;
    upperTransform.fillMode = kCAFillModeBackwards;
    
    CABasicAnimation *lowerTransform = [upperTransform copy];
    
    if(!self.shown)
    {
        upperTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        upperTransform.beginTime = CACurrentMediaTime() + 0.05;
        
        lowerTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        lowerTransform.beginTime = CACurrentMediaTime() + 0.05;
    }
    else
    {
        CATransform3D translation = CATransform3DMakeTranslation(-4.0f, 0, 0);
        upperTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, -0.7853975, 0, 0, 1)];
        upperTransform.beginTime = CACurrentMediaTime() + 0.25;
        
        lowerTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, 0.7853975, 0, 0, 1)];
        lowerTransform.beginTime = CACurrentMediaTime() + 0.25;
    }
    
    [self.upper applyCustomAnimation:upperTransform];
    [self.lower applyCustomAnimation:lowerTransform];
}

@end
