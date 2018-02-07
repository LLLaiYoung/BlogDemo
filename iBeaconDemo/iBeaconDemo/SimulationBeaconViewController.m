//
//  SimulationBeaconViewController.m
//  iBeaconDemo
//
//  Created by LaiYoung_ on 2018/2/4.
//  Copyright © 2018年 LaiYoung_. All rights reserved.
//

#import "SimulationBeaconViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface SimulationBeaconViewController ()
<
CBPeripheralManagerDelegate
>
@property (weak, nonatomic) IBOutlet UITextField *UUIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *majorTextField;
@property (weak, nonatomic) IBOutlet UITextField *minorTextField;
@property (weak, nonatomic) IBOutlet UIButton *radioBtn;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@end

@implementation SimulationBeaconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.peripheralManager= [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
}
- (IBAction)clickedStartBtn:(UIButton *)sender {
    if (!sender.isSelected) {
        NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:self.UUIDTextField.text];
        //创建beacon区域
        CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID major:self.majorTextField.text.integerValue minor:self.minorTextField.text.integerValue identifier:@"test"];
        NSDictionary *beaconPeripheraData = [beaconRegion peripheralDataWithMeasuredPower:nil];
        
        if(beaconPeripheraData) {
            [self.peripheralManager startAdvertising:beaconPeripheraData];;//开始广播
        }
        
        [sender setTitle:@"停止广播" forState:UIControlStateNormal];
    } else {
        [self.peripheralManager stopAdvertising];
        [sender setTitle:@"开始广播" forState:UIControlStateNormal];
    }
    
    sender.selected ^= 1;
}

#pragma mark - CBPeripheralManagerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
//    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
//        NSDictionary *beaconPeripheraData = nil;
//        NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:@"063FA845-F091-4129-937D-2A189A86D844"];
//        //创建beacon区域
//        CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID major:666 minor:999 identifier:@"test"];
//        beaconPeripheraData = [beaconRegion peripheralDataWithMeasuredPower:nil];
//
//        if(beaconPeripheraData) {
//            [self.peripheralManager startAdvertising:beaconPeripheraData];;//开始广播
//        }
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
