//
//  TABlurredLoading.m
//  Expert-Log
//
//  Created by Luis Antonio De Marchi on 02/12/13.
//  Copyright (c) 2013 Snow. All rights reserved.
//

#import "TABlurredLoading.h"
#import "UIImage+BlurredFrame.h"
#import "SMDefineProtocol.h"
#import "RTSpinKitView.h"
#import "UIImage+Additional.h"
#import "SMDefineProtocol.h"

#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)
#define background_view_tag 3545
#define window_alert_tag 3546

@interface TABlurredLoading (){
    UIViewController *viewController;
    UIWindow *windowAlert;
    
    UILabel *title;
}

@end

@implementation TABlurredLoading

static TABlurredLoading *singleton;
static BOOL initialized = NO;

//Singleton - Recupera o objeto de WS que estiver aberto:
+(TABlurredLoading*) newSingleton{
    if(!initialized)
    {
        initialized = YES;
        singleton = [[TABlurredLoading alloc] init];
    }
    
    return singleton;
}


+ (void)show:(void (^)(BOOL finished))completion
{
    TABlurredLoading *blurredLoading = [TABlurredLoading newSingleton];
    [blurredLoading show:^(BOOL finished) {
        completion(finished);
    }];
}

- (void)show:(void (^)(BOOL finished))completion {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    viewController = [[UIViewController alloc] init];
    viewController.view.alpha=0;
    viewController.view.frame =  [TABlurredLoading getRectWindow:CGRectNull];
    
    //Adicionar imagem de fundo com blur (tremida)
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[TABlurredLoading screenshot]];
    backgroundView.tag =background_view_tag;
    [viewController.view addSubview:backgroundView];
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        //Se for versão antiga ao iOS 7 desconta 20 pixeis da barra de status;
        CGRect frame = backgroundView.frame;
        frame.origin.y -= 20;
        backgroundView.frame = frame;
    }
    
    
    //Loading
    [viewController.view addSubview:[self createLoading]];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(20, viewController.view.frame.size.height/2+30, viewController.view.frame.size.width-40, 40)];
    title.textAlignment = NSTextAlignmentCenter;
    title.numberOfLines = 2;
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    [viewController.view addSubview:title];
    

    windowAlert = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    windowAlert.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    windowAlert.opaque = NO;
    windowAlert.windowLevel = 0;
    windowAlert.rootViewController = viewController;
    windowAlert.tag = window_alert_tag;
    
    [windowAlert makeKeyAndVisible];
    
    [UIView animateWithDuration:0.4
                          delay:0.
                        options: UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         viewController.view.alpha=1;
                     }
                     completion:^(BOOL finished){
                         completion(YES);
                     }];
}

+ (void) setTitle:(NSString*)newTitle{
    TABlurredLoading *blurredLoading = [TABlurredLoading newSingleton];
    [blurredLoading setTitle:newTitle];
    
}
-(void) setTitle:(NSString*)newTitle{
    [UIView animateWithDuration:0.4
                          delay:0.
                        options: UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         title.text = newTitle;
                     }
                     completion:^(BOOL finished){
                     }];
}


+ (void)hide:(void (^)(BOOL finished))completion
{
    TABlurredLoading *blurredLoading = [TABlurredLoading newSingleton];
    [blurredLoading hide:^(BOOL finished) {
        singleton=nil;
        initialized = NO;
        completion(finished);
    }];
}

- (void)hide:(void (^)(BOOL finished))completion {
    [UIView animateWithDuration:0.4
                          delay:0.
                        options: UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         viewController.view.alpha=0;
                     }
                     completion:^(BOOL finished){
                         [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
                         title=nil;
                         viewController = nil;
                         [windowAlert removeFromSuperview];
                         windowAlert =nil;
                         
                         completion(YES);
                     }];
}

- (void) didRotate:(NSNotification *)notification
{
    
    UIImageView *backgroundView = (UIImageView*)[viewController.view viewWithTag:background_view_tag];
    backgroundView.image = [TABlurredLoading screenshot];
    viewController.view.frame = backgroundView.frame = [TABlurredLoading getRectWindow:CGRectNull];
    
    
}

+ (UIImage *)screenshot
{
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Iterate over every window from back to front
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        if ((![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])&&window.tag != window_alert_tag)
        {
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, [window transform]);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            // Render the layer hierarchy to the current context
            [[window layer] renderInContext:context];
            
            // Restore the context
            CGContextRestoreGState(context);
        }
    }
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIColor *tintColor = [UIColor colorWithWhite:0.1 alpha:0.2];
    
    image = [image applyBlurWithRadius:5 tintColor:tintColor saturationDeltaFactor:1 maskImage:nil atFrame:CGRectZero];
    
    return [self rotateImageToStatusBarOrientation:image];
}

+ (UIImage *)rotateImageToStatusBarOrientation:(UIImage *)image
{
    UIInterfaceOrientation currrentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
        if (currrentOrientation == UIInterfaceOrientationLandscapeLeft) {
            return [image imageRotatedByDegrees:90];
        } else if (currrentOrientation == UIInterfaceOrientationLandscapeRight) {
            return [image imageRotatedByDegrees:-90];
        } else if (currrentOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            return [image imageRotatedByDegrees:180];
        }

    return image;
}

+ (CGRect)getRectWindow:(CGRect)frame
{
    UIInterfaceOrientation currrentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if (CGRectIsNull(frame))
        frame = [[UIScreen mainScreen] bounds];
    
    if (IS_IPAD){
        //Se a tela estiver virado então inverte altura por largura:
        if (currrentOrientation == UIInterfaceOrientationLandscapeLeft ||
            currrentOrientation == UIInterfaceOrientationLandscapeRight) {
            frame = CGRectMake(0, 0, frame.size.height, frame.size.width);
        }
    }
    
    return frame;
}

-(RTSpinKitView*) createLoading{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleCircle color:[UIColor whiteColor]];
    
    //inverti x e y aqui para funcionar em landscape
    spinner.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    [spinner startAnimating];
    
    return spinner;
}

@end
