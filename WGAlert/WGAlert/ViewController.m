//
//  ViewController.m
//  WGAlert
//
//  Created by Admin on 17/3/7.
//  Copyright © 2017年 Wind. All rights reserved.
//

#import "ViewController.h"
#import "WGActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onActionSheet1:(id)sender
{
    WGActionSheet *sheet = [[WGActionSheet alloc] initWithTitle:@"Hello!" andDetail:@"How are you? I am fine."];
    [sheet addButtonWithTitle:@"a"];
    [sheet addButtonWithTitle:@"b"];
    //[sheet addButtonWithTitle:@"c"];
    //[sheet addButtonWithTitle:@"d"];
    [sheet show];
}
- (IBAction)onActionSheet2:(id)sender
{
    WGActionSheet *sheet = [[WGActionSheet alloc] initWithTitle:@"Hello!" andDetail:@"How are you? I am fine."];
    [sheet addButtonWithTitle:@"ONE"];
    [sheet addButtonWithTitle:@"TWO"];
    [sheet addButtonWithTitle:@"THREE"];
    [sheet addButtonWithTitle:@"FOUR"];
    [sheet show];
}

- (IBAction)onAlertView1:(id)sender
{
    
}

- (IBAction)onAlertView2:(id)sender
{
    
}


@end
