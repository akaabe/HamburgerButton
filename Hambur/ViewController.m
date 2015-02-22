//
//  ViewController.m
//  Hambur
//
//  Created by Dmytro on 2/16/15.
//  Copyright (c) 2015 Dmytro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) HamburBtn *btn;

@end

@implementation ViewController

@synthesize btn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor greenColor];
    self.btn = [[HamburBtn alloc] initWithFrame:(CGRect){self.view.frame.size.width / 2 - 27, self.view.frame.size.height / 2 - 27, 54, 54}];
    [self.btn addTarget:self action:@selector(toggleBtn:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toggleBtn:(id)sender
{
    [self.btn toggleAnimation];
}

@end
