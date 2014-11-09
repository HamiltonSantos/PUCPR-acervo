//
//  ResultsTableViewController.h
//  PUCPR Library
//
//  Created by Hamilton Carlos da Silva Santos on 9/21/14.
//  Copyright (c) 2014 Hamilton Carlos da Silva Santos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsTableViewController : UITableViewController
@property (strong, nonatomic) NSArray *results;
@property (strong,nonatomic) NSDictionary *selectedBook;
@end
