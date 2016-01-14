//
//  SJMActiveCell.h
//  ComposedTables
//
//  Created by Stephan Müller on 12/27/12.
//  Copyright (c) 2012 Stephan Müller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJMActiveCell : UITableViewCell

+ (SJMActiveCell *)cell;

@property (weak, nonatomic) UITableViewController *tableViewController;

@property (nonatomic) CGFloat height;

@property (strong, nonatomic) void (^actionBlock)(SJMActiveCell *cell);

@property (nonatomic) BOOL enabled;

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *value;

- (void)deselectAnimated:(BOOL)animated;

@end
