//
//  SearchViewController.h
//  PUCPR Library
//
//  Created by Hamilton Carlos da Silva Santos on 5/24/14.
//  Copyright (c) 2014 Hamilton Carlos da Silva Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface SearchViewController : UIViewController <UISearchDisplayDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *callNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end
