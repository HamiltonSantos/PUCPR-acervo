//
//  AFHTTPRequestOperationManager+custom.h
//  ios.Responde
//
//  Created by Luis Antonio De Marchi on 28/08/14.
//  Copyright (c) 2014 Snowman Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface AFHTTPRequestOperationManager (custom)
- (AFHTTPRequestOperation *)urlString:(NSString *)URLString
                               method:(NSString *)method
                           parameters:(id)parameters
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
