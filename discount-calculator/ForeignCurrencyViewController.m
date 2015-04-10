//
//  ForeignCurrencyViewController.m
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 4/6/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForeignCurrencyViewController.h"
#import "CalculatorViewController.h"

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
  
  self.progressView = [[UIProgressView alloc] initWithProgressViewStyle: UIProgressViewStyleDefault];
  self.progressView.hidden = YES;
  [self.view addSubview:self.progressView];
}

- (void)viewDidAppear:(BOOL)animated{
  NSLog(@"viewDidAppear loaded successfully");
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate methods

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
  foreignCurrency = [self.tableData objectAtIndex:indexPath.row];
  
  // create the request and connection
  NSString * yqlString = [NSString stringWithFormat:@"select * from yahoo.finance.xchange where pair in (\"%@%@\")&env=store://datatables.org/alltableswithkeys&format=json", homeCurrency.code, self.foreignCurrency.code];
  
  NSString * urlString = [NSString stringWithFormat:@"http://query.yahooapis.com/v1/public/yql?q=%@", [yqlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
  
  NSURL * yahooRESTQueryURL = [NSURL URLWithString:urlString];
  NSURLRequest * request    = [NSURLRequest requestWithURL:yahooRESTQueryURL];
  
//  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/2/2d/Snake_River_%285mb%29.jpg"]];
  
  self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
  
  if (self.connection) {
    self.buffer = [NSMutableData data];
    [self.connection start];
  }
  else {
    //self.textField.text = @"Connection Failed";
    NSLog(@"Connection Failed");
  }
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  [self.buffer setLength:0];
  self.urlResponse = response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  [self.buffer appendData:data];
  self.progressView.progress = ((100.0/self.urlResponse.expectedContentLength)*self.buffer.length)/100;
  if (self.progressView.progress == 1) {
    self.progressView.hidden = YES;
  } else {
    self.progressView.hidden = NO;
  }
  NSLog(@"%.0f%%", ((100.0/self.urlResponse.expectedContentLength)*self.buffer.length));
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
  return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  // Parsing
  
  ExchangeRate * exchange = [[ExchangeRate alloc] initWithSrcCurrency:homeCurrency destination:foreignCurrency];
  
  // dispatch off the main queue for json processing
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    NSError *error = nil;
    id unknownObject = [NSJSONSerialization JSONObjectWithData:_buffer options:0 error:&error];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      if (!error) {
        if ([unknownObject isKindOfClass:[NSDictionary class]]) {
          NSDictionary * exchangeRateDict = unknownObject;
          NSDictionary * results = [[[exchangeRateDict valueForKey:@"query"] valueForKey:@"results"] valueForKey:@"rate"];
          exchange.rate = @([[results objectForKey:@"Rate"] floatValue]);
          exchange.lastFetchedOn = [NSDate date];
          
          NSString * originalHome = [[homeCurrency.formatter stringFromNumber:_originalPrice] stringByAppendingString:@"  "];
          NSString * discountHome = [[homeCurrency.formatter stringFromNumber:_discountPrice]stringByAppendingString:@"  "];
          NSString * finalHome    = [[homeCurrency.formatter stringFromNumber:_finalPrice]stringByAppendingString:@"  "];
          
          NSString * originalForeign = [foreignCurrency.formatter stringFromNumber:[_originalPrice decimalNumberByMultiplyingBy:[[NSDecimalNumber alloc] initWithFloat:[exchange.rate floatValue]]]];
          NSString * discountForeign = [foreignCurrency.formatter stringFromNumber:[_discountPrice decimalNumberByMultiplyingBy:[[NSDecimalNumber alloc] initWithFloat:[exchange.rate floatValue]]]];
          NSString * finalForeign    = [foreignCurrency.formatter stringFromNumber:[_finalPrice decimalNumberByMultiplyingBy:[[NSDecimalNumber alloc] initWithFloat:[exchange.rate floatValue]]]];
          
          NSArray * views = [[self navigationController] viewControllers];
          CalculatorViewController * calcVC = views[0];
          
          calcVC.originalPrice.text = [originalHome stringByAppendingString:originalForeign];
          calcVC.discountPrice.text = [discountHome stringByAppendingString:discountForeign];
          calcVC.finalPrice.text    = [finalHome stringByAppendingString:finalForeign];
          
          [[self navigationController] popToRootViewControllerAnimated:YES];
        }
      }
      else {
        //self.textField.text = [error localizedDescription];
        NSLog(@"ERROR: %@", [error localizedDescription]);
      }
      // clear the connection
      self.connection = nil;
      self.buffer     = nil;
    });
  });
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  self.connection = nil;
  self.buffer     = nil;
  
  //self.textField.text = [error localizedDescription];
  NSLog(@"Connection failed! Error - %@ %@",
        [error localizedDescription],
        [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

@end