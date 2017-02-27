# Button-Animation
按钮的渐变色效果



先看效果：

![](https://github.com/haogaoming123/Button-Animation/blob/master/%E6%8C%89%E9%92%AE%E6%B8%90%E5%8F%98%E8%89%B2.gif)



主要代码：

```
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
```
