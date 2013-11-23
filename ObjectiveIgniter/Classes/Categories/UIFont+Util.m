// UIFont+Util.m
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

#import "UIFont+Util.h"

@implementation UIFont (Util)
@end

@implementation UIFont (Avenir)

+ (UIFont *)avenirFontWithType:(AvenirFontType)type size:(CGFloat)size
{
    NSString *fontName;
    switch (type) {
        case AvenirFontTypeLightOblique:
            fontName = @"Avenir-LightOblique";
            break;
        case AvenirFontTypeMediumOblique:
            fontName = @"Avenir-MediumOblique";
            break;
        case AvenirFontTypeMedium:
            fontName = @"Avenir-Medium";
            break;
        case AvenirFontTypeHeavyOblique:
            fontName = @"Avenir-HeavyOblique";
            break;
        case AvenirFontTypeBlackOblique:
            fontName = @"Avenir-BlackOblique";
            break;
        case AvenirFontTypeOblique:
            fontName = @"Avenir-Oblique";
            break;
        case AvenirFontTypeBook:
            fontName = @"Avenir-Book";
            break;
        case AvenirFontTypeRoman:
            fontName = @"Avenir-Roman";
            break;
        case AvenirFontTypeBookOblique:
            fontName = @"Avenir-BookOblique";
            break;
        case AvenirFontTypeLight:
            fontName = @"Avenir-Light";
            break;
        case AvenirFontTypeHeavy:
            fontName = @"Avenir-Heavy";
            break;
        case AvenirFontTypeBlack:
            fontName = @"Avenir-Black";
            break;
        case AvenirFontTypeRegular:
        default:
            fontName = @"Avenir";
            break;
    }
    return [UIFont fontWithName:fontName size:size];
}

@end

@implementation UIFont (AvenirNext)

+ (UIFont *)avenirNextFontWithType:(AvenirNextFontType)type size:(CGFloat)size
{
    NSString *fontName;
    switch (type) {
        case AvenirNextFontTypeHeavy:
            fontName = @"AvenirNext-Heavy";
            break;
        case AvenirNextFontTypeDemiBoldItalic:
            fontName = @"AvenirNext-DemiBoldItalic";
            break;
        case AvenirNextFontTypeUltraLightItalic:
            fontName = @"AvenirNext-UltraLightItalic";
            break;
        case AvenirNextFontTypeHeavyItalic:
            fontName = @"AvenirNext-HeavyItalic";
            break;
        case AvenirNextFontTypeMediumItalic:
            fontName = @"AvenirNext-MediumItalic";
            break;
        case AvenirNextFontTypeUltraLight:
            fontName = @"AvenirNext-UltraLight";
            break;
        case AvenirNextFontTypeBoldItalic:
            fontName = @"AvenirNext-BoldItalic";
            break;
        case AvenirNextFontTypeDemiBold:
            fontName = @"AvenirNext-DemiBold";
            break;
        case AvenirNextFontTypeBold:
            fontName = @"AvenirNext-Bold";
            break;
        case AvenirNextFontTypeMedium:
            fontName = @"AvenirNext-Medium";
            break;
        case AvenirNextFontTypeItalic:
            fontName = @"AvenirNext-Italic";
            break;
        case AvenirNextFontTypeRegular:
        default:
            fontName = @"AvenirNext-Regular";
            break;
    }
    return [UIFont fontWithName:fontName size:size];
}

@end
