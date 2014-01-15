//
//  PasswordUserDefaultsController.m
//  Ticket Center
//
//  Created by Andreas Zöllner on 09.01.14.
//  Copyright (c) 2014 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "PasswordUserDefaultsController.h"
#import "NSUserDefaults+KeyChainPassword.h"

@implementation PasswordUserDefaultsController

-(void)awakeFromNib {
    NSLog(@"awake");
}

-(id)values {
    return [NSUserDefaults standardUserDefaults];
}

-(id)valueForKeyPath:(NSString *)keyPath {
    if ([keyPath rangeOfString:@"values."].location != NSNotFound) {
        keyPath = [keyPath substringFromIndex:7];
        if ([keyPath rangeOfString:@"password" options:NSCaseInsensitiveSearch].location != NSNotFound) {
            return [[NSUserDefaults standardUserDefaults] keyChainValueForKey:keyPath];
        } else {
            NSLog(@"non pw value %@ for key: %@", [[NSUserDefaults standardUserDefaults] valueForKey:keyPath], keyPath);
            return [[NSUserDefaults standardUserDefaults] valueForKey:keyPath];
        }
    } else {
        return [super valueForKeyPath:keyPath];
    }
}

-(void)setValue:(id)value forKey:(NSString *)key {
    NSLog(@"value for key");
    [super setValue:value forKey:key];
}

-(void)setValue:(id)value forKeyPath:(NSString *)keyPath {
    if ([keyPath rangeOfString:@"values."].location != NSNotFound) {
        keyPath = [keyPath substringFromIndex:7];
        NSLog(@"set keypath: %@", keyPath);
        if ([keyPath rangeOfString:@"password" options:NSCaseInsensitiveSearch].location != NSNotFound) {
            NSLog(@"set password");
            [[NSUserDefaults standardUserDefaults] setKeyChainValue:value forKey:keyPath];
        } else {
            [[NSUserDefaults standardUserDefaults] setValue:value forKey:keyPath];
        }
    } else {
        [super setValue:value forKeyPath:keyPath];
    }
}

-(IBAction)save:(id)sender {
    [super save:sender];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
