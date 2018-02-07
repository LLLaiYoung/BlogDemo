//
//  ViewController.m
//  iBeaconDemo
//
//  Created by LaiYoung_ on 2018/2/4.
//  Copyright © 2018年 LaiYoung_. All rights reserved.
//

#import "ViewController.h"
#import "DiscoverBeaconViewController.h"
#import "SimulationBeaconViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"iBeacon";
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = (id)self;
        _tableView.dataSource = (id)self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass(self.class)];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"发现Beacon";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"模拟Beacon";
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 0) {
        DiscoverBeaconViewController *vc = [[DiscoverBeaconViewController alloc] init];
        vc.title = cell.textLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        UIStoryboard *storeboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        SimulationBeaconViewController *vc = (SimulationBeaconViewController *)[storeboard instantiateViewControllerWithIdentifier:@"SimulationBeaconViewController"];
        vc.title = cell.textLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end

