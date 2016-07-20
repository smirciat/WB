//
//  addViewController.m
//  WB
//
//  Created by Andrew Smircich on 5/16/15.
//  Copyright (c) 2015 Andrew Smircich. All rights reserved.
//

#import "addViewController.h"

@interface addViewController ()



@end

@implementation addViewController
@synthesize aircraft;

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.aircraft){
        [self.textName setText:[self.aircraft valueForKey:@"aircraftName"]];
        [self.textMaxgross setText:[[self.aircraft valueForKey:@"aircraftMaxgross"] stringValue]];
        [self.textEmptymoment setText:[[self.aircraft valueForKey:@"aircraftEmptymom"] stringValue]];
        [self.textFwdlimit setText:[[self.aircraft valueForKey:@"aircraftFwdlimit"] stringValue] ];
        [self.textFwdlimitgross setText:[[self.aircraft valueForKey:@"aircraftFwdlimitgross"] stringValue]];
        [self.textFwdlimitwt setText:[[self.aircraft valueForKey:@"aircraftFwdlimitwt"] stringValue] ];
        [self.textRow2arm setText:[[self.aircraft valueForKey:@"aircraftRow2arm"] stringValue] ];
        [self.textRow3arm setText:[[self.aircraft valueForKey:@"aircraftRow3arm"] stringValue] ];
        [self.textFuelarm setText:[[self.aircraft valueForKey:@"aircraftFuelarm"] stringValue] ];
        [self.textAftcargoarm setText:[[self.aircraft valueForKey:@"aircraftAftcargoarm"] stringValue]];
        [self.textEmptywt setText:[[self.aircraft valueForKey:@"aircraftEmptyweight"] stringValue] ];
        [self.textAftlimit setText:[[self.aircraft valueForKey:@"aircraftAftlimit"] stringValue] ];
        [self.textRow1arm setText:[[self.aircraft valueForKey:@"aircraftRow1arm"] stringValue] ];
        [self.textPodarm setText:[[self.aircraft valueForKey:@"aircraftPodarm"] stringValue] ];
    }
    //self.textMaxgross.keyboardType=UIKeyboardTypeNumberPad;
    //self.textEmptywt.keyboardType=UIKeyboardTypeNumberPad;
    //self.textFwdlimit.keyboardType=UIKeyboardTypeDecimalPad;
    //self.textEmptymoment.keyboardType=UIKeyboardTypeNumberPad;
    //self.textFwdlimitgross.keyboardType=UIKeyboardTypeDecimalPad;
    //self.textFwdlimitwt.keyboardType=UIKeyboardTypeNumberPad;
    //self.textRow1arm.keyboardType=UIKeyboardTypeDecimalPad;
    //self.textRow2arm.keyboardType=UIKeyboardTypeDecimalPad;
    //self.textRow3arm.keyboardType=UIKeyboardTypeDecimalPad;
    //self.textFuelarm.keyboardType=UIKeyboardTypeDecimalPad;
    //self.textPodarm.keyboardType=UIKeyboardTypeDecimalPad;
    //self.textAftcargoarm.keyboardType=UIKeyboardTypeDecimalPad;
    //self.textAftlimit.keyboardType=UIKeyboardTypeDecimalPad;
  //
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
- (IBAction)cancel:(UIBarButtonItem *)sender {
    
}
- (IBAction)cancelButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveButton:(UIButton *)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    if (self.aircraft){
        [self.aircraft setValue:self.textName.text forKey:@"aircraftName"];
        [self.aircraft setValue:[f numberFromString:self.textMaxgross.text] forKey:@"aircraftMaxgross"];
        [self.aircraft setValue:[f numberFromString:self.textEmptymoment.text] forKey:@"aircraftEmptymom"];
        [self.aircraft setValue:[f numberFromString:self.textFwdlimit.text] forKey:@"aircraftFwdlimit"];
        [self.aircraft setValue:[f numberFromString:self.textFwdlimitgross.text] forKey:@"aircraftFwdlimitgross"];
        [self.aircraft setValue:[f numberFromString:self.textFwdlimitwt.text] forKey:@"aircraftFwdlimitwt"];
        [self.aircraft setValue:[f numberFromString:self.textRow2arm.text] forKey:@"aircraftRow2arm"];
        [self.aircraft setValue:[f numberFromString:self.textRow3arm.text] forKey:@"aircraftRow3arm"];
        [self.aircraft setValue:[f numberFromString:self.textFuelarm.text] forKey:@"aircraftFuelarm"];
        [self.aircraft setValue:[f numberFromString:self.textAftcargoarm.text] forKey:@"aircraftAftcargoarm"];
        [self.aircraft setValue:[f numberFromString:self.textEmptywt.text] forKey:@"aircraftEmptyweight"];
        [self.aircraft setValue:[f numberFromString:self.textAftlimit.text] forKey:@"aircraftAftlimit"];
        [self.aircraft setValue:[f numberFromString:self.textRow1arm.text] forKey:@"aircraftRow1arm"];
        [self.aircraft setValue:[f numberFromString:self.textPodarm.text] forKey:@"aircraftPodarm"];
    }
    else{
    // Create a new managed object
    NSManagedObject *newAircraft = [NSEntityDescription insertNewObjectForEntityForName:@"Aircraft" inManagedObjectContext:context];
    
    [newAircraft setValue:self.textName.text forKey:@"aircraftName"];
    [newAircraft setValue:[f numberFromString:self.textMaxgross.text] forKey:@"aircraftMaxgross"];
    [newAircraft setValue:[f numberFromString:self.textEmptymoment.text] forKey:@"aircraftEmptymom"];
    [newAircraft setValue:[f numberFromString:self.textFwdlimit.text] forKey:@"aircraftFwdlimit"];
    [newAircraft setValue:[f numberFromString:self.textFwdlimitgross.text] forKey:@"aircraftFwdlimitgross"];
    [newAircraft setValue:[f numberFromString:self.textFwdlimitwt.text] forKey:@"aircraftFwdlimitwt"];
    [newAircraft setValue:[f numberFromString:self.textRow2arm.text] forKey:@"aircraftRow2arm"];
    [newAircraft setValue:[f numberFromString:self.textRow3arm.text] forKey:@"aircraftRow3arm"];
    [newAircraft setValue:[f numberFromString:self.textFuelarm.text] forKey:@"aircraftFuelarm"];
    [newAircraft setValue:[f numberFromString:self.textAftcargoarm.text] forKey:@"aircraftAftcargoarm"];
    [newAircraft setValue:[f numberFromString:self.textEmptywt.text] forKey:@"aircraftEmptyweight"];
    [newAircraft setValue:[f numberFromString:self.textAftlimit.text] forKey:@"aircraftAftlimit"];
    [newAircraft setValue:[f numberFromString:self.textRow1arm.text] forKey:@"aircraftRow1arm"];
    [newAircraft setValue:[f numberFromString:self.textPodarm.text] forKey:@"aircraftPodarm"];
    }
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(UIBarButtonItem *)sender {
    

}

@end
