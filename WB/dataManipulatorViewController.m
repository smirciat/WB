//
//  dataManipulatorViewController.m
//  WB
//
//  Created by Andrew Smircich on 5/16/15.
//  Copyright (c) 2015 Andrew Smircich. All rights reserved.
//

#import "dataManipulatorViewController.h"


@interface dataManipulatorViewController ()

@end

@implementation dataManipulatorViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (void)cancelAndDismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)saveAndDismiss{
        
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
