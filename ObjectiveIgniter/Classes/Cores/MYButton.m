// MYButton.m
//
// Copyright (c) 2013 Shintaro Kaneko (http://kaneshinth.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MYButton.h"

#import "UIColor+Util.h"

@interface MYButton ()
@end

@implementation MYButton

- (id)initWithFrame:(CGRect)frame
       cornerRadius:(CGFloat)cornerRadius
{
    return [self initWithFrame:frame
                   borderWidth:0.f
                   borderColor:[UIColor clearColor]
                  cornerRadius:cornerRadius];
}

- (id)initWithFrame:(CGRect)frame
        borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor
{
    return [self initWithFrame:frame
                   borderWidth:borderWidth
                   borderColor:borderColor
                  cornerRadius:0.f];
}

- (id)initWithFrame:(CGRect)frame
        borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor
       cornerRadius:(CGFloat)cornerRadius
{
    self = [super initWithFrame:frame];
    if (self) {
        self.borderWidth = borderWidth;
        self.borderColor = borderColor;
        self.cornerRadius = cornerRadius;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CALayer *layer = self.layer;
    layer.borderWidth = self.borderWidth;
    layer.borderColor = self.borderColor.CGColor;
    layer.cornerRadius = self.cornerRadius;
    layer.masksToBounds = YES;
    layer.rasterizationScale = [UIScreen mainScreen].scale;
    layer.shouldRasterize = YES;
}

@end


@implementation MYFadingButton {
    UIColor *_backgroundColor;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    switch (state) {
        case UIControlStateNormal:
            self.backgroundColor = backgroundColor;
            break;
        case UIControlStateHighlighted:
            _highlightedColor = backgroundColor;
            break;
        default:
            break;
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    self.layer.backgroundColor = _backgroundColor.CGColor;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    self.layer.backgroundColor = self.highlightedColor.CGColor;
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    UIView *view = touch.view;
    if ([view pointInside:[touch locationInView:view] withEvent:nil]) {
        self.layer.backgroundColor = self.highlightedColor.CGColor;
    } else {
        [UIView animateWithDuration:self.duration
                         animations:^{
                             self.layer.backgroundColor = _backgroundColor.CGColor;
                         }];
    }
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:self.duration
                     animations:^{
                         self.layer.backgroundColor = _backgroundColor.CGColor;
                     }];
    [super endTrackingWithTouch:touch withEvent:event];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    [super cancelTrackingWithEvent:event];
}

@end