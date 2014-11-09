//
//  SearchTableViewController.h
//  PUCPR Library
//
//  Created by Hamilton Carlos da Silva Santos on 9/21/14.
//  Copyright (c) 2014 Hamilton Carlos da Silva Santos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) NSArray *results;
@property (weak, nonatomic) IBOutlet UIButton *filterButton;
@property (weak, nonatomic) IBOutlet UITableView *resultsTable;
@end
