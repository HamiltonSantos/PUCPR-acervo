//
//  SNWebService+Return.h
//  ios.Responde
//
//  Created by Luis Antonio De Marchi on 31/08/14.
//  Copyright (c) 2014 Snowman Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMWebService.h"

@interface SMWebService (Return)
-(void) webServiceReturn:(NSDictionary*)json delegate:(id<SMWebServiceDelegate>)delegate type:(SMWebserviceType)webserviceType error:(BOOL)error;


-(void) booksJson:(NSArray*)json delegate:(id<SMWebServiceDelegate>)delegate type:(SMWebserviceType)webserviceType;
@end
