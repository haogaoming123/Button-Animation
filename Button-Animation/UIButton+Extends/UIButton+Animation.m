//
//  UIButton+Animation.m
//  Button-Animation
//
//  Created by haogaoming on 2017/2/27.
//  Copyright © 2017年 郝高明. All rights reserved.
//

#import "UIButton+Animation.h"

#define buleColor   [UIColor colorWithRed:60/255.0f green:140/255.0f blue:232/255.0f alpha:1.0]
#define purpleColor [UIColor colorWithRed:171/255.0f green:145/255.0f blue:234/255.0f alpha:1.0]

@implementation UIButton (Animation)
/**
 添加渐变色特效
 */
-(void)addGradientButton
{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.colors = @[(__bridge id)buleColor.CGColor,(__bridge id)purpleColor.CGColor];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1.0, 0);
    layer.frame = self.bounds;
    [self.layer addSublayer:layer];
}

/*****************************点击按钮撒花效果************************************/

-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    [super sendAction:action to:target forEvent:event];
    
    CGFloat radius = self.layer.cornerRadius;
    CGRect rect = CGRectZero;
    
    CGPoint pos = [self touchPoint:event];
    CGFloat smallerSize = MIN(self.frame.size.width, self.frame.size.height);
    CGFloat scale = 2;
    
    radius = smallerSize/2.0;
    rect = CGRectMake(0, 0, radius*2, radius*2);
    
    CALayer *layer = [self animateLayer:rect Radius:radius Postion:pos];
    CAAnimationGroup *group = [self animateGroup:scale];
    [self.layer addSublayer:layer];
    [group setValue:layer forKey:@"animatedLayer"];
    [layer addAnimation:group forKey:@"buttonAnimation"];
}

/****************************CAAnimationGroup代理方法***********************************/
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([[anim valueForKey:@"animatedLayer"] isKindOfClass:[CALayer class]]) {
        CALayer *layer = [anim valueForKey:@"animatedLayer"];
        [layer removeFromSuperlayer];
    }
}

/************************************自定义方法********************************/

-(CGPoint)touchPoint:(UIEvent *)event
{
    if (event.allTouches.count>0) {
        UITouch *touch = [event.allTouches anyObject];
        return [touch locationInView:self];
    }else {
        return CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }
}

-(CALayer *)animateLayer:(CGRect)rect Radius:(CGFloat)radius Postion:(CGPoint)postion
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 1;
    layer.position = postion;
    layer.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath;
    
    layer.fillColor = [UIColor orangeColor].CGColor;
    layer.bounds = CGRectMake(0, 0, radius*2, radius*2);
    
    return layer;
}

-(CAAnimationGroup *)animateGroup:(CGFloat)scale
{
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = @1;
    opacityAnim.toValue = @0;
    
    CABasicAnimation *scalAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scalAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scalAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, scale)];
    
    CAAnimationGroup *group = [CAAnimationGroup new];
    group.animations = @[opacityAnim,scalAnim];
    group.duration = 0.5;
    group.delegate = self;
    group.fillMode = kCAFillModeBoth;
    group.removedOnCompletion = false;
    return group;
}

@end
