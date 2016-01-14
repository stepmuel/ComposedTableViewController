//
//  SJMComposedTableViewController.m
//  ComposedTables
//
//  Created by Stephan Müller on 12/23/12.
//  Copyright (c) 2012 Stephan Müller. All rights reserved.
//

#import "SJMComposedTableViewController.h"

#import "SJMActiveCell.h"

@interface SJMComposedTableViewController ()

@property (strong, nonatomic) NSMutableArray <NSMutableDictionary *> *sections;

@end

@implementation SJMComposedTableViewController

- (NSMutableArray<NSMutableDictionary *> *)sections {
    if (_sections==nil) {
        _sections = [NSMutableArray array];
        if (_sections) {
            [self addSection];
        }
    }
    return _sections;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sections[section][@"cells"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.sections[indexPath.section][@"cells"][indexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section][@"header"];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return self.sections[section][@"footer"];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[SJMActiveCell class]]) {
        SJMActiveCell *ac = (SJMActiveCell *)cell;
        if (ac.enabled && ac.actionBlock) {
            ac.actionBlock(ac);
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = self.sections[indexPath.section][@"cells"][indexPath.row];
    if ([cell isKindOfClass:[SJMActiveCell class]]) {
        SJMActiveCell *ac = (SJMActiveCell *)cell;
        return ac.enabled!=NO && ac.actionBlock!=nil;
    } else {
        return NO;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0;
    id cell = self.sections[indexPath.section][@"cells"][indexPath.row];
    if ([cell isKindOfClass:[SJMActiveCell class]]) {
        height = [(SJMActiveCell *)cell height];
    }
    if (height==0.0) {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    } else {
        return height;
    }
}

#pragma mark - compose functions

- (void)addCell:(UITableViewCell *)cell {
    if ([cell isKindOfClass:[SJMActiveCell class]]) {
        [(SJMActiveCell *)cell setTableViewController:self];
    }
    NSMutableArray *cells = [self.sections lastObject][@"cells"];
    [cells addObject:cell];
}

- (void)reset {
    self.sections = nil;
}

- (void)addSection {
    NSMutableDictionary *sect = [NSMutableDictionary dictionaryWithObject:[NSMutableArray array] forKey:@"cells"];
    [self.sections addObject:sect];
}

- (void)setSectionHeader:(id)header {
    NSMutableDictionary *section = [self.sections lastObject];
    [section setObject:header forKey:@"header"];
}

- (void)setSectionFooter:(id)footer {
    NSMutableDictionary *section = [self.sections lastObject];
    [section setObject:footer forKey:@"footer"];
}

@end



