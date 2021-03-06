//
//  comViewController.h
//  WB
//
//  Created by Andy on 5/3/15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "GlobalVars.h"
#import "comChart.h"


@interface comViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak,nonatomic) IBOutlet comChart *chartView;

@property(nonatomic) float myRow1arm,myRow2arm,myRow3arm,myFuelarm,myPodarm,myAftcargoarm;
@property(nonatomic) NSString *myAircraftname;
@property (strong, nonatomic) IBOutlet UIButton *rb1;
@property (strong, nonatomic) IBOutlet UIButton *radiobutton2;
@property (strong, nonatomic) IBOutlet UIButton *radiobutton3;
@property (strong, nonatomic) IBOutlet UIButton *radiobutton4;
@property (strong, nonatomic) IBOutlet UIButton *radiobutton5;
@property (strong, nonatomic) IBOutlet UIButton *radiobutton6;

@property (strong, nonatomic) IBOutlet UIButton *a;
@property (strong, nonatomic) IBOutlet UIButton *a1;
@property (strong, nonatomic) IBOutlet UIButton *a2;
@property (strong, nonatomic) IBOutlet UIButton *a3;
@property (strong, nonatomic) IBOutlet UIButton *a4;
@property (strong, nonatomic) IBOutlet UIButton *a5;
@property (strong, nonatomic) IBOutlet UIButton *a6;

@property (strong, nonatomic) IBOutlet UIButton *frontLeft;
@property (strong, nonatomic) IBOutlet UIButton *frontRight;
@property (strong, nonatomic) IBOutlet UIButton *midLeft;
@property (strong, nonatomic) IBOutlet UIButton *midRight;
@property (strong, nonatomic) IBOutlet UIButton *rearLeft;
@property (strong, nonatomic) IBOutlet UIButton *rearRight;

@property (weak, nonatomic) IBOutlet UILabel *labelFuel;
@property (weak, nonatomic) IBOutlet UILabel *labelRowOne;
@property (weak, nonatomic) IBOutlet UILabel *labelRowTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelRowThree;
@property (weak, nonatomic) IBOutlet UILabel *labelAftCargo;
@property (weak, nonatomic) IBOutlet UILabel *labelPod;
@property (weak, nonatomic) IBOutlet UILabel *labelTotal;

@property (weak, nonatomic) IBOutlet UISlider *sliderFuel;
@property (weak, nonatomic) IBOutlet UISlider *sliderRowOne;
@property (weak, nonatomic) IBOutlet UISlider *sliderRowTwo;
@property (weak, nonatomic) IBOutlet UISlider *sliderRowThree;
@property (weak, nonatomic) IBOutlet UISlider *sliderAftCargo;
@property (weak, nonatomic) IBOutlet UISlider *sliderPod;

@property (weak, nonatomic) IBOutlet UIStepper *stepperFuel;
@property (weak, nonatomic) IBOutlet UIStepper *stepperRowOne;
@property (weak, nonatomic) IBOutlet UIStepper *stepperRowTwo;
@property (weak, nonatomic) IBOutlet UIStepper *stepperRowThree;
@property (weak, nonatomic) IBOutlet UIStepper *stepperAftCargo;
@property (weak, nonatomic) IBOutlet UIStepper *stepperPod;


    -(void)radiobuttonSelected:(id)sender;

@end
