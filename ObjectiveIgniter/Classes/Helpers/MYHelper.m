// MYHelper.m
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

#import "MYHelper.h"

NSString *const kMYAppVersionStateNotChangedNotificationName        = @"MYAppVersionStateNotChangedNotificationName";
NSString *const kMYAppVersionStateFirstNotificationName             = @"MYAppVersionStateFirstNotificationName";
NSString *const kMYAppVersionStateBumpedUpNotificationName          = @"MYAppVersionStateBumpedUpNotificationName";
NSString *const kMYFoundationVersionStateNotChangedNotificationName = @"MYFoundationVersionStateNotChangedNotificationName";
NSString *const kMYFoundationVersionStateFirstNotificationName      = @"MYFoundationVersionStateFirstNotificationName";
NSString *const kMYFoundationVersionStateBumpedUpNotificationName   = @"MYFoundationVersionStateBumpedUpNotificationName";

@implementation MYHelper

static MYHelper *_sharedInstance = nil;
+ (MYHelper *)sharedHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MYHelper alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (NSString *)appVersionString
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildVersionString
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
}

+ (NSNumber *)appVersionNumber
{
    NSString *appVersionString = [MYHelper appVersionString];
    NSArray *array = [appVersionString componentsSeparatedByString:@"."];
    appVersionString = [NSString stringWithFormat:@"%ld%02ld", [array[0] longValue], [array[1] longValue]];
    return [NSNumber numberWithInteger:appVersionString.integerValue];
}

+ (NSNumber *)appBuildVersionNumber
{
    NSString *appVersionString = [MYHelper appVersionString];
    NSArray *array = [appVersionString componentsSeparatedByString:@"."];
    appVersionString = [NSString stringWithFormat:@"%ld%02ld.%02ld", [array[0] longValue], [array[1] longValue], [array[2] longValue]];
    return [NSNumber numberWithDouble:appVersionString.doubleValue];
}

NSString *const kTrackingAppVersionKey = @"kTrackingAppVersionKey";
+ (void)setTrackingAppVersion
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[MYHelper appVersionString] forKey:kTrackingAppVersionKey];
    [defaults synchronize];
}

+ (NSString *)getTrackingAppVersion
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kTrackingAppVersionKey];
}

NSString *const kTrackingFoundationVersionKey = @"kTrackingFoundationVersionKey";
+ (void)setTrackingFoundationVersion
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%f", NSFoundationVersionNumber] forKey:kTrackingFoundationVersionKey];
    [defaults synchronize];
}

+ (NSString *)getTrackingFoundationVersion
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kTrackingFoundationVersionKey];
}

- (void)checkAppVersionState
{
    [self appVersionState];
    return;
}

- (MYAppVersionState)appVersionState
{
    NSString *trackingAppVersion = [MYHelper getTrackingAppVersion];
    NSString *currentAppVersion = [MYHelper appVersionString];
    MYAppVersionState state = MYAppVersionStateNotChanged;
    if (trackingAppVersion == nil) {
        state = MYAppVersionStateFirst;
        [[NSNotificationCenter defaultCenter] postNotificationName:kMYAppVersionStateFirstNotificationName object:nil];
        if ([_delegate respondsToSelector:@selector(appVersionStateFirst)]) {
            [_delegate appVersionStateFirst];
        }
    } else if (![trackingAppVersion isEqualToString:currentAppVersion]) {
        state = MYAppVersionStateBumpedUp;
        [[NSNotificationCenter defaultCenter] postNotificationName:kMYAppVersionStateBumpedUpNotificationName object:nil];
        if ([_delegate respondsToSelector:@selector(appVersionStateBumpedUp)]) {
            [_delegate appVersionStateBumpedUp];
        }
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kMYAppVersionStateNotChangedNotificationName object:nil];
        if ([_delegate respondsToSelector:@selector(appVersionStateNotChanged)]) {
            [_delegate appVersionStateNotChanged];
        }
    }
    
    if (state > MYAppVersionStateNotChanged) {
        [MYHelper setTrackingAppVersion];
    }
    
    if ([_delegate respondsToSelector:@selector(appVersionState:)]) {
        [_delegate appVersionState:state];
    }
    return state;
}

- (void)checkFoundationVersionState
{
    [self foundationVersionState];
    return;
}

- (MYFoundationVersionState)foundationVersionState
{
    double trackingFoundationVersion = [[MYHelper getTrackingFoundationVersion] doubleValue];
    double currentFoundationVersion = NSFoundationVersionNumber;
    MYFoundationVersionState state = MYFoundationVersionStateNotChanged;
    if (trackingFoundationVersion == 0) {
        state = MYFoundationVersionStateFirst;
        [[NSNotificationCenter defaultCenter] postNotificationName:kMYFoundationVersionStateFirstNotificationName object:nil];
        if ([_delegate respondsToSelector:@selector(foundationVersionStateFirst)]) {
            [_delegate foundationVersionStateFirst];
        }
    } else if (trackingFoundationVersion < currentFoundationVersion) {
        state = MYFoundationVersionStateBumpedUp;
        [[NSNotificationCenter defaultCenter] postNotificationName:kMYFoundationVersionStateBumpedUpNotificationName object:nil];
        if ([_delegate respondsToSelector:@selector(foundationVersionStateBumpedUp)]) {
            [_delegate foundationVersionStateBumpedUp];
        }
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kMYFoundationVersionStateNotChangedNotificationName object:nil];
        if ([_delegate respondsToSelector:@selector(foundationVersionStateNotChanged)]) {
            [_delegate foundationVersionStateNotChanged];
        }
    }
    
    if (state > MYFoundationVersionStateNotChanged) {
        [MYHelper setTrackingFoundationVersion];
    }
    
    if ([_delegate respondsToSelector:@selector(foundationVersionState:)]) {
        [_delegate foundationVersionState:state];
    }
    return state;
}

@end