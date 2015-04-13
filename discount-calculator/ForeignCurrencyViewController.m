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
#import "DiscountCalculatorDoc.h"
#import "DiscountCalculatorDatabase.h"

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
  
  _progressView = [[UIProgressView alloc] initWithProgressViewStyle: UIProgressViewStyleDefault];
  _progressView.hidden = YES;
  [self.view addSubview:_progressView];
  
  _testdata = [DiscountCalculatorDatabase loadDocs];
  DiscountCalculatorDoc * d = [_testdata firstObject];
  ExchangeRate * dic = [d data];
  NSLog(@"OPA >%@", [dic description]);
  
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
  return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString * simpleTableIdentifier = @"SimpleTableItem";
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
  }
  
  cell.textLabel.text = [[tableData objectAtIndex:indexPath.row] currency];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  foreignCurrency = [tableData objectAtIndex:indexPath.row];
  _exchange   = [[ExchangeRate alloc] initWithSrcCurrency:homeCurrency destination:foreignCurrency];
  // create the request and connection
  NSString * yqlString = [NSString stringWithFormat:@"select * from yahoo.finance.xchange where pair in (\"%@%@\")&env=store://datatables.org/alltableswithkeys&format=json", homeCurrency.code, foreignCurrency.code];
  
  NSString * urlString = [NSString stringWithFormat:@"http://query.yahooapis.com/v1/public/yql?q=%@", [yqlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
  
  NSURL * yahooRESTQueryURL = [NSURL URLWithString:urlString];
  NSURLRequest * request    = [NSURLRequest requestWithURL:yahooRESTQueryURL];
  
//  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/2/2d/Snake_River_%285mb%29.jpg"]];
  
  _connection = [NSURLConnection connectionWithRequest:request delegate:self];
  
  if (_connection) {
    _buffer = [NSMutableData data];
    [_connection start];
  }
  else {
    //self.textField.text = @"Connection Failed";
    NSLog(@"Connection Failed");
  }
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  [_buffer setLength:0];
  _urlResponse = response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  [_buffer appendData:data];
  _progressView.progress = ((100.0/_urlResponse.expectedContentLength)*_buffer.length)/100;
  if (_progressView.progress == 1) {
    _progressView.hidden = YES;
  } else {
    _progressView.hidden = NO;
  }
  NSLog(@"%.0f%%", ((100.0/_urlResponse.expectedContentLength)*_buffer.length));
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
  return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  // Parsing
  // dispatch off the main queue for json processing
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    NSError * error = nil;
    id unknownObject = [NSJSONSerialization JSONObjectWithData:_buffer options:0 error:&error];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      if (!error) {
        if ([unknownObject isKindOfClass:[NSDictionary class]]) {
          NSDictionary * exchangeRateDict = unknownObject;
          NSDictionary * results = [[[exchangeRateDict valueForKey:@"query"] valueForKey:@"results"] valueForKey:@"rate"];
          _exchange.rate = @([[results objectForKey:@"Rate"] floatValue]);
          _exchange.lastFetchedOn = [NSDate date];
          
          [_exchange save];
          
          NSString * originalHome = [[homeCurrency.formatter stringFromNumber:_originalPrice] stringByAppendingString:@"  "];
          NSString * discountHome = [[homeCurrency.formatter stringFromNumber:_discountPrice]stringByAppendingString:@"  "];
          NSString * finalHome    = [[homeCurrency.formatter stringFromNumber:_finalPrice]stringByAppendingString:@"  "];
          
          NSString * originalForeign = [foreignCurrency.formatter stringFromNumber:[_originalPrice decimalNumberByMultiplyingBy:[[NSDecimalNumber alloc] initWithFloat:[_exchange.rate floatValue]]]];
          NSString * discountForeign = [foreignCurrency.formatter stringFromNumber:[_discountPrice decimalNumberByMultiplyingBy:[[NSDecimalNumber alloc] initWithFloat:[_exchange.rate floatValue]]]];
          NSString * finalForeign    = [foreignCurrency.formatter stringFromNumber:[_finalPrice decimalNumberByMultiplyingBy:[[NSDecimalNumber alloc] initWithFloat:[_exchange.rate floatValue]]]];
          
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
      _connection = nil;
      _buffer     = nil;
    });
  });
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  _connection = nil;
  _buffer     = nil;
  
  //self.textField.text = [error localizedDescription];
  NSLog(@"Connection failed! Error - %@ %@",
        [error localizedDescription],
        [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

@end