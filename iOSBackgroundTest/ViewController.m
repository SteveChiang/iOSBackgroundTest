//
//  ViewController.m
//  iOSBackgroundTest
//
//  Created by Steve on 12/12/25.
//  Copyright (c) 2012年 Steve. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)susp:(id)sender {
    [[UIApplication sharedApplication] performSelector:@selector(suspend)];
}



@end
