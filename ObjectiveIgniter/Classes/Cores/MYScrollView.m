// MYScrollView.m
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

#import "MYScrollView.h"

@implementation MYScrollView {
    MYScrollViewPagingDirection _pagingDirection;
    NSInteger _numberOfPages;
}


#pragma mark -
#pragma mark Paging Direction

@synthesize pagingDirection = _pagingDirection;
- (MYScrollViewPagingDirection)pagingDirection
{
    return _pagingDirection;
}

- (void)setPagingDirection:(MYScrollViewPagingDirection)pagingDirection
{
    _pagingDirection = pagingDirection;
    [self setNumberOfPages:_numberOfPages];
}


#pragma mark -
#pragma mark Number Of Pages

@synthesize numberOfPages = _numberOfPages;
- (NSInteger)numberOfPages
{
    return _numberOfPages;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    CGRect bounds = self.bounds;
    CGSize contentSize = CGSizeMake(CGRectGetWidth(bounds), CGRectGetHeight(bounds));
    switch (_pagingDirection) {
        case MYScrollViewPagingDirectionHorizontal:
            contentSize.width *= numberOfPages;
            break;
        case MYScrollViewPagingDirectionVertical:
            contentSize.height *= numberOfPages;
            break;
    }
    self.contentSize = contentSize;
}


#pragma mark -
#pragma mark Current Pages

- (NSInteger)currentPage
{
    CGFloat pageWidth = self.bounds.size.width;
    return floor((self.contentOffset.x - .5f * pageWidth) / pageWidth) + 1;
}


#pragma mark -
#pragma mark Scroll Indicator

- (void)setShowsScrollIndicator:(BOOL)showsScrollIndicator
{
    self.showsHorizontalScrollIndicator = showsScrollIndicator;
    self.showsVerticalScrollIndicator = showsScrollIndicator;
}

@end
