//
//  ViewController.m
//  Button-Animation
//
//  Created by haogaoming on 2017/2/27.
//  Copyright © 2017年 郝高明. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Animation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 180, 60);
    [button addGradientButton];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

-(void)click
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
