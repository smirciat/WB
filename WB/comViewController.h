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



    -(void)radiobuttonSelected:(id)sender;

@end
