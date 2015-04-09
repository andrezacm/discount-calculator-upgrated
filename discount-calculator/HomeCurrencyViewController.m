//
//  HomeCurrencyViewController.m
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 4/5/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeCurrencyViewController.h"
#import "ForeignCurrencyViewController.h"
#import "Currency.h"

@implementation HomeCurrencyViewController

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
  tableTitle.text = @"Choose your home currency";
  tableView.tableHeaderView = tableTitle;
  
  [tableView reloadData];
  
  self.view = tableView;
  
  self.tableData = [NSMutableArray arrayWithObjects: [Currency theBritishPound], [Currency theDanishKroner], [Currency theIndianRupee], nil];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  
  ForeignCurrencyViewController * foreignCurrencyController = [[ForeignCurrencyViewController alloc] init];
  NSMutableArray * temp = [NSMutableArray arrayWithArray:self.tableData];
  [temp removeObject:[self.tableData objectAtIndex:indexPath.row]];
  foreignCurrencyController.tableData     = temp;
  foreignCurrencyController.originalPrice = _originalPrice;
  foreignCurrencyController.finalPrice    = _finalPrice;
  foreignCurrencyController.discountPrice = _discountPrice;
  foreignCurrencyController.homeCurrency  = [self.tableData objectAtIndex:indexPath.row];
  [[self navigationController] pushViewController:foreignCurrencyController animated:YES];
}

@end