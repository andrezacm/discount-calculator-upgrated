//
//  ForeignCurrencyViewController.m
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 4/6/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForeignCurrencyViewController.h"

@implementation ForeignCurrencyViewController

@synthesize tableData;
@synthesize homeCurrency;
@synthesize foreignCurrency;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  // Creating table view
  UITableView * tableView    = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
  tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
  tableView.delegate         = self;
  tableView.dataSource       = self;
  
  // Set header
  CGRect titleRect = CGRectMake(0, 0, 300, 40);
  UILabel * tableTitle = [[UILabel alloc] initWithFrame:titleRect];
  //tableTitle.textColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
  tableTitle.backgroundColor = [tableView backgroundColor];
  tableTitle.opaque = YES;
  tableTitle.font = [UIFont boldSystemFontOfSize:18];
  tableTitle.text = @"Choose your foreign currency";
  tableView.tableHeaderView = tableTitle;
  
  [tableView reloadData];
  
  self.view = tableView;
    
  NSLog(@">>> %@", homeCurrency.currency);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString * simpleTableIdentifier = @"SimpleTableItem";
  
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
  }
  
  cell.textLabel.text = [[self.tableData objectAtIndex:indexPath.row] currency];
  
  return cell;
}

@end