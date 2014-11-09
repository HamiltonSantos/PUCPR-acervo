//
//  TADetailPopupBlur.h
//  SebraeOffline
//
//  Created by Luis Antonio De Marchi on 19/03/14.
//  Copyright (c) 2014 TechApp. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol TADetailPopupBlurDelegate
-(void) hidePopupBluir;
@end

@interface TADetailPopupBlur : NSObject
@property (nonatomic) id<TADetailPopupBlurDelegate> delegate;

+ (void)showObject:(NSDictionary*)object completation:(void (^)(BOOL finished))completion;
+ (void)hide:(void (^)(BOOL finished))completion;
+ (void) setDelegate:(id<TADetailPopupBlurDelegate>)delegate;
@end
