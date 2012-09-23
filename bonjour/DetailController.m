//
//  DetailController.m
//  bonjour
//
//  Created by Peter Morton on 23/09/12.
//  Copyright (c) 2012 Peter Morton. All rights reserved.
//

#import "DetailController.h"


#import <netinet/in.h>
#import <arpa/inet.h>

@interface DetailController ()

@end

@implementation DetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!self.service.hostName)
        return 1;
    else
        return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail"];
    
    switch(indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"name";
            cell.detailTextLabel.text = self.service.name;
            break;
        case 1:
            cell.textLabel.text = @"hostname";
            cell.detailTextLabel.text = self.service.hostName;
            break;
        case 2:
            cell.textLabel.text = @"ip";
            if([self.service.addresses count] > 0)
            {
                struct sockaddr_in addr = *(struct sockaddr_in *)[self.service.addresses[0] bytes];
                cell.detailTextLabel.text = [NSString stringWithFormat: @"%s", inet_ntoa(addr.sin_addr)];
            }
            else
                cell.detailTextLabel.text = @"not resolved";
            break;
        case 3:
            cell.textLabel.text = @"port";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", self.service.port];
            break;
    }
    
    return cell;
}

@end


