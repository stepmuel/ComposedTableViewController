//
//  SJMActiveCell.m
//  ComposedTables
//
//  Created by Stephan Müller on 12/27/12.
//  Copyright (c) 2012 Stephan Müller. All rights reserved.
//

#import "SJMActiveCell.h"

@implementation SJMActiveCell

+ (SJMActiveCell *)cell {
    return [[SJMActiveCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.enabled = YES;
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    self.textLabel.enabled = enabled;
    self.detailTextLabel.enabled = enabled;
}

- (void)deselectAnimated:(BOOL)animated {
    NSIndexPath *indexPath = self.tableViewController.tableView.indexPathForSelectedRow;
    [self.tableViewController.tableView deselectRowAtIndexPath:indexPath animated:animated];
}

- (NSString *)key {
    return self.textLabel.text;
}

- (void)setKey:(NSString *)key {
    self.textLabel.text = key;
}

- (NSString *)value {
    return self.detailTextLabel.text;
}

- (void)setValue:(NSString *)value {
    self.detailTextLabel.text = value;
}

@end
