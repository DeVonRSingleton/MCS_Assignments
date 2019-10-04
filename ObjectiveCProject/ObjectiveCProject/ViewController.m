//
//  ViewController.m
//  ObjectiveCProject
//
//  Created by MCS on 9/30/19.
//  Copyright © 2019 MCS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//making it a stored property
@synthesize theProperty;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.theProperty = @"Cool String";
    //return type / block name /  input type input name /
    NSString*(^theBlock)(NSString*) = ^(NSString* firstInput) {
        return firstInput;
    };
    //the block calling of a block
    theBlock(@"hi");
}
-(void)printHelloWorld{
    NSLog(@"Helloworld");
}
+ (void)printHello:(NSString *)input {
    NSLog(@"Hello %@", input);
}


@end
