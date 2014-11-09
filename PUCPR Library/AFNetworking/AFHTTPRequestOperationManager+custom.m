//
//  AFHTTPRequestOperationManager+custom.m
//  ios.Responde
//
//  Created by Luis Antonio De Marchi on 28/08/14.
//  Copyright (c) 2014 Snowman Labs. All rights reserved.
//

#import "AFHTTPRequestOperationManager+custom.h"


@implementation AFHTTPRequestOperationManager (custom)
- (AFHTTPRequestOperation *)urlString:(NSString *)URLString
                               method:(NSString *)method
                           parameters:(id)parameters
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    [request setValue:[NSString stringWithFormat:@"application/json; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    
    [self.operationQueue addOperation:operation];
    
    return operation;
}
@end
