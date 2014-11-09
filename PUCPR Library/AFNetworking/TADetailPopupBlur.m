////
////  TADetailPopupBlur.m
////  SebraeOffline
////
////  Created by Luis Antonio De Marchi on 19/03/14.
////  Copyright (c) 2014 TechApp. All rights reserved.
////
//
//#import "TADetailPopupBlur.h"
//#import "TADefineProtocol.h"
//#import "TABlurredLoading.h"
//#import "TADetailViewController.h"
//#import "TAAppDelegate.h"
//
//#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)
//#define background_view_tag 35
//
//@interface TADetailPopupBlur () {
//    UIViewController *viewController;
//    UINavigationController *navigationController;
//    UIWindow *windowAlert;
//    
//    TADetailViewController *detailsView;
//    BOOL isLandscape;
//}
//
//@end
//
//@implementation TADetailPopupBlur
//
//static TADetailPopupBlur *sharedSingleton;
//+ (id)newSingleton
//{
//    static BOOL initialized = NO;
//    if(!initialized)
//    {
//        initialized = YES;
//        sharedSingleton = [[TADetailPopupBlur alloc] init];
//    }
//    return sharedSingleton;
//}
//
//+ (void)showObject:(NSDictionary*)object completation:(void (^)(BOOL finished))completion
//{
//    TADetailPopupBlur *viewBlur = [TADetailPopupBlur newSingleton];
//    [viewBlur showObject:object completation:^(BOOL finished) {
//        completion(finished);
//    }];
//}
//
//- (void)showObject:(NSDictionary*)object completation:(void (^)(BOOL finished))completion {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
//    isLandscape = UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
//    
//    viewController = [[UIViewController alloc] init];
//    viewController.view.alpha=0;
//    
//    //Adicionar imagem de fundo com blur (tremida)
//    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[TABlurredLoading screenshot]];
//    backgroundView.tag = background_view_tag;
//    
//    //Adicionar evento para fechar clique fora da tela
//    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                      action:@selector(hide)];
//    [backgroundView addGestureRecognizer:singleFingerTap];
//    singleFingerTap=nil;
//    backgroundView.userInteractionEnabled=YES;
//    
//    
//    [viewController.view addSubview:backgroundView];
//    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
//        //Se for versão antiga ao iOS 7 desconta 20 pixeis da barra de status;
//        CGRect frame = backgroundView.frame;
//        frame.origin.y -= 20;
//        backgroundView.frame = frame;
//    }
//    
//
//    
//    
//    windowAlert = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    windowAlert.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    windowAlert.opaque = NO;
//    windowAlert.windowLevel = 0;
//    windowAlert.rootViewController = viewController;
//    
//    [windowAlert makeKeyAndVisible];
//    
//    [UIView animateWithDuration:0.6
//                          delay:0.
//                        options: UIViewAnimationOptionAllowAnimatedContent
//                     animations:^{
//                         viewController.view.alpha=1;
//                     }
//                     completion:^(BOOL finished){
//                         CGRect frame =  [TABlurredLoading getRectWindow:CGRectNull];
//                         
//                         TAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//                         navigationController = [[[appDelegate window] rootViewController].storyboard instantiateViewControllerWithIdentifier:@"DetailsNav"];
//                         detailsView = (TADetailViewController *) navigationController.topViewController;
//                         detailsView.object = [object valueForKey:@"object"];
//                         [viewController.view addSubview:navigationController.view];
//                         navigationController.view.frame = CGRectMake(frame.size.width/2-250, frame.size.height/2-300, 500, 600);
//                         navigationController.view.layer.cornerRadius = 5.0;
//                         navigationController.view.layer.masksToBounds = YES;
//                         
//                        completion(YES);
//                     }];
//}
//
//+ (void)hide:(void (^)(BOOL finished))completion
//{
//    TADetailPopupBlur *viewBlur = [TADetailPopupBlur newSingleton];
//    [viewBlur hide:^(BOOL finished) {
//        completion(finished);
//    }];
//}
//
//-(void) hide{
//    [self hide:^(BOOL finished) {
//        
//    }];
//}
//
//- (void)hide:(void (^)(BOOL finished))completion {
//    [UIView animateWithDuration:0.4
//                          delay:0.
//                        options: UIViewAnimationOptionAllowAnimatedContent
//                     animations:^{
//                         viewController.view.alpha=0;
//                     }
//                     completion:^(BOOL finished){
//                         [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
//                             [self.delegate hidePopupBluir];
//                         
//                         
//                         detailsView = nil;
//                         viewController = nil;
//                         [windowAlert removeFromSuperview];
//                         windowAlert =nil;
//                         
//                         completion(YES);
//                     }];
//}
//
//- (void) didRotate:(NSNotification *)notification
//{
//    BOOL isLandscapeTemp = UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
//    
//    //Somente se a posição realmente for alterada que some a visualização:
//    if (isLandscape != isLandscapeTemp){
//        [self hide:^(BOOL finished) {
//            
//        }];
//    }
//}
//
//+ (void) setDelegate:(id<TADetailPopupBlurDelegate>)delegate{
//    sharedSingleton.delegate = delegate;
//}
//
//@end
