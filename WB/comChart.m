//
//  comChart.m
//  WB
//
//  Created by Andy on 5/10/15.
//  Copyright (c) 2015 Andy. All rights reserved.
//

#import "comChart.h"
#import "GlobalVars.h"

@implementation comChart

//@synthesize myMaxgross;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
    
}


- (void)drawRect:(CGRect)rect
{
    GlobalVars *globals = [GlobalVars sharedInstance];
    NSString *textCG = [NSString stringWithFormat:@"%.01f",globals.cg];
    NSString *textTotalWeight = [NSString stringWithFormat:@"%.f",globals.totalWeight];
    
    self.labelChart.text=[NSString stringWithFormat:@"%@%@%@%@",@"Total Weight: ",textTotalWeight,@",   CG: ",textCG];
    float topY=80;
    float leftX=45;
    float chartHeight=480;
    float chartWidth=260;
    float maxX=MAX(globals.myAftlimit, globals.cg);
    float minX=MIN(globals.myFwdlimit, globals.cg);
    float maxY=MAX(globals.totalWeight, globals.myMaxgross);
    float minY=globals.myEmptywt;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {0.0, 0.0, 0.0, 1.0};
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextMoveToPoint(context, leftX, topY);
    CGContextAddLineToPoint(context, leftX, topY+chartHeight);
    CGContextAddLineToPoint(context, leftX+chartWidth, topY+chartHeight);
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
    
    CGFloat components1[] = {1.0, 0.0, 0.0, 1.0};
    color = CGColorCreate(colorspace, components1);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextMoveToPoint(context, leftX, topY+chartHeight*(maxY-globals.myFwdlimitwt)/(maxY-minY));
    CGContextAddLineToPoint(context, leftX+chartWidth*(globals.myFwdlimitgross-globals.myFwdlimit)/(maxX-minX), topY+chartHeight*(maxY-globals.myMaxgross)/(maxY-minY));
    CGContextAddLineToPoint(context, leftX+chartWidth*(globals.myAftlimit-globals.myFwdlimit)/(maxX-minX), topY+chartHeight*(maxY-globals.myMaxgross)/(maxY-minY));
    CGContextAddLineToPoint(context, leftX+chartWidth*(globals.myAftlimit-globals.myFwdlimit)/(maxX-minX), topY+chartHeight*(maxY-globals.myEmptywt)/(maxY-minY));
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
    
    CGFloat components2[] = {0.0, 1.0, 0.0, 1.0};
    color = CGColorCreate(colorspace, components2);
    CGContextSetStrokeColorWithColor(context, color);
    CGRect rectangle = CGRectMake(leftX+chartWidth*(globals.cg-globals.myFwdlimit)/(maxX-minX), topY+chartHeight*(maxY-globals.totalWeight)/(maxY-minY),4,4);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
    //CGColorSpaceRelease(colorspace);
    //CGColorRelease(color);
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 240, 50, 30)];
    lbl.text=@"Weight";
    lbl.textColor=[UIColor blackColor];
    lbl.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(12.0)];
    lbl.transform = CGAffineTransformMakeRotation((M_PI)*3/2);
    [self addSubview:lbl];
    
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(leftX+chartWidth/3, topY + chartHeight , 200, 30)];
    lbl2.text=@"Center of Gravity";
    lbl2.textColor=[UIColor blackColor];
    lbl2.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(12.0)];
    [self addSubview:lbl2];
    
    UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(chartWidth + leftX/2, topY + chartHeight , 50, 30)];
    lbl3.text=@"Aft";
    lbl3.textColor=[UIColor blackColor];
    lbl3.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(12.0)];
    [self addSubview:lbl3];
    
    UILabel *lbl4 = [[UILabel alloc] initWithFrame:CGRectMake(leftX, topY + chartHeight , 50, 30)];
    lbl4.text=@"Fwd";
    lbl4.textColor=[UIColor blackColor];
    lbl4.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(12.0)];
    [self addSubview:lbl4];
}


@end
