//
//  NSUserDefaults+KeyChainPassword.m
//  Ticket Center
//
//  Created by Andreas Zöllner on 09.01.14.
//  Copyright (c) 2014 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "NSUserDefaults+KeyChainPassword.h"
#import "AGKeychain.h"

@implementation NSUserDefaults (KeyChainPassword)
@dynamic password;

-(NSString*)password {
    return [self keyChainValueForKey:@"password"];
}

-(void)setPassword:(NSString *)password {
    [self setKeyChainValue:password forKey:@"password"];
}

-(NSString*)keyChainValueForKey:(NSString *)key {
    NSLog(@"read keychain");
    NSString* keyChainItemString = [NSString stringWithFormat:@"%@ %@", [[NSBundle mainBundle] bundleIdentifier], key];
    return [AGKeychain getPasswordFromKeychainItem:keyChainItemString withItemKind:@"Password" forUsername:[self valueForKey:@"username"]];
}

-(BOOL)setKeyChainValue:(NSString *)value forKey:(NSString *)key {
    NSLog(@"set Keychain");
    NSString* keyChainItemString = [NSString stringWithFormat:@"%@ %@", [[NSBundle mainBundle] bundleIdentifier], key];
    BOOL doesItemExist = [AGKeychain checkForExistanceOfKeychainItem:keyChainItemString withItemKind:@"Password" forUsername:[self valueForKey:@"username"]];
    if (doesItemExist) {
        //modify
        BOOL result = [AGKeychain modifyKeychainItem:keyChainItemString withItemKind:@"Password" forUsername:[self stringForKey:@"username"] withNewPassword:value];
        return result;
    } else {
        //add to keychain
        BOOL result = [AGKeychain addKeychainItem:keyChainItemString withItemKind:@"Password" forUsername:[self stringForKey:@"username"] withPassword:value];
        return result;
    }
}

@end
