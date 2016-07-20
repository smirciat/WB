//
//  addViewController.h
//  WB
//
//  Created by Andrew Smircich on 5/16/15.
//  Copyright (c) 2015 Andrew Smircich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textName;
@property (weak, nonatomic) IBOutlet UITextField *textMaxgross;
@property (weak, nonatomic) IBOutlet UITextField *textEmptymoment;
@property (weak, nonatomic) IBOutlet UITextField *textFwdlimit;
@property (weak, nonatomic) IBOutlet UITextField *textFwdlimitgross;
@property (weak, nonatomic) IBOutlet UITextField *textFwdlimitwt;
@property (weak, nonatomic) IBOutlet UITextField *textRow2arm;
@property (weak, nonatomic) IBOutlet UITextField *textRow3arm;
@property (weak, nonatomic) IBOutlet UITextField *textFuelarm;
@property (weak, nonatomic) IBOutlet UITextField *textAftcargoarm;
@property (weak, nonatomic) IBOutlet UITextField *textEmptywt;
@property (weak, nonatomic) IBOutlet UITextField *textAftlimit;
@property (weak, nonatomic) IBOutlet UITextField *textRow1arm;
@property (weak, nonatomic) IBOutlet UITextField *textPodarm;

@property (strong,nonatomic) NSManagedObject *aircraft;

@end
