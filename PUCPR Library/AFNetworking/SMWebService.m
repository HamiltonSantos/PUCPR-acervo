//
//  TAWebService.m
//  SebraeOffline
//
//  Created by Luis Antonio De Marchi on 10/02/14.
//  Copyright (c) 2014 TechApp. All rights reserved.
//

#import "SMWebService.h"
#import <CoreLocation/CoreLocation.h>

#import "TABlurredLoading.h"
#import "AFHTTPRequestOperationManager+custom.h"
#import "SMDefineProtocol.h"
#import "SMWebService+Call.h"
#import "SMWebService+Return.h"




@interface SMWebService (){
    
    BOOL notAccess, oneAttempt;
    
    int countVisitSync;
    NSMutableArray *queue;
}



@end

@implementation SMWebService

static SMWebService *singleton;
static NSTimer *force;
static BOOL initialized = NO;

//Singleton - Recupera o objeto de WS que estiver aberto:
+(SMWebService*) getObject{
    if(!initialized)
    {
        initialized = YES;
        singleton = [[SMWebService alloc] init];
    }
    
    return singleton;
}

- (void)invokeMethod:(SMWebserviceType)webserviceType dictData:(NSDictionary*)data delegate:(id<SMWebServiceDelegate>)delegate animation:(BOOL)_show{
    
    countVisitSync = 0;
    
    notAccess = NO;
    
    
    [self setLoadingStatusWithType:webserviceType];
    
    //Somente chama método para ativar view de "loading" se não estiver ativo:
    if (_show){
        [TABlurredLoading show:^(BOOL finished) {
            [self invokeMethodWithDict:data delegate:delegate type:webserviceType];
        }];
    }else{
        [self invokeMethodWithDict:data delegate:delegate type:webserviceType];
    }
}

-(void) webServiceClose{
    initialized = NO;
    singleton = nil;
}

-(void) invokeMethodWithDict:(NSDictionary*)data delegate:(id<SMWebServiceDelegate>)delegate type:(SMWebserviceType)webserviceType{
//    _operating = YES;
    
    //Continua somente se existir alguma coisa
    if (data.count>0){
        
        NSLog(@"Envia %@: %@", data[@"url"], data[@"parameters"]);
        
        //Chama webservice
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.securityPolicy.allowInvalidCertificates = YES;
        
        [_manager urlString:[WS_URL stringByAppendingString:data[@"url"]]
                    method:data[@"method"]
                parameters:data[@"parameters"]
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       NSLog(@"Retorno: %@", responseObject);
                       [self webServiceReturn:responseObject delegate:delegate type:webserviceType error:NO];
                   }
                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       
                   }
         ];
    }
}




-(void) setLoadingStatusWithType:(SMWebserviceType)webserviceType{
    switch (webserviceType) {
//        case SMWebserviceTypeRegister:
//            [TABlurredLoading setTitle:@"Enviando registro..."];
//            break;
//        case SMWebserviceTypeLogin:
//            [TABlurredLoading setTitle:@"Validando usuário..."];
//            break;
//        case SMWebserviceTypeRestaurantsList:
//        case SMWebserviceTypeRestaurantsMap:
//            [TABlurredLoading setTitle:@"Recuperando lista..."];
//            break;
        default:
            break;
    }
}


@end
