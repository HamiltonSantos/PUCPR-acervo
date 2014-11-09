//
//  SNWebService+Call.m
//  ios.Responde
//
//  Created by Luis Antonio De Marchi on 31/08/14.
//  Copyright (c) 2014 Snowman Labs. All rights reserved.
//

#import "SMWebService+Call.h"

@implementation SMWebService (Call)

//Metodo para checagem de email
+(void) searchBooks:(NSString *)query delegate:(id<SMWebServiceDelegate>)delegate{
    //Se os dados forem nulos
    NSDictionary *parameters = @{@"title": query};
    
    NSDictionary *data = @{@"url": @"search.json",
                           @"method":@"GET",
                           @"parameters":parameters};
    
    
    SMWebService *webService = [SMWebService getObject];
    [webService invokeMethod:SMWebserviceTypeSearchBooks dictData:data delegate:delegate animation:YES];
}



@end
