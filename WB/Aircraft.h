//
//  Aircraft.h
//  WB
//
//  Created by Andrew Smircich on 5/16/15.
//  Copyright (c) 2015 Andrew Smircich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Aircraft : NSManagedObject

@property (nonatomic, retain) NSNumber * aircraftAftcargoarm;
@property (nonatomic, retain) NSNumber * aircraftAftlimit;
@property (nonatomic, retain) NSNumber * aircraftEmptymom;
@property (nonatomic, retain) NSNumber * aircraftEmptyweight;
@property (nonatomic, retain) NSNumber * aircraftFuelarm;
@property (nonatomic, retain) NSNumber * aircraftFwdlimit;
@property (nonatomic, retain) NSNumber * aircraftFwdlimitgross;
@property (nonatomic, retain) NSNumber * aircraftFwdlimitwt;
@property (nonatomic, retain) NSNumber * aircraftMaxgross;
@property (nonatomic, retain) NSString * aircraftName;
@property (nonatomic, retain) NSNumber * aircraftPodarm;
@property (nonatomic, retain) NSNumber * aircraftRow1arm;
@property (nonatomic, retain) NSNumber * aircraftRow2arm;
@property (nonatomic, retain) NSNumber * aircraftRow3arm;

@end

