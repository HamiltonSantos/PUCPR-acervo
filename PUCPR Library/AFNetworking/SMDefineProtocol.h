//
//  SNDefineProtocol.h
//  SebraeOffline
//
//  Created by Luis Antonio De Marchi on 02/02/14.
//  Copyright (c) 2014 TechApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SNDefineProtocol <NSObject>
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)

#define IS_IOS7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define WS_URL @"http://hamilton-library.herokuapp.com/"
@end



