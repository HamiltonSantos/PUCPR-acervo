//
//  ResultsTableViewController.m
//  PUCPR Library
//
//  Created by Hamilton Carlos da Silva Santos on 9/21/14.
//  Copyright (c) 2014 Hamilton Carlos da Silva Santos. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "DetailsViewController.h"

@interface ResultsTableViewController ()

@end

@implementation ResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *book = self.results[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell" forIndexPath:indexPath];
    UIImageView *photo;
    photo = (UIImageView*) [cell viewWithTag:1];
    [photo setImage:[UIImage imageNamed:@"lotr"]];// ainda precisa corrigir para pegar valor do resultado
    UILabel *title;
    title = (UILabel*)[cell viewWithTag:2];
    title.text = book[@"title"];
    
    UILabel *author;
    author = (UILabel*)[cell viewWithTag:3];
    author.text = book[@"author"];
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedBook = _results[indexPath.row];
    [self performSegueWithIdentifier:@"pushDetail" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"pushDetail"]){
        DetailsViewController *controller = (DetailsViewController *)segue.destinationViewController;
        controller.book = _selectedBook;
    }
}@end
