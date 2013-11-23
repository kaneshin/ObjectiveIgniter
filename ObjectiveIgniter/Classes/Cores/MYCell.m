// MYCell.m
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

#import "MYCell.h"

#import "MYTableView.h"

@interface MYCell ()
- (void)horizontal;
@end

@implementation MYCell

@synthesize reused = _reused;
- (void)prepareForReuse
{
    [super prepareForReuse];
    _reused = YES;
}

- (BOOL)reused
{
    return _reused;
}

- (BOOL)isGrouped
{
    return (UITableViewStyleGrouped == self.superTableView.style);
}

+ (NSString *)identifier
{
    return NSStringFromClass([self class]);
}

+ (UINib *)nibFromMainBundle
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

- (UITableView *)superTableView
{
    id superview = self.superview;
    while (superview != nil && ![superview isKindOfClass:[UITableView class]]) {
        superview = [(UIView *)superview superview];
    }
    return superview;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if ([[self superTableView] isKindOfClass:[MYHorizontalTableView class]]) {
        [self horizontal];
    }
}

- (void)horizontal
{
    CGRect frame = self.frame;
   	self.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.frame = frame;
}

- (UIColor *)normalBackgroundColor
{
    if (_normalBackgroundColor == nil) {
        _normalBackgroundColor = [UIColor clearColor];
    }
    return _normalBackgroundColor;
}

- (UIColor *)highlightedBackgroundColor
{
    if (_highlightedBackgroundColor == nil) {
        _highlightedBackgroundColor = [UIColor clearColor];
    }
    return _highlightedBackgroundColor;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (self.selectionStyle != UITableViewCellSelectionStyleNone) {
        return;
    }
    [UIView animateWithDuration:.1f
                     animations:^{
                         self.backgroundColor = self.highlightedBackgroundColor;
                     }];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if (self.selectionStyle != UITableViewCellSelectionStyleNone) {
        return;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    if (self.selectionStyle != UITableViewCellSelectionStyleNone) {
        return;
    }
    [UIView animateWithDuration:.2f
                     animations:^{
                         self.backgroundColor = self.normalBackgroundColor;
                     }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (self.selectionStyle != UITableViewCellSelectionStyleNone) {
        return;
    }
    [UIView animateWithDuration:.2f
                     animations:^{
                         self.backgroundColor = self.normalBackgroundColor;
                     }];
}

@end