//
//  ViewController.h
//  ObjectiveCProject
//
//  Created by MCS on 9/30/19.
//  Copyright © 2019 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface ViewController : UIViewController
@property (atomic) NSString* theProperty; //property name theProperty 
//instance function strt with minus sign in parenthesis return type (instance of the function)
- (void)printHelloWorld;
//class function use a +
+ (void)printHello :(NSString*)input;
- (NSString*)returnHello : (NSString*)firstInput with
                         :(NSString*)secondInput;
@end

