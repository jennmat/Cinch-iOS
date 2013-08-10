//
//  MyTestViewController.h
//  Cinch
//
//  Created by Matt on 7/28/13.
//  Copyright (c) 2013 cinch. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CouchCocoa/CouchUITableSource.h>
@class CouchDatabase, CouchPersistentReplication;

@interface CouchViewController : UIViewController<CouchUITableDelegate> {
    CouchDatabase *database;
}

@property(nonatomic, strong) IBOutlet UITableView *tableView;
@property(nonatomic, strong) IBOutlet CouchUITableSource* dataSource;
@property (nonatomic) NSString* design;
@property (nonatomic) NSString* couchview;

-(void)useDatabase:(CouchDatabase*)theDatabase;


@end

