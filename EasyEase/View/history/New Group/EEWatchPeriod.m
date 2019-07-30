//
//  EEWatchPeriod.m
//  EasyEase
//
//  Created by lizhenghao on 2019/7/30.
//  Copyright © 2019 lizhenghao. All rights reserved.
//

#import "EEWatchPeriod.h"

static inline UILabel* mpCreateLabel(CGRect rect,NSString *font,NSInteger color,NSInteger size,NSString *text)
{
    UILabel *lb = [[UILabel alloc]initWithFrame:rect];
    lb.text = text;
    lb.textColor = UIColorFromRGB(color);
    lb.font = [UIFont systemFontOfSize:size];
    
    return lb;
}

@implementation EEWatchPeriod{
    UIView *_lineView;
    NSDictionary *_data;
    NSDictionary *_lastData;
    NSArray *_tipPoints;
    NSInteger _maxIdxp;
    CGRect _chartRect;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupData];
    [self setupView];
}

-(void)setupData
{
    _data = @{
              @0:@.35,
              @1:@.65,
              @2:@.25,
              @3:@.45,
              @4:@.25,
              @5:@.85,
              @6:@.55,
              @7:@.25,
              };
    _lastData = @{
              @0:@.65,
              @1:@.35,
              @2:@.25,
              @3:@.55,
              @4:@.85,
              @5:@.45,
              @6:@.25,
              @7:@.35,
              };
    _tipPoints = @[@1,@3,@5];
    _maxIdxp = 5;
}

-(void)setupView
{
    NSInteger interval = 15;
    [UIView mp_cutRect:UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(15, 15, 15, 15))
               colPAry:nil
               rowPAry:@[@(45/2),@(interval),@(self.frame.size.height - interval - 45/2)]
        renderCallback:^(CGRect rect, NSUInteger idxCol, NSUInteger idxRow) {
            if (idxRow == 0) {
                CGRect lbrt = rect;
                lbrt.size.width = 347/2;
                UILabel *lb = mpCreateLabel(lbrt, @"PingFang-SC-Heavy", 0x222222, 16, @"最喜欢的观影时段");
                [self addSubview:lb];
                lb = mpCreateLabel(CGRectMake(CGRectGetMaxX(lbrt)+75/2, rect.origin.y, (48+30+6)/2.0, rect.size.height), @"PingFang-SC-Medium", 0x999999, 12, @"上月");
                //                [UIImage imageNamed:@""];
                [self addSubview:lb];
                lb = mpCreateLabel(CGRectMake(CGRectGetMaxX(lb.frame)+20, rect.origin.y, (48+30+6)/2.0, rect.size.height), @"PingFang-SC-Medium", 0x999999, 12, @"本月");
                [self addSubview:lb];
            }else if (idxRow == 2){
                UIView *chart = [[UIView alloc]initWithFrame:rect];
                [self drawChartBgAt:chart];
                [self addSubview:chart];
            }
        }];
}

-(void)drawChartBgAt:(UIView*)bgView
{
    _lineView = bgView;
    _lineView.layer.masksToBounds = YES;
    CGRect chartRect = UIEdgeInsetsInsetRect(bgView.bounds, UIEdgeInsetsMake(0, 0, 14+9, 0));
    _chartRect = chartRect;
    [self drawChartBackgroundWithRect:chartRect];
    [self drawLastMonthFillAreaWithRect:chartRect];
    [self drawChartFillAreaWithRect:chartRect];
    [self drawChartLineWithRect:chartRect];
    [self drawChartTipPointWithRect:chartRect];
    
}

-(void)drawChartBackgroundWithRect:(CGRect)chartRect
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = chartRect;
    //    [shapeLayer setFillColor:[UIColor blueColor].CGColor];
    [shapeLayer setStrokeColor:UIColorFromRGB(0xf0f2f7).CGColor];
    [shapeLayer setLineWidth:.5];
    //    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:1], nil]];
    CGSize sz = chartRect.size;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(sz.width, 0)];;
    CGFloat hy = sz.height/4;
    [path moveToPoint:CGPointMake(0, hy)];
    [path addLineToPoint:CGPointMake(sz.width, hy)];;
    hy = sz.height*2/4;
    [path moveToPoint:CGPointMake(0, hy)];
    [path addLineToPoint:CGPointMake(sz.width, hy)];;
    hy = sz.height*3/4;
    [path moveToPoint:CGPointMake(0, hy)];
    [path addLineToPoint:CGPointMake(sz.width, hy)];;
    hy = sz.height;
    [path moveToPoint:CGPointMake(0, hy)];
    [path addLineToPoint:CGPointMake(sz.width, hy)];;
    shapeLayer.path = path.CGPath;
    [_lineView.layer addSublayer:shapeLayer];
}

-(void)drawLastMonthFillAreaWithRect:(CGRect)rect
{
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.frame = rect;
    fillLayer.strokeColor = [UIColor clearColor].CGColor;
    fillLayer.lineWidth = 2;
    fillLayer.fillColor = UIColorFromRGBA(0xc3c3c3, .3).CGColor;
    UIBezierPath *bgPath =  [UIBezierPath bezierPath];
    NSMutableArray *points = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        float y = [[_lastData objectForKey:@(i)] floatValue];
        CGPoint p = [self getPointWithX:i y:y size:rect.size];
        [points addObject:[NSValue valueWithCGPoint:p]];
    }
    [self drawCurveLineWithPoints:points bzPath:bgPath isLine:NO];
    [bgPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    [bgPath addLineToPoint:CGPointMake(0, rect.size.height)];
    [bgPath closePath];
    [bgPath fill];
    fillLayer.path = bgPath.CGPath;
    [_lineView.layer addSublayer:fillLayer];
}

-(void)drawChartFillAreaWithRect:(CGRect)rect
{
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.frame = rect;
    fillLayer.strokeColor = [UIColor clearColor].CGColor;
    fillLayer.lineWidth = 2;
    fillLayer.fillColor = UIColorFromRGB(0x000000).CGColor;
    UIBezierPath *bgPath =  [UIBezierPath bezierPath];
    NSMutableArray *points = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        float y = [[_data objectForKey:@(i)] floatValue];
        CGPoint p = [self getPointWithX:i y:y size:rect.size];
        [points addObject:[NSValue valueWithCGPoint:p]];
    }
    [self drawCurveLineWithPoints:points bzPath:bgPath isLine:NO];
    [bgPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    [bgPath addLineToPoint:CGPointMake(0, rect.size.height)];
    [bgPath closePath];
    [bgPath fill];
    fillLayer.path = bgPath.CGPath;
    
    CAGradientLayer *gLayer = [CAGradientLayer layer];
    gLayer.colors = @[(__bridge id)UIColorFromRGBA(0x00FFF5,1).CGColor,
                      (__bridge id)UIColorFromRGBA(0x00FFF5,.1).CGColor,];
    gLayer.locations = @[@0,@1.0];
    gLayer.startPoint = CGPointMake(0, 0);
    gLayer.endPoint = CGPointMake(0, 1);
    gLayer.frame = rect;
    gLayer.mask = fillLayer;
    [_lineView.layer addSublayer:gLayer];
}

-(void)drawChartLineWithRect:(CGRect)rect
{
    CAShapeLayer *line = [CAShapeLayer layer];
    line.frame = rect;
    line.strokeColor = UIColorFromRGB(0x000000).CGColor;
    line.lineWidth = 2;
    line.lineCap = kCALineCapRound;
    line.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    NSMutableArray *points = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        float y = [[_data objectForKey:@(i)] floatValue];
        CGPoint p = [self getPointWithX:i y:y size:rect.size];
        [points addObject:[NSValue valueWithCGPoint:p]];
    }
    [self drawCurveLineWithPoints:points bzPath:linePath isLine:YES];
    line.path = linePath.CGPath;

    CALayer *ly = [self getGradientHorizonLayer];
    ly.mask = line;
    [_lineView.layer addSublayer:ly];
}

-(void)drawChartTipPointWithRect:(CGRect)rect
{
    for (NSNumber *val in _tipPoints) {
        int x = [val intValue];
        NSNumber *nfy = [_data objectForKey:@(x)];
        if (nfy) {
            CGFloat fy = [nfy floatValue];
            CGPoint p = [self getPointWithX:x y:fy size:rect.size];
            
            CAShapeLayer *tpLy = [CAShapeLayer layer];
            tpLy.frame = rect;
            tpLy.lineWidth = 2;
            tpLy.strokeColor = UIColorFromRGB(0x16E05A).CGColor;
            tpLy.fillColor = [UIColor clearColor].CGColor;

            CGFloat pR = 3;
            UIBezierPath *bp = [UIBezierPath bezierPath];
            [bp addArcWithCenter:p radius:pR startAngle:0 endAngle:M_PI*2 clockwise:YES];
            tpLy.path = bp.CGPath;
            
            CALayer *ly = [self getGradientHorizonLayer];
            ly.mask = tpLy;
            [_lineView.layer addSublayer:ly];

            CAShapeLayer *bgly = [CAShapeLayer layer];
            bgly.frame = rect;
            bgly.fillColor = [UIColor whiteColor].CGColor;
            bp = [UIBezierPath bezierPath];
            [bp addArcWithCenter:p radius:pR-1 startAngle:0 endAngle:M_PI*2 clockwise:YES];
            bgly.path = bp.CGPath;
            [_lineView.layer addSublayer:bgly];
            
            if (x == _maxIdxp) {
                CAShapeLayer *ly = [CAShapeLayer layer];
                ly.frame = rect;
                ly.fillColor = [UIColor clearColor].CGColor;
                ly.strokeColor = UIColorFromRGBA(0x7df2d3, .3251).CGColor;
                ly.lineWidth = 15;
                bp = [UIBezierPath bezierPath];
                [bp addArcWithCenter:p radius:4 startAngle:0 endAngle:M_PI*2 clockwise:YES];
                ly.path = bp.CGPath;
                [_lineView.layer addSublayer:ly];
            }
        }
    }
}

-(CALayer*)getGradientHorizonLayer
{
    CAGradientLayer *gLayer = [CAGradientLayer layer];
    gLayer.colors = @[(__bridge id)UIColorFromRGB(0x16E05A).CGColor,
                      (__bridge id)UIColorFromRGB(0x00FFF5).CGColor,
                      (__bridge id)UIColorFromRGB(0x16E09D).CGColor,];
    gLayer.locations = @[@0,@.3,@1.0];
    gLayer.startPoint = CGPointMake(0, 0);
    gLayer.endPoint = CGPointMake(1, 0);
    gLayer.frame = _chartRect;
    
    return gLayer;
}

-(void)drawCurveLineWithPoints:(NSArray*)pts bzPath:(UIBezierPath*)path isLine:(BOOL)isLine
{
    if (pts.count > 0) {
        CGPoint p1 = [pts[0] CGPointValue];
        [path moveToPoint:p1];
    }
    
    for (int i = 0; i < 7; i++) {
        if (pts.count > i && pts.count > i+1) {
            CGPoint p1 = [pts[i] CGPointValue];
            CGPoint p2 = [pts[i+1] CGPointValue];
            
            CGFloat diffX = p2.x-p1.x;
            CGPoint cp1 = CGPointMake(p1.x+diffX/2.0, p1.y);
            CGPoint cp2 = CGPointMake(p1.x+diffX/2.0, p2.y);
            
            [path addCurveToPoint:p2 controlPoint1:cp1 controlPoint2:cp2];
        }
    }
}

-(CGPoint)getPointWithX:(int)x y:(float)y size:(CGSize)sz
{
    if (y>1) {
        y = y - (int)y;
    }
    if (x>7) {
        x = x%7;
    }
    CGFloat px = sz.width*x/7;
    CGFloat py = sz.height*(1-y);
    CGPoint p = CGPointMake(px, py);
    return p;
}



@end


@implementation UIView (CutView)

+(void)mp_cutRect:(CGRect)rect colCount:(NSUInteger)cols rowCount:(NSUInteger)rows renderCallback:(CMRenderRectIndexCallback)block
{
    cols = cols > 0 ? cols : 1;
    rows = rows > 0 ? rows : 1;
    CGSize tsize = CGSizeMake(rect.size.width / cols, rect.size.height / rows);
    CGRect frame;
    CGPoint pos = CGPointZero;
    for (int i = 0; i < rows; i++) {
        pos.x = 0;
        for (int j = 0; j < cols; j++) {
            frame = CGRectMake(pos.x, pos.y, tsize.width, tsize.height);
            //把frame转换成基于rect坐标位置
            frame.origin.x+=rect.origin.x;
            frame.origin.y+=rect.origin.y;
            block(frame,j,i);
            pos.x += tsize.width;
        }
        pos.y += tsize.height;
    }
}

+(void)mp_cutRect:(CGRect)rect colProportion:(NSString*)colPor rowProportion:(NSString*)rowPor renderCallback:(CMRenderRectIndexCallback)block
{
    NSArray *cols = [colPor componentsSeparatedByString:@":"];
    NSArray *rows = [rowPor componentsSeparatedByString:@":"];
    
    [self mp_cutRect:rect colPAry:cols rowPAry:rows renderCallback:block];
}

+(void)mp_cutRect:(CGRect)rect colPAry:(NSArray*)cols rowPAry:(NSArray*)rows renderCallback:(CMRenderRectIndexCallback)block
{
    cols = cols.count > 0 ? cols : @[@(1)];
    __block float part = 0;
    [cols enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        part += [obj floatValue];
    }];
    CGFloat perCol = rect.size.width/part;
    rows = rows.count > 0 ? rows : @[@(1)];
    part = 0;
    [rows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        part += [obj floatValue];
    }];
    CGFloat perRow = rect.size.height/part;
    
    CGFloat posY = 0;
    CGRect frame;
    for (int i=0; i<rows.count; i++) {
        CGFloat ht = perRow * [rows[i]floatValue];
        CGFloat posX = 0;
        for (int j=0; j<cols.count; j++) {
            CGFloat wd = perCol * [cols[j]floatValue];
            frame = CGRectMake(posX, posY, wd, ht);
            frame.origin.x+=rect.origin.x;
            frame.origin.y+=rect.origin.y;
            posX += wd;
            block(frame,j,i);
        }
        posY += ht;
    }
}


+(void)mp_cutRectByHorizontal:(CGRect)rect colProportion:(NSString *)colPor renderCallback:(CMRenderRectIndexCallback)block
{
    [self mp_cutRect:rect colProportion:colPor rowProportion:nil renderCallback:block];
}
+(void)mp_cutRectByVertical:(CGRect)rect rowProportion:(NSString *)rowPor renderCallback:(CMRenderRectIndexCallback)block
{
    [self mp_cutRect:rect colProportion:nil rowProportion:rowPor renderCallback:block];
}

-(void)mp_setRandomBg
{
    static BOOL seeded = NO;
    if (!seeded) {
        seeded = YES;
        srandom((int)time(NULL));
    }
    UIColor *col = [UIColor colorWithRed:((CGFloat)random()/(CGFloat)RAND_MAX) green:((CGFloat)random()/(CGFloat)RAND_MAX) blue:((CGFloat)random()/(CGFloat)RAND_MAX) alpha:1.0f];
    self.backgroundColor = col;
}


@end
