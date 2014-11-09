//
//  SNWebService+Call.h
//  ios.Responde
//
//  Created by Luis Antonio De Marchi on 31/08/14.
//  Copyright (c) 2014 Snowman Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMWebService.h"

@interface SMWebService (Call)

+(void) searchBooks:(NSString *)query delegate:(id<SMWebServiceDelegate>)delegate;
@end
