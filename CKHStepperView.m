//
//  CKHStepterView.m
//  TableDemo
//
//  Created by Kenway on 2017/4/18.
//  Copyright © 2017年 Kenway. All rights reserved.
//

#import "CKHStepperView.h"

@interface CKHStepperView (){
    int _num;
}

@end

@implementation CKHStepperView

- (instancetype)initWithFrame:(CGRect)frame
{
    CGRect rect = CGRectMake(frame.origin.x, frame.origin.y, 90, 23.5);
    self = [super initWithFrame:rect];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5.0;
        self.clipsToBounds = YES;
        _num = 0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self viewStyle:rect];
    [self addSubview:self.textLabel];
    [self addSubview:self.btnLess];
    [self addSubview:self.btnPlus];
}

- (void)lessButtonAction:(UIButton *)sender{
    
}

- (void)plusButtonAction:(UIButton *)sender{
    
}

- (void)viewStyle:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rect.size.width, rect.size.height) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, rect.size.height/2)];
    CGContextAddPath(context, borderPath.CGPath);
    CGContextSetStrokeColorWithColor(context, (_lineColor == nil?[self hexToColor:@"999999"].CGColor : _lineColor.CGColor));
    CGContextSetLineWidth(context, 1);
    CGContextStrokePath(context);
    CGContextSaveGState(context);
    CGFloat firstLineXPoint = rect.size.width/3;
    CGFloat secondLineXPoint = firstLineXPoint * 2;
    UIBezierPath *firstLine = [UIBezierPath bezierPath];
    [firstLine moveToPoint:CGPointMake(firstLineXPoint, 0)];
    [firstLine addLineToPoint:CGPointMake(firstLineXPoint, rect.size.height)];
    CGContextSetLineWidth(context, 0.5);
    CGContextAddPath(context, firstLine.CGPath);
    CGContextStrokePath(context);
    CGContextSaveGState(context);
    UIBezierPath *secondLine = [UIBezierPath bezierPath];
    [secondLine moveToPoint:CGPointMake(secondLineXPoint, 0)];
    [secondLine addLineToPoint:CGPointMake(secondLineXPoint, rect.size.height)];
    CGContextAddPath(context, secondLine.CGPath);
    CGContextStrokePath(context);
    CGContextSaveGState(context);
}


-(UIColor *)hexToColor:(NSString *)hexString{
    NSString *hexNum = hexString;
    if ([hexString hasPrefix:@"#"]) {
        hexNum = [hexString substringFromIndex:1];
    }
    unsigned int red, green, blue;
    NSRange range;
    range.length =2;
    range.location =0;
    [[NSScanner scannerWithString:[hexNum substringWithRange:range]]scanHexInt:&red];
    range.location =2;
    [[NSScanner scannerWithString:[hexNum substringWithRange:range]]scanHexInt:&green];
    range.location =4;
    [[NSScanner scannerWithString:[hexNum substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:1.0f];
}


- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/3 + 1, 1, self.frame.size.width/3 - 2, self.frame.size.height - 2)];
        _textLabel.textColor = [self hexToColor:@"333333"];
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}
- (UIButton *)btnLess{
    if (!_btnLess) {
        _btnLess = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLess.frame = CGRectMake(1, 2.5, self.frame.size.width/3 - 2, self.frame.size.height - 5);
        [_btnLess setImage:[UIImage imageNamed:@"less"] forState:UIControlStateNormal];
        [_btnLess addTarget:self action:@selector(lessButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLess;
}

- (UIButton *)btnPlus{
    if (!_btnPlus) {
        _btnPlus = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPlus.frame = CGRectMake(self.frame.size.width/3*2 + 1, 2.5, self.frame.size.width/3 - 2, self.frame.size.height - 5);
        [_btnPlus setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        [_btnPlus addTarget:self action:@selector(plusButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPlus;
}




@end
