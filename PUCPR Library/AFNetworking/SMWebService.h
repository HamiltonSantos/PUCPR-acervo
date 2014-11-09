//
//  TAWebService.h
//  SebraeOffline
//
//  Created by Luis Antonio De Marchi on 10/02/14.
//  Copyright (c) 2014 TechApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@class TAAppDelegate, SyncServer;

typedef enum {
    SMWebserviceTypeSearchBooks
}SMWebserviceType;

@protocol SMWebServiceDelegate<NSObject>
-(void) webServiceWithMethod:(SMWebserviceType)method data:(id)data error:(BOOL)error show:(void (^)(BOOL show))block;
@end


@interface SMWebService : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

+(SMWebService*) getObject;
- (void)invokeMethod:(SMWebserviceType)method dictData:(NSDictionary*)data delegate:(id<SMWebServiceDelegate>)delegate animation:(BOOL)_show;
-(void) webServiceClose;
@end
