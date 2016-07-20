#import <Foundation/Foundation.h>

@interface GlobalVars : NSObject
{
    float myMaxgross,myAftlimit,totalWeight,cg;
    float myEmptywt,myEmptymom,myFwdlimit,myFwdlimitwt,myFwdlimitgross;
}

+ (GlobalVars *)sharedInstance;

@property(nonatomic,readwrite) float myMaxgross,myAftlimit,totalWeight,cg;
@property(nonatomic,readwrite) float myEmptywt,myEmptymom,myFwdlimit,myFwdlimitwt,myFwdlimitgross;

@end
