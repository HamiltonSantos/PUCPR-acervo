//
//  SNWebService+Return.m
//  ios.Responde
//
//  Created by Luis Antonio De Marchi on 31/08/14.
//  Copyright (c) 2014 Snowman Labs. All rights reserved.
//

#import "SMWebService+Return.h"
#import "TABlurredLoading.h"

#import "TABlurredLoading.h"



@implementation SMWebService (Return)

//Retorno do WebService
//configurar chamadas para o método certo:
-(void) webServiceReturn:(NSArray*)json delegate:(id<SMWebServiceDelegate>)delegate type:(SMWebserviceType)webserviceType error:(BOOL)error{
    if (error){
        if ([delegate respondsToSelector:@selector(webServiceWithMethod:data:error:show:)]){
            [delegate webServiceWithMethod:webserviceType data:nil error:YES show:nil];
        }
        [TABlurredLoading hide:^(BOOL finished) {
        }];
        
        return;
    }
    
    
    switch (webserviceType) {
        case SMWebserviceTypeSearchBooks:
            [self booksJson:json delegate:delegate type:webserviceType];
            break;
            
    }
}
-(void) booksJson:(NSArray*)json delegate:(id<SMWebServiceDelegate>)delegate type:(SMWebserviceType)webserviceType{
    
    
    if ([delegate respondsToSelector:@selector(webServiceWithMethod:data:error:show:)]){
        [delegate webServiceWithMethod:webserviceType data:json error:NO show:nil];
    }
    [TABlurredLoading hide:^(BOOL finished) {}];
}



@end
