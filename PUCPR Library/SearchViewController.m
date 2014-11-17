//
//  SearchTableViewController.m
//  PUCPR Library
//
//  Created by Hamilton Carlos da Silva Santos on 9/21/14.
//  Copyright (c) 2014 Hamilton Carlos da Silva Santos. All rights reserved.
//

#import "SearchViewController.h"
#import "ResultsTableViewController.h"

@interface SearchViewController () <SMWebServiceDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _filterButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    
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
    [self performSegueWithIdentifier:@"modalDetail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"modalDetail"]){
        UINavigationController *navController = (UINavigationController*)segue.destinationViewController;
        DetailsViewController *controller = navController.viewControllers[0];
        controller.book = _selectedBook;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [SMWebService searchBooks:textField.text delegate:self];
    
    return YES;
}

-(void)webServiceWithMethod:(SMWebserviceType)method data:(NSArray *)data error:(BOOL)error show:(void (^)(BOOL))block{
    //Se tiver erro exibe alerta
    if (error){
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"Houve um problema, por favor tente mais tarde."
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil, nil] show];
    }else{
        _results = data;
        [_resultsTable reloadData];

    }
}


- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
