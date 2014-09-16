//
//  SearchViewController.m
//  PUCPR Library
//
//  Created by Hamilton Carlos da Silva Santos on 5/24/14.
//  Copyright (c) 2014 Hamilton Carlos da Silva Santos. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController (){
    NSDictionary *result;
}
@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.searchDisplayController setDelegate:self];
    [self.searchDisplayController setSearchResultsDataSource:self];
    [self.searchDisplayController setSearchResultsDelegate:self];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SampleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSDictionary *book = self.results[indexPath.row];
    [cell.textLabel setText:book[@"title"]];
    return cell;
}
- (IBAction)shareCanvas:(id)sender {
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[self.bookImage.image]
                                      applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSDictionary *parameters = @{@"title":searchBar.text};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://hamilton-library.herokuapp.com/search.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        self.results = responseObject;

        [self.searchDisplayController.searchResultsTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    result = [self.results objectAtIndex:indexPath.row];
    self.titleLabel.text = result[@"title"];
    _authorLabel.text = result[@"author"];
    _callNumberLabel.text = [result[@"call_number"] stringValue];
    _locationLabel.text = result[@"location"];
    [self.searchBar resignFirstResponder];
    [self.searchDisplayController setActive:NO animated:YES];
    
    
}
@end