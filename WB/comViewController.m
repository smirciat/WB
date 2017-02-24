//
//  comViewController.m
//  WB
//
//  Created by Andy on 5/3/15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import "comViewController.h"
#import "GlobalVars.h"
#import "addViewController.h"

@interface comViewController ()
@property (strong) NSMutableArray *aircrafts;
@property (strong) NSMutableArray *aircraftName;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (strong) NSFetchRequest *fetchRequest;
@property (strong) NSManagedObject *aircraft;
//@property (nonatomic,retain) addViewController *addViewController;

@end

@implementation comViewController

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

GlobalVars *globals;

@synthesize rb1,radiobutton2,radiobutton3,radiobutton4,radiobutton5,radiobutton6,myAircraftname;
@synthesize a,a1,a2,a3,a4,a5,a6;
@synthesize frontLeft,frontRight,midLeft,midRight,rearLeft,rearRight;
@synthesize myRow1arm,myRow2arm,myRow3arm,myFuelarm,myPodarm,myAftcargoarm;

long selected=0;
long aircraftIndex=0;
long seatWeight=12;
long seatIndex=10;
float maxgross[]={3800,3600,3800,3600,3600,3800};
float emptywt[]={2253,2244,2281,2277,2205,2253};
float emptymom[]={79252,91876,88372,94340,86975,79252};
float fwdlimit[]={31,33,33,33,33,31};
float fwdlimitwt[]={2600,2500,2500,2500,2250,2600};
float fwdlimitgross[]={42.7,42.5,44.2,42.5,42.5,42.7};
float aftlimit[]={49.0,49.7,49.7,49.7,49.7,49.0};
float row1arm[]={36,34,34,34,34,36};
float row2arm[]={76,74,74,74,74,76};
float row3arm[]={106,100,100,100,100,106};
float fuelarm[]={48,48,48,48,48,48};
float podarm[]={-5.5,4.5,4.5,4.5,4.5,-5.5};
float aftcargoarm[]={129,127,127,127,127,129};
float fuel,r1,r2,r3,aftcargo, pod;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    globals = [GlobalVars sharedInstance];
	[self.scroller setScrollEnabled:YES];
    [self.scroller setContentSize:CGSizeMake(320,800)];
    _aircraftName = [NSMutableArray arrayWithObjects:@"N91025",@"N36GB",@"N710MH",@"N756ZV",@"N7138Q",@"N9957M",nil];
    myAircraftname=_aircraftName[0];
    globals.myMaxgross=maxgross[0];
    myAftcargoarm=aftcargoarm[0];
    globals.myAftlimit=aftlimit[0];
    globals.myEmptymom=emptymom[0];
    globals.myEmptywt=emptywt[0];
    myFuelarm=fuelarm[0];
    globals.myFwdlimit=fwdlimit[0];
    globals.myFwdlimitgross=fwdlimitgross[0];
    globals.myFwdlimitwt=fwdlimitwt[0];
    myPodarm=podarm[0];
    myRow1arm=row1arm[0];
    myRow2arm=row2arm[0];
    myRow3arm=row3arm[0];
    globals.totalWeight=0;
    globals.cg=0;
    
    self.stepperFuel.autorepeat = YES;
    self.stepperRowOne.autorepeat = YES;
    self.stepperRowTwo.autorepeat = YES;
    self.stepperRowThree.autorepeat = YES;
    self.stepperAftCargo.autorepeat = YES;
    self.stepperPod.autorepeat = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    
    _managedObjectContext = [self managedObjectContext];
    _fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Aircraft"];
    self.aircrafts = [[_managedObjectContext executeFetchRequest:_fetchRequest error:nil] mutableCopy];
    if (self.aircrafts.count==0) [self initStore];
    for (int i=0;i<6;i++){
      if (self.aircrafts.count>i){
        _aircraft = [self.aircrafts objectAtIndex:i];
        [_aircraftName replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@",[_aircraft valueForKey:@"aircraftName"]]];
        maxgross[i]=[[_aircraft valueForKey:@"aircraftMaxgross"] floatValue];
        emptywt[i]=[[_aircraft valueForKey:@"aircraftEmptyweight"] floatValue];
        emptymom[i]=[[_aircraft valueForKey:@"aircraftEmptymom"] floatValue];
        fwdlimit[i]=[[_aircraft valueForKey:@"aircraftFwdlimit"] floatValue];
        fwdlimitwt[i]=[[_aircraft valueForKey:@"aircraftFwdlimitwt"] floatValue];
        fwdlimitgross[i]=[[_aircraft valueForKey:@"aircraftFwdlimitgross"] floatValue];
        aftlimit[i]=[[_aircraft valueForKey:@"aircraftAftlimit"] floatValue];
        row1arm[i]=[[_aircraft valueForKey:@"aircraftRow1arm"] floatValue];
        row2arm[i]=[[_aircraft valueForKey:@"aircraftRow2arm"] floatValue];
        row3arm[i]=[[_aircraft valueForKey:@"aircraftRow3arm"] floatValue];
        fuelarm[i]=[[_aircraft valueForKey:@"aircraftFuelarm"] floatValue];
        podarm[i]=[[_aircraft valueForKey:@"aircraftPodarm"] floatValue];
        aftcargoarm[i]=[[_aircraft valueForKey:@"aircraftAftcargoarm"] floatValue];
        
      }
    }
       
    //seat configutation radio buttons
    
    //A
    [a setTag:10];
    if (a1.selected==NO&&a2.selected==NO&&a3.selected==NO&&a4.selected==NO&&a5.selected==NO&&a6.selected==NO) {
        //[self setTotal];
        a.selected=YES;
    }
    [a setTitle:@"A" forState:UIControlStateNormal];
    a.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [a setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    
    [a setTitleEdgeInsets: UIEdgeInsetsMake(80, 0, 0, 0)];
    [a setBackgroundImage:[UIImage imageNamed:@"seat-radio-off.png"] forState:UIControlStateNormal];
    [a setBackgroundImage:[UIImage imageNamed:@"seat-radio-on.png"] forState:UIControlStateSelected];
    [a addTarget:self action:@selector(seatButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    //A1
    [a1 setTag:11];
    [a1 setTitle:@"A-1" forState:UIControlStateNormal];
    a1.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [a1 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    
    [a1 setTitleEdgeInsets: UIEdgeInsetsMake(80, 0, 0, 0)];
    [a1 setBackgroundImage:[UIImage imageNamed:@"seat-radio-off.png"] forState:UIControlStateNormal];
    [a1 setBackgroundImage:[UIImage imageNamed:@"seat-radio-on.png"] forState:UIControlStateSelected];
    [a1 addTarget:self action:@selector(seatButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    //A2
    [a2 setTag:12];
    [a2 setTitle:@"A-2" forState:UIControlStateNormal];
    a2.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [a2 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    
    [a2 setTitleEdgeInsets: UIEdgeInsetsMake(80, 0, 0, 0)];
    [a2 setBackgroundImage:[UIImage imageNamed:@"seat-radio-off.png"] forState:UIControlStateNormal];
    [a2 setBackgroundImage:[UIImage imageNamed:@"seat-radio-on.png"] forState:UIControlStateSelected];
    [a2 addTarget:self action:@selector(seatButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    //A3
    [a3 setTag:13];
    [a3 setTitle:@"A-3" forState:UIControlStateNormal];
    a3.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [a3 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    
    [a3 setTitleEdgeInsets: UIEdgeInsetsMake(80, 0, 0, 0)];
    [a3 setBackgroundImage:[UIImage imageNamed:@"seat-radio-off.png"] forState:UIControlStateNormal];
    [a3 setBackgroundImage:[UIImage imageNamed:@"seat-radio-on.png"] forState:UIControlStateSelected];
    [a3 addTarget:self action:@selector(seatButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    //A4
    [a4 setTag:14];
    [a4 setTitle:@"A-4" forState:UIControlStateNormal];
    a4.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [a4 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    
    [a4 setTitleEdgeInsets: UIEdgeInsetsMake(80, 0, 0, 0)];
    [a4 setBackgroundImage:[UIImage imageNamed:@"seat-radio-off.png"] forState:UIControlStateNormal];
    [a4 setBackgroundImage:[UIImage imageNamed:@"seat-radio-on.png"] forState:UIControlStateSelected];
    [a4 addTarget:self action:@selector(seatButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    //A5
    [a5 setTag:15];
    [a5 setTitle:@"A-5" forState:UIControlStateNormal];
    a5.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [a5 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    
    [a5 setTitleEdgeInsets: UIEdgeInsetsMake(80, 0, 0, 0)];
    [a5 setBackgroundImage:[UIImage imageNamed:@"seat-radio-off.png"] forState:UIControlStateNormal];
    [a5 setBackgroundImage:[UIImage imageNamed:@"seat-radio-on.png"] forState:UIControlStateSelected];
    [a5 addTarget:self action:@selector(seatButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    //A6
    [a6 setTag:16];
    [a6 setTitle:@"A-6" forState:UIControlStateNormal];
    a6.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [a6 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    
    [a6 setTitleEdgeInsets: UIEdgeInsetsMake(80, 0, 0, 0)];
    [a6 setBackgroundImage:[UIImage imageNamed:@"seat-radio-off.png"] forState:UIControlStateNormal];
    [a6 setBackgroundImage:[UIImage imageNamed:@"seat-radio-on.png"] forState:UIControlStateSelected];
    [a6 addTarget:self action:@selector(seatButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    //seat indicators
    //frontLeft
    [frontLeft setTag:1];
    [frontLeft setTitle:@"" forState:UIControlStateNormal];
    [frontLeft setBackgroundImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [frontLeft setBackgroundImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateSelected];
    frontLeft.selected=YES;
    [frontLeft addTarget:self action:@selector(indicatorButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [frontRight setTag:2];
    [frontRight setTitle:@"" forState:UIControlStateNormal];
    [frontRight setBackgroundImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [frontRight setBackgroundImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateSelected];
    frontRight.selected=YES;
    [frontRight addTarget:self action:@selector(indicatorButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [midLeft setTag:3];
    [midLeft setTitle:@"" forState:UIControlStateNormal];
    [midLeft setBackgroundImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [midLeft setBackgroundImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateSelected];
    midLeft.selected=YES;
    [midLeft addTarget:self action:@selector(indicatorButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [midRight setTag:4];
    [midRight setTitle:@"" forState:UIControlStateNormal];
    [midRight setBackgroundImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [midRight setBackgroundImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateSelected];
    midRight.selected=YES;
    [midRight addTarget:self action:@selector(indicatorButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [rearLeft setTag:5];
    [rearLeft setTitle:@"" forState:UIControlStateNormal];
    [rearLeft setBackgroundImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [rearLeft setBackgroundImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateSelected];
    rearLeft.selected=YES;
    [rearLeft addTarget:self action:@selector(indicatorButtonSelected:) forControlEvents:UIControlEventTouchUpInside];

    [rearRight setTag:6];
    [rearRight setTitle:@"" forState:UIControlStateNormal];
    [rearRight setBackgroundImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [rearRight setBackgroundImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateSelected];
    rearRight.selected=YES;
    [rearRight addTarget:self action:@selector(indicatorButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    //radio buttons
    [rb1 setTag:0];
    if (radiobutton2.selected==NO&&radiobutton3.selected==NO&&radiobutton4.selected==NO&&radiobutton5.selected==NO&&radiobutton6.selected==NO) {
        [self setTotal];
        rb1.selected=YES;
    }
    [rb1 setTitle:[_aircraftName objectAtIndex:0] forState:UIControlStateNormal];
    rb1.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [rb1 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];

    [rb1 setTitleEdgeInsets: UIEdgeInsetsMake(80, 0, 0, 0)];
    [rb1 setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [rb1 setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [rb1 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    

//radiobutton2 = [[UIButton alloc] initWithFrame:CGRectMake(70, 30, 55, 55)];
[radiobutton2 setTag:1];
    [radiobutton2 setTitle:[_aircraftName objectAtIndex:1] forState:UIControlStateNormal];
    //[rb1 setTitle:@"N36GB" forState:UIControlStateNormal];
    radiobutton2.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [radiobutton2 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [radiobutton2 setTitleEdgeInsets: UIEdgeInsetsMake(80, 0, 0, 0)];
[radiobutton2 setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
[radiobutton2 setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
[radiobutton2 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    //radiobutton3 = [[UIButton alloc] initWithFrame:CGRectMake(140, 30, 55, 55)];
    [radiobutton3 setTag:2];
    [radiobutton3 setTitle:[_aircraftName objectAtIndex:2] forState:UIControlStateNormal];
    //[rb1 setTitle:@"N710MH" forState:UIControlStateNormal];
    radiobutton3.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [radiobutton3 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [radiobutton3 setTitleEdgeInsets: UIEdgeInsetsMake(80, 0, 0, 0)];
    [radiobutton3 setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [radiobutton3 setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [radiobutton3 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //radiobutton4 = [[UIButton alloc] initWithFrame:CGRectMake(210, 30, 55, 55)];
    [radiobutton4 setTag:3];
    [radiobutton4 setTitle:[_aircraftName objectAtIndex:3] forState:UIControlStateNormal];
    //[rb1 setTitle:@"N756ZV" forState:UIControlStateNormal];
    radiobutton4.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [radiobutton4 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [radiobutton4 setTitleEdgeInsets: UIEdgeInsetsMake(80, 0, 0, 0)];
    [radiobutton4 setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [radiobutton4 setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [radiobutton4 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //radiobutton5 = [[UIButton alloc] initWithFrame:CGRectMake(140, 30, 55, 55)];
    [radiobutton5 setTag:4];
    [radiobutton5 setTitle:[_aircraftName objectAtIndex:4] forState:UIControlStateNormal];
    //[rb1 setTitle:@"N710MH" forState:UIControlStateNormal];
    radiobutton5.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [radiobutton5 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [radiobutton5 setTitleEdgeInsets: UIEdgeInsetsMake(80, 0, 0, 0)];
    [radiobutton5 setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [radiobutton5 setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [radiobutton5 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //radiobutton4 = [[UIButton alloc] initWithFrame:CGRectMake(210, 30, 55, 55)];
    [radiobutton6 setTag:5];
    [radiobutton6 setTitle:[_aircraftName objectAtIndex:5] forState:UIControlStateNormal];
    //[rb1 setTitle:@"N756ZV" forState:UIControlStateNormal];
    radiobutton6.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [radiobutton6 setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [radiobutton6 setTitleEdgeInsets: UIEdgeInsetsMake(80, 0, 0, 0)];
    [radiobutton6 setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [radiobutton6 setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [radiobutton6 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (IBAction)sliderFuelChanged:(id)sender {
    [self.stepperFuel setValue:self.sliderFuel.value];
    //fuel=self.sliderFuel.value;
    NSString *sliderValue = [NSString stringWithFormat:@"%.f",self.sliderFuel.value];
    self.labelFuel.text=[NSString stringWithFormat:@"%@%@", @"Fuel (gallons): ", sliderValue];
    
    [self setTotal];
}
- (IBAction)stepperFuelChanged:(UIStepper *)sender {
    [self.sliderFuel setValue:sender.value];
    NSString *sliderValue = [NSString stringWithFormat:@"%.f",self.sliderFuel.value];
    self.labelFuel.text=[NSString stringWithFormat:@"%@%@", @"Fuel (gallons): ", sliderValue];
    
    [self setTotal];
}
- (IBAction)sliderRowOneChanged:(id)sender {
    [self.stepperRowOne setValue:self.sliderRowOne.value];
    NSString *sliderValue = [NSString stringWithFormat:@"%.f",self.sliderRowOne.value];
    self.labelRowOne.text=[NSString stringWithFormat:@"%@%@", @"Row One: ", sliderValue];
    
    [self setTotal];
}
- (IBAction)stepperRowOneChanged:(UIStepper *)sender {
    [self.sliderRowOne setValue:sender.value];
    NSString *sliderValue = [NSString stringWithFormat:@"%.f",self.sliderRowOne.value];
    self.labelRowOne.text=[NSString stringWithFormat:@"%@%@", @"Row One: ", sliderValue];
    
    [self setTotal];
}
- (IBAction)sliderRowTwoChanged:(id)sender {
    [self.stepperRowTwo setValue:self.sliderRowTwo.value];
    NSString *sliderValue = [NSString stringWithFormat:@"%.f",self.sliderRowTwo.value];
    self.labelRowTwo.text=[NSString stringWithFormat:@"%@%@", @"Row Two: ", sliderValue];
    
    [self setTotal];
}
- (IBAction)stepperRowTwoChanged:(UIStepper *)sender {
    [self.sliderRowTwo setValue:sender.value];
    NSString *sliderValue = [NSString stringWithFormat:@"%.f",self.sliderRowTwo.value];
    self.labelRowTwo.text=[NSString stringWithFormat:@"%@%@", @"Row Two: ", sliderValue];
    
    [self setTotal];
}
- (IBAction)sliderRowThreeChanged:(id)sender {
    [self.stepperRowThree setValue:self.sliderRowThree.value];
    NSString *sliderValue = [NSString stringWithFormat:@"%.f",self.sliderRowThree.value];
    self.labelRowThree.text=[NSString stringWithFormat:@"%@%@", @"Row Three: ", sliderValue];
    
    [self setTotal];
}
- (IBAction)stepperRowThreeChanged:(UIStepper *)sender {
    [self.sliderRowThree setValue:sender.value];
    NSString *sliderValue = [NSString stringWithFormat:@"%.f",self.sliderRowThree.value];
    self.labelRowThree.text=[NSString stringWithFormat:@"%@%@", @"Row Three: ", sliderValue];
    
    [self setTotal];
}
- (IBAction)sliderAftCargoChanged:(id)sender {
    [self.stepperAftCargo setValue:self.sliderAftCargo.value];
    NSString *sliderValue = [NSString stringWithFormat:@"%.f",self.sliderAftCargo.value];
    self.labelAftCargo.text=[NSString stringWithFormat:@"%@%@", @"Aft Cargo: ", sliderValue];
    
    [self setTotal];
}
- (IBAction)stepperAftCargoChanged:(UIStepper *)sender {
    [self.sliderAftCargo setValue:sender.value];
    NSString *sliderValue = [NSString stringWithFormat:@"%.f",self.sliderAftCargo.value];
    self.labelAftCargo.text=[NSString stringWithFormat:@"%@%@", @"Aft Cargo: ", sliderValue];
    
    [self setTotal];
}
- (IBAction)sliderPodChanged:(id)sender {
    [self.stepperPod setValue:self.sliderPod.value];
    NSString *sliderValue = [NSString stringWithFormat:@"%.f",self.sliderPod.value];
    self.labelPod.text=[NSString stringWithFormat:@"%@%@", @"Belly Pod/Nose: ", sliderValue];
    
    [self setTotal];

}
- (IBAction)stepperPodChanged:(UIStepper *)sender {
    [self.sliderPod setValue:sender.value];
    NSString *sliderValue = [NSString stringWithFormat:@"%.f",self.sliderPod.value];
    self.labelPod.text=[NSString stringWithFormat:@"%@%@", @"Belly Pod/Nose: ", sliderValue];
    
    [self setTotal];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueEdit"]) {
        NSManagedObject *selectedAircraft = [self.aircrafts objectAtIndex:selected];
        addViewController *avc = segue.destinationViewController;
        avc.aircraft  = selectedAircraft;
    }
}

-(void)indicatorButtonSelected:(id)sender{
    if ([sender tag] >2){
        [a setSelected:NO];
        [a1 setSelected:NO];
        [a2 setSelected:NO];
        [a3 setSelected:NO];
        [a4 setSelected:NO];
        [a5 setSelected:NO];
        [a6 setSelected:NO];
        switch ([sender tag]) {
            case 3:
                if ([midLeft isSelected]==YES){
                    [midLeft setSelected:NO];
                    
                }
                else {
                    [midLeft setSelected:YES];
                
                }
                break;
                
        }
    }
}

-(void)seatButtonSelected:(id)sender{
    seatIndex = [sender tag];
    switch ([sender tag]) {
        case 10:
            if([a isSelected]==NO)
            {
                [a setSelected:YES];
                [a1 setSelected:NO];
                [a2 setSelected:NO];
                [a3 setSelected:NO];
                [a4 setSelected:NO];
                [a5 setSelected:NO];
                [a6 setSelected:NO];
                [midLeft setSelected:YES];
                [midRight setSelected:YES];
                [rearRight setSelected:YES];
                [rearLeft setSelected:YES];
            }
            break;
        case 11:
            if([a1 isSelected]==NO)
            {
                [a1 setSelected:YES];
                [a setSelected:NO];
                [a2 setSelected:NO];
                [a3 setSelected:NO];
                [a4 setSelected:NO];
                [a5 setSelected:NO];
                [a6 setSelected:NO];
                [midLeft setSelected:YES];
                [midRight setSelected:YES];
                [rearRight setSelected:YES];
                [rearLeft setSelected:NO];
            }
            break;
        case 12:
            if([a2 isSelected]==NO)
            {
                [a2 setSelected:YES];
                [a1 setSelected:NO];
                [a setSelected:NO];
                [a3 setSelected:NO];
                [a4 setSelected:NO];
                [a5 setSelected:NO];
                [a6 setSelected:NO];
                [midLeft setSelected:YES];
                [midRight setSelected:YES];
                [rearRight setSelected:NO];
                [rearLeft setSelected:NO];
            }
            break;
        case 13:
            if([a3 isSelected]==NO)
            {
                [a3 setSelected:YES];
                [a1 setSelected:NO];
                [a2 setSelected:NO];
                [a setSelected:NO];
                [a4 setSelected:NO];
                [a5 setSelected:NO];
                [a6 setSelected:NO];
                [midLeft setSelected:YES];
                [midRight setSelected:NO];
                [rearRight setSelected:NO];
                [rearLeft setSelected:NO];
            }
            break;
        case 14:
            if([a4 isSelected]==NO)
            {
                [a4 setSelected:YES];
                [a1 setSelected:NO];
                [a2 setSelected:NO];
                [a3 setSelected:NO];
                [a setSelected:NO];
                [a5 setSelected:NO];
                [a6 setSelected:NO];
                [midLeft setSelected:NO];
                [midRight setSelected:NO];
                [rearRight setSelected:NO];
                [rearLeft setSelected:NO];
            }
            break;
        case 15:
            if([a5 isSelected]==NO)
            {
                [a5 setSelected:YES];
                [a1 setSelected:NO];
                [a2 setSelected:NO];
                [a3 setSelected:NO];
                [a4 setSelected:NO];
                [a setSelected:NO];
                [a6 setSelected:NO];
                [midLeft setSelected:YES];
                [midRight setSelected:NO];
                [rearRight setSelected:YES];
                [rearLeft setSelected:NO];
            }
            break;
        case 16:
            if([a6 isSelected]==NO)
            {
                [a6 setSelected:YES];
                [a1 setSelected:NO];
                [a2 setSelected:NO];
                [a3 setSelected:NO];
                [a4 setSelected:NO];
                [a5 setSelected:NO];
                [a setSelected:NO];
                [midLeft setSelected:YES];
                [midRight setSelected:NO];
                [rearRight setSelected:YES];
                [rearLeft setSelected:YES];
            }
            break;
        default:
            break;
    }
    
    [self setSeatConfig:seatIndex];
    [self setTotal];

}

-(void)radiobuttonSelected:(id)sender{
    long z=[sender tag];
    aircraftIndex=z;
    myAftcargoarm=aftcargoarm[z];
    globals.myAftlimit=aftlimit[z];
    globals.myEmptymom=emptymom[z];
    globals.myEmptywt=emptywt[z];
    myFuelarm=fuelarm[z];
    globals.myFwdlimit=fwdlimit[z];
    globals.myFwdlimitgross=fwdlimitgross[z];
    globals.myFwdlimitwt=fwdlimitwt[z];
    globals.myMaxgross=maxgross[z];
    myPodarm=podarm[z];
    myRow1arm=row1arm[z];
    myRow2arm=row2arm[z];
    myRow3arm=row3arm[z];
    myAircraftname=[_aircraftName objectAtIndex:z];
    //NSString *output = [NSString stringWithFormat:@"%f",myAftlimit];
    //_label1.text=output;
    selected = [sender tag];
    switch ([sender tag]) {
        case 0:
            if([rb1 isSelected]==NO)
            {
                [rb1 setSelected:YES];
                [radiobutton2 setSelected:NO];
                [radiobutton3 setSelected:NO];
                [radiobutton4 setSelected:NO];
                [radiobutton5 setSelected:NO];
                [radiobutton6 setSelected:NO];
            }
            break;
        case 1:
            if([radiobutton2 isSelected]==NO)
            {
                [rb1 setSelected:NO];
                [radiobutton2 setSelected:YES];
                [radiobutton3 setSelected:NO];
                [radiobutton4 setSelected:NO];
                [radiobutton5 setSelected:NO];
                [radiobutton6 setSelected:NO];
            }
            break;
        case 2:
            if([radiobutton3 isSelected]==NO)
            {
                [rb1 setSelected:NO];
                [radiobutton2 setSelected:NO];
                [radiobutton3 setSelected:YES];
                [radiobutton4 setSelected:NO];
                [radiobutton5 setSelected:NO];
                [radiobutton6 setSelected:NO];
            }
            break;
        case 3:
            if([radiobutton4 isSelected]==NO)
            {
                [rb1  setSelected:NO];
                [radiobutton2 setSelected:NO];
                [radiobutton3 setSelected:NO];
                [radiobutton4 setSelected:YES];
                [radiobutton5 setSelected:NO];
                [radiobutton6 setSelected:NO];
            }
            break;
        case 4:
            if([radiobutton5 isSelected]==NO)
            {
                [rb1 setSelected:NO];
                [radiobutton2 setSelected:NO];
                [radiobutton3 setSelected:NO];
                [radiobutton4 setSelected:NO];
                [radiobutton5 setSelected:YES];
                [radiobutton6 setSelected:NO];
            }
            break;
        case 5:
            if([radiobutton6 isSelected]==NO)
            {
                [rb1  setSelected:NO];
                [radiobutton2 setSelected:NO];
                [radiobutton3 setSelected:NO];
                [radiobutton4 setSelected:NO];
                [radiobutton5 setSelected:NO];
                [radiobutton6 setSelected:YES];
            }
            break;
        default:
            break;
    }
    [self setSeatConfig:seatIndex];
    [self setTotal];
    
}

-(void) setSeatConfig:(long)selected{
    switch (selected) {
        case 10:
            globals.myEmptymom=emptymom[aircraftIndex];
            globals.myEmptywt=emptywt[aircraftIndex];
            break;
        case 11:
            if (aircraftIndex==0||aircraftIndex==5){
                //stow all seats
                globals.myEmptymom=emptymom[aircraftIndex]-seatWeight*row3arm[aircraftIndex]+seatWeight*aftcargoarm[aircraftIndex];
                globals.myEmptywt=emptywt[aircraftIndex];
            }
            else {
                //remove seat 6, stow rest
                globals.myEmptymom=emptymom[aircraftIndex]-seatWeight*row3arm[aircraftIndex];
                globals.myEmptywt=emptywt[aircraftIndex]-seatWeight;
            }
            break;
        case 12:
            if (aircraftIndex==0||aircraftIndex==5){
                //stow all seats
                globals.myEmptymom=emptymom[aircraftIndex]-2*seatWeight*row3arm[aircraftIndex]+2*seatWeight*aftcargoarm[aircraftIndex];
                globals.myEmptywt=emptywt[aircraftIndex];
            }
            else {
                //remove seat 6, stow rest
                globals.myEmptymom=emptymom[aircraftIndex]-2*seatWeight*row3arm[aircraftIndex]+seatWeight*aftcargoarm[aircraftIndex];
                globals.myEmptywt=emptywt[aircraftIndex]-seatWeight;
            }
            break;
        case 13:
            if (aircraftIndex==0||aircraftIndex==5){
                //stow all seats
                globals.myEmptymom=emptymom[aircraftIndex]-2*seatWeight*row3arm[aircraftIndex]+3*seatWeight*aftcargoarm[aircraftIndex]-seatWeight*row2arm[aircraftIndex];
                globals.myEmptywt=emptywt[aircraftIndex];
            }
            else {
                //remove seat 6, stow rest
                globals.myEmptymom=emptymom[aircraftIndex]-2*seatWeight*row3arm[aircraftIndex]+2*seatWeight*aftcargoarm[aircraftIndex]-seatWeight*row2arm[aircraftIndex];
                globals.myEmptywt=emptywt[aircraftIndex]-seatWeight;
            }
            break;
        case 14:
            if (aircraftIndex==0||aircraftIndex==5){
                //stow all seats
                globals.myEmptymom=emptymom[aircraftIndex]-2*seatWeight*row3arm[aircraftIndex]+4*seatWeight*aftcargoarm[aircraftIndex]-2*seatWeight*row2arm[aircraftIndex];
                globals.myEmptywt=emptywt[aircraftIndex];
            }
            else {
                //remove seat 6, stow rest
                globals.myEmptymom=emptymom[aircraftIndex]-2*seatWeight*row3arm[aircraftIndex]+3*seatWeight*aftcargoarm[aircraftIndex]-2*seatWeight*row2arm[aircraftIndex];
                globals.myEmptywt=emptywt[aircraftIndex]-seatWeight;
            }
            break;
        case 15:
            if (aircraftIndex==0||aircraftIndex==5){
                //stow all seats
                globals.myEmptymom=emptymom[aircraftIndex]-1*seatWeight*row3arm[aircraftIndex]+2*seatWeight*aftcargoarm[aircraftIndex]-1*seatWeight*row2arm[aircraftIndex];
                globals.myEmptywt=emptywt[aircraftIndex];
            }
            else {
                //remove seat 6, stow rest
                globals.myEmptymom=emptymom[aircraftIndex]-1*seatWeight*row3arm[aircraftIndex]+1*seatWeight*aftcargoarm[aircraftIndex]-1*seatWeight*row2arm[aircraftIndex];
                globals.myEmptywt=emptywt[aircraftIndex]-seatWeight;
            }
            break;
        case 16:
            if (aircraftIndex==0||aircraftIndex==5){
                //stow all seats
                globals.myEmptymom=emptymom[aircraftIndex]+1*seatWeight*aftcargoarm[aircraftIndex]-1*seatWeight*row2arm[aircraftIndex];
                globals.myEmptywt=emptywt[aircraftIndex];
            }
            else {
                //remove seat 6, stow rest
                globals.myEmptymom=emptymom[aircraftIndex]+1*seatWeight*aftcargoarm[aircraftIndex]-1*seatWeight*row2arm[aircraftIndex];
                globals.myEmptywt=emptywt[aircraftIndex]-seatWeight;
            }
            break;
            
        default:
            break;
    }
}

-(void) setTotal {
    globals.totalWeight=globals.myEmptywt+self.sliderFuel.value*6+self.sliderRowOne.value+self.sliderRowTwo.value+self.sliderRowThree.value+self.sliderAftCargo.value+self.sliderPod.value;
    NSString *textTotalWeight = [NSString stringWithFormat:@"%.f",globals.totalWeight];
    globals.cg=(globals.myEmptymom+self.sliderFuel.value*6*myFuelarm+self.sliderRowOne.value*myRow1arm+self.sliderRowTwo.value*myRow2arm+self.sliderRowThree.value*myRow3arm+self.sliderAftCargo.value*myAftcargoarm+self.sliderPod.value*myPodarm)/globals.totalWeight;
    NSString *textCG = [NSString stringWithFormat:@"%.01f",globals.cg];
    float currCG=globals.myFwdlimit;
    if (globals.totalWeight>globals.myFwdlimitwt&&globals.totalWeight<=globals.myMaxgross){
        currCG=globals.myFwdlimitgross-(globals.myFwdlimitgross-globals.myFwdlimit)*(globals.myMaxgross-globals.totalWeight)/(globals.myMaxgross-globals.myFwdlimitwt);
    }
    NSString *cgMessage = @"  Out of CG Range!!!";
    if (globals.cg<=globals.myAftlimit&&globals.cg>=currCG){
        cgMessage = @"  Within CG Range.";
    }
    NSString *twMessage = @". Over Weight!!!";
    if (globals.totalWeight<=globals.myMaxgross){
        twMessage = @". Within max gross.";
    }
    self.labelTotal.text=[NSString stringWithFormat:@"%@%@%@%@%@%@",@"Total Weight: ",textTotalWeight,@". CG: ",textCG,twMessage,cgMessage];
    [self.chartView setNeedsDisplay];
}

    
-(void) initStore{
  NSManagedObjectContext *context = [self managedObjectContext];
  NSManagedObject *newAircraft;
  for (int i=0;i<6;i++){
     newAircraft= [NSEntityDescription insertNewObjectForEntityForName:@"Aircraft" inManagedObjectContext:context];
    
    [newAircraft setValue:[_aircraftName objectAtIndex:i] forKey:@"aircraftName"];
    [newAircraft setValue:[NSNumber numberWithFloat: maxgross[i]] forKey:@"aircraftMaxgross"];
    [newAircraft setValue:[NSNumber numberWithFloat: emptymom[i]] forKey:@"aircraftEmptymom"];
    [newAircraft setValue:[NSNumber numberWithFloat: fwdlimit[i]] forKey:@"aircraftFwdlimit"];
    [newAircraft setValue:[NSNumber numberWithFloat: fwdlimitgross[i]] forKey:@"aircraftFwdlimitgross"];
    [newAircraft setValue:[NSNumber numberWithFloat: fwdlimitwt[i]] forKey:@"aircraftFwdlimitwt"];
    [newAircraft setValue:[NSNumber numberWithFloat: row2arm[i]] forKey:@"aircraftRow2arm"];
    [newAircraft setValue:[NSNumber numberWithFloat: row3arm[i]] forKey:@"aircraftRow3arm"];
    [newAircraft setValue:[NSNumber numberWithFloat: fuelarm[i]] forKey:@"aircraftFuelarm"];
    [newAircraft setValue:[NSNumber numberWithFloat: aftcargoarm[i]] forKey:@"aircraftAftcargoarm"];
    [newAircraft setValue:[NSNumber numberWithFloat: emptywt[i]] forKey:@"aircraftEmptyweight"];
    [newAircraft setValue:[NSNumber numberWithFloat: aftlimit[i]] forKey:@"aircraftAftlimit"];
    [newAircraft setValue:[NSNumber numberWithFloat: row1arm[i]] forKey:@"aircraftRow1arm"];
    [newAircraft setValue:[NSNumber numberWithFloat: podarm[i]] forKey:@"aircraftPodarm"];

    NSError *error = nil;
// Save the object to persistent store
    if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
  }
}


@end
