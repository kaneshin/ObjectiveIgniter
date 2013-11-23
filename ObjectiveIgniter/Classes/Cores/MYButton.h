// MYButton.h
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

#import <UIKit/UIKit.h>

@interface MYButton : UIButton
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, copy) UIColor *borderColor;

- (id)initWithFrame:(CGRect)frame
       cornerRadius:(CGFloat)cornerRadius;

- (id)initWithFrame:(CGRect)frame
        borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor;

- (id)initWithFrame:(CGRect)frame
        borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor
       cornerRadius:(CGFloat)cornerRadius;
@end


@interface MYFadingButton : MYButton
@property (nonatomic, copy) UIColor *highlightedColor;
@property (nonatomic, assign) CGFloat duration;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
@end