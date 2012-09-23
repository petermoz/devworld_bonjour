//
//  ViewController.m
//  bonjour
//
//  Created by Peter Morton on 23/09/12.
//  Copyright (c) 2012 Peter Morton. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSNetServiceBrowserDelegate>

@property (retain) NSMutableArray *services;
@property (retain) NSNetServiceBrowser *browser;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.services = [[NSMutableArray alloc] init];
    self.browser = [[NSNetServiceBrowser alloc] init];
    
    self.browser.delegate = self;
    [self.browser searchForServicesOfType:@"_dev_world._tcp" inDomain:@"local"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.services.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNetService *service = self.services[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"service"];
    cell.textLabel.text = service.name;
    return cell;
}

# pragma mark - NetServiceBrowser delegate

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
    [self.services addObject:aNetService];
    if(!moreComing)
        [self.tableView reloadData];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
    [self.services removeObject:aNetService];
    if(!moreComing)
        [self.tableView reloadData];
}


@end
