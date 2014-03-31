//
//  TTaggableView.m
//  TTag
//
//  Created by T. A. Weerasooriya on 3/31/14.
//  Copyright (c) 2014 T. A. Weerasooriya. All rights reserved.
//

#import "TTaggableView.h"

@implementation TTaggableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        taggableFrame = CGRectMake(20, 20, 280, 280);
        
        //Load the image you want to tag here
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:taggableFrame];
//        imageView.image = [UIImage imageNamed:@"60763_WW8415.jpeg"];
//        [self addSubview:imageView];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    // Get the specific point that was touched
    if (CGRectContainsPoint(taggableFrame, [touch locationInView:self])) {
        moved = FALSE;

    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    // Get the specific point that was touched
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(taggableFrame, point)) {
        moved = TRUE;
        
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    // Get the specific point that was touched
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(taggableFrame, point)) {
        if (!moved) {
            UIButton *btnInfo = [UIButton buttonWithType:UIButtonTypeInfoDark];
            btnInfo.frame = CGRectMake(point.x, point.y, 20, 20);
            [btnInfo addTarget:self action:@selector(wasDragged:withEvent:)
             forControlEvents:UIControlEventTouchDragInside];
            [btnInfo addTarget:self action:@selector(infoButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btnInfo];
        }
    }

}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];

}


#pragma mark -

- (void)wasDragged:(UIButton *)button withEvent:(UIEvent *)event
{
	// get the touch
	UITouch *touch = [[event touchesForView:button] anyObject];
    
	// get delta
	CGPoint previousLocation = [touch previousLocationInView:button];
	CGPoint location = [touch locationInView:button];
    
    
        CGFloat delta_x = location.x - previousLocation.x;
        CGFloat delta_y = location.y - previousLocation.y;
        
        // move button
    if (CGRectContainsPoint(taggableFrame, CGPointMake(button.center.x + delta_x,
                                                       button.center.y + delta_y))) {
        button.center = CGPointMake(button.center.x + delta_x,
                                    button.center.y + delta_y);

    }
}

- (void)infoButtonTapped:(id)sender{
    NSLog(@"info button tapped");
    UIButton *infoButton = (UIButton *)sender;
    CGPoint point = infoButton.frame.origin;
    NSLog(@"X: %f, Y: %f",point.x,point.y);
}

@end
