//
//  RootViewController.m
//  Couchbase Mobile
//
//  Created by Jan Lehnardt on 27/11/2010.
//  Copyright 2011 Couchbase, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not
// use this file except in compliance with the License. You may obtain a copy of
// the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
// WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
// License for the specific language governing permissions and limitations under
// the License.
//

#import "CouchViewController.h"

#import <CouchCocoa/CouchCocoa.h>
#import <CouchCocoa/CouchDesignDocument_Embedded.h>



@implementation CouchViewController


@synthesize dataSource;
@synthesize tableView;
@synthesize design;
@synthesize couchview;

#pragma mark - View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CouchUITableSource class];     // Prevents class from being dead-stripped by linker
    
    // Create a query sorted by descending date, i.e. newest items first:
    NSAssert(database!=nil, @"Not hooked up to database yet");
    CouchLiveQuery* query = [[[database designDocumentWithName: self.design]
                              queryViewNamed: self.couchview] asLiveQuery];
    query.descending = NO;
    
    self.dataSource.query = query;
    //self.dataSource.labelProperty = @"_key";    // Document property to display in the cell label
    
}


- (void)useDatabase:(CouchDatabase*)theDatabase {
    database = theDatabase;
    
    // Create a 'view' containing list items sorted by date:
    
}



#pragma mark - Couch table source delegate


// Customize the appearance of table view cells.
- (void)couchTableSource:(CouchUITableSource*)source
             willUseCell:(UITableViewCell*)cell
                  forRow:(CouchQueryRow*)row
{
    // Set the cell background and font:
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    cell.textLabel.font = [UIFont fontWithName: @"Helvetica" size:18.0];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
}


#pragma mark - Table view delegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


#pragma mark - Editing:



#pragma mark - UITextField delegate



@end
