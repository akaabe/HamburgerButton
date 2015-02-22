//
//  CALayer+CALayerCustomAnimation.m
//  Hambur
//
//  Created by Dmytro on 2/16/15.
//  Copyright (c) 2015 Dmytro. All rights reserved.
//

#import "CALayer+CALayerCustomAnimation.h"

@implementation CALayer(CALayerCustomAnimation)

- (void)applyCustomAnimation:(CABasicAnimation*)animation
{
    CABasicAnimation *copy = [animation copy];
    if (copy.fromValue == nil)
    {
        copy.fromValue = [[self presentationLayer] valueForKeyPath:[copy keyPath]];
    }
    [self addAnimation:copy forKey:[copy keyPath]];
    [self setValue:copy.toValue forKey:[copy keyPath]];
}

@end
