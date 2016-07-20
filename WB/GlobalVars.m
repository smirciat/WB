#import "GlobalVars.h"

@implementation GlobalVars

@synthesize myMaxgross,myAftlimit,totalWeight,cg;
@synthesize myEmptywt,myEmptymom,myFwdlimit,myFwdlimitwt,myFwdlimitgross;

+ (GlobalVars *)sharedInstance {
    static dispatch_once_t onceToken;
    static GlobalVars *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[GlobalVars alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        myMaxgross=0;
        myAftlimit=0;
        totalWeight=0;
        cg=0;
        myEmptywt=0;
        myEmptymom=0;
        myFwdlimit=0;
        myFwdlimitwt=0;
        myFwdlimitgross=0;
    }
    return self;
}
@end
