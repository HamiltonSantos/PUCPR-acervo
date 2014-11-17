//
//  SearchViewController.m
//  PUCPR Library
//
//  Created by Hamilton Carlos da Silva Santos on 5/24/14.
//  Copyright (c) 2014 Hamilton Carlos da Silva Santos. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController () <SMWebServiceDelegate>{
    NSDictionary *result;
}
@end

@implementation DetailsViewController

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
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lotr"]]];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    self.titleLabel.text = _book[@"title"];
    _authorLabel.text = _book[@"author"];
    _callNumberLabel.text = [_book[@"call_number"] stringValue];
    _locationLabel.text = _book[@"location"];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareCanvas:(id)sender {
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[self.bookImage.image]
                                      applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor colorWithRed:.8 green:.8 blue:.8 alpha:.3];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
}

-(void)webServiceWithMethod:(SMWebserviceType)method data:(id)data error:(BOOL)error show:(void (^)(BOOL))block{
    
}

@end