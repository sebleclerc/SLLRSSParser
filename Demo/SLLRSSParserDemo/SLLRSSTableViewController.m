//
//  SLLRSSTableViewController.m
//  SLLRSSParserDemo
//
//  Created by Sébastien Leclerc Lavallée on 16-08-19.
//  Copyright © 2016 Sébastien Leclerc Lavallée. All rights reserved.
//

#import "SLLRSSTableViewController.h"
#import "SLLRSSEntry.h"
#import "SLLRSSParser.h"
#import "SVProgressHUD.h"

@interface SLLRSSTableViewController ()

@property (nonatomic, strong) NSArray *listItems;
@property (nonatomic, strong) NSString *cellIdentifier;

@end

@implementation SLLRSSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cellIdentifier = @"RSSCell";
    [self.tableView registerClass:UITableViewCell.self forCellReuseIdentifier:_cellIdentifier];
    
    self.navigationItem.title = @"RSS feed";
    
    [SVProgressHUD show];
    
    SLLRSSParser *parser = [[SLLRSSParser alloc] initWithFeedUrlString:@"http://developer.apple.com/swift/blog/news.rss"];
    [parser parseRSSFeed:^(NSArray *listFeedItems) {
        _listItems = listFeedItems;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
            [SVProgressHUD dismiss];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SLLRSSEntry *entryAtIndexPath = [_listItems objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    // Configure the cell...
    [cell.textLabel setText:entryAtIndexPath.title];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
