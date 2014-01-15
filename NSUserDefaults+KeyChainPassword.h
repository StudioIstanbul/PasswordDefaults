//
//  NSUserDefaults+KeyChainPassword.h
//  Ticket Center
//
//  Created by Andreas Zöllner on 09.01.14.
//  Copyright (c) 2014 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (KeyChainPassword)

@property NSString* password;

-(NSString*)keyChainValueForKey:(NSString*)key;
-(BOOL)setKeyChainValue:(NSString*)value forKey:(NSString*)key;

@end
