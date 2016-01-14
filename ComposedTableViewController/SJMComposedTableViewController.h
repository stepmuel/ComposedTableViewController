//
//  SJMComposedTableViewController.h
//  ComposedTables
//
//  Created by Stephan Müller on 12/23/12.
//  Copyright (c) 2012 Stephan Müller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJMComposedTableViewController : UITableViewController

- (void)addCell:(UITableViewCell *)cell;
- (void)addSection;
- (void)setSectionHeader:(NSString *)header;
- (void)setSectionFooter:(NSString *)footer;

- (void)reset;

@end
