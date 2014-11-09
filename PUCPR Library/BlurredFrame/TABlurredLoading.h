//
//  TABlurredLoading.h
//  Expert-Log
//
//  Created by Luis Antonio De Marchi on 02/12/13.
//  Copyright (c) 2013 Snow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TABlurredLoading : NSObject

+ (void)show:(void (^)(BOOL finished))completion;
+ (void)hide:(void (^)(BOOL finished))completion;

+ (void) setTitle:(NSString*)newTitle;

+ (UIImage *)screenshot;
+ (CGRect)getRectWindow:(CGRect)frame;

@end
