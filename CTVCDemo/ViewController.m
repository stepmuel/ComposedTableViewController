//
//  ViewController.m
//  CTVCDemo
//
//  Created by Stephan Müller on 22/12/15.
//  Copyright © 2015 Stephan Müller. All rights reserved.
//

#import "ViewController.h"

#import "SJMActiveCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.title = @"CTVCDemo";
        [self compose];
    }
    return self;
}

- (void)compose {
    SJMActiveCell *cell;
    
    [self setSectionHeader:@"Test Table"];
    
    cell = [SJMActiveCell cell];
    cell.key = @"active cell";
    cell.value = @"123";
    [self addCell:cell];
    
    cell = [SJMActiveCell cell];
    cell.key = @"disabled cell";
    cell.value = @"456";
    cell.enabled = NO;
    [self addCell:cell];
    
    cell = [SJMActiveCell cell];
    cell.key = @"extra high";
    cell.value = @"789";
    cell.height = 100.0;
    [self addCell:cell];
    
    UITableViewCell *genericCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    genericCell.textLabel.text = @"generic table view cell";
    [self addCell:genericCell];
    
    [self addSection];
    
    [self setSectionHeader:@"Actions"];
    
    // toggle checkmark on select
    cell = [SJMActiveCell cell];
    cell.key = @"check";
    cell.actionBlock = ^(SJMActiveCell *cell) {
        [cell deselectAnimated:YES];
        if (cell.accessoryType==UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    };
    [self addCell:cell];
    
    // center text label to indicate action (only available on default style)
    cell = [[SJMActiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.key = @"disabled action";
    cell.enabled = NO;
    cell.actionBlock = ^(SJMActiveCell *cell) {
        NSLog(@"not called");
        [cell deselectAnimated:YES];
    };
    [self addCell:cell];
    
    [self addSection];
    
    [self setSectionHeader:@"Segues"];
    
    cell = [SJMActiveCell cell];
    cell.key = @"green";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.actionBlock = ^(SJMActiveCell *cell) {
        // just create the required view controller right here!
        UIViewController *vc = [[UIViewController alloc] init];
        vc.title = @"green";
        vc.view.backgroundColor = [UIColor colorWithRed:0.224 green:0.792 blue:0.455 alpha:1.00];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self addCell:cell];
    
    cell = [SJMActiveCell cell];
    cell.key = @"square table";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.actionBlock = ^(SJMActiveCell *cell) {
        // move code to create more complicated view controllers into their own function
        [self.navigationController pushViewController:[self squareTable] animated:YES];
    };
    [self addCell:cell];
}

- (SJMComposedTableViewController *)squareTable {
    SJMComposedTableViewController *vc = [[SJMComposedTableViewController alloc] init];
    vc.title = @"square table";
    for (NSInteger i=0; i<10; i+=1) {
        SJMActiveCell *cell = [SJMActiveCell cell];
        cell.key = [NSString stringWithFormat:@"%ld", (long)i];
        cell.value = [NSString stringWithFormat:@"%ld", (long)i*i];
        [vc addCell:cell];
    }
    return vc;
}

@end
