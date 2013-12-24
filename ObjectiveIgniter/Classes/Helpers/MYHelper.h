// MYHelper.h
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

#import <Foundation/Foundation.h>

#import "UIColor+Util.h"
#import "UIFont+Util.h"

// Make Debug Log not to use NSLog basically
#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
# define DLog(...)
#endif

// Remove NSLog if Release build
#ifndef DEBUG
# ifdef NSLog
#  undef NSLog
# endif
# define NSLog(...)
#endif

typedef void(^MYSuccessHandler)(id userInfo);
typedef void(^MYFailureHandler)(NSError *error);

NS_INLINE BOOL
__OSVersionNumberAtLeast_iOS_7_0() {
    return (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1);
}
#define OSVersionNumberAtLeast_iOS_7_0 (__OSVersionNumberAtLeast_iOS_7_0())

typedef NS_ENUM(NSInteger, MYAppVersionState) {
    MYAppVersionStateNotChanged,
    MYAppVersionStateFirst,
    MYAppVersionStateBumpedUp,
};

typedef NS_ENUM(NSInteger, MYFoundationVersionState) {
    MYFoundationVersionStateNotChanged,
    MYFoundationVersionStateFirst,
    MYFoundationVersionStateBumpedUp,
};

extern NSString *const kMYAppVersionStateNotChangedNotificationName;
extern NSString *const kMYAppVersionStateFirstNotificationName;
extern NSString *const kMYAppVersionStateBumpedUpNotificationName;
extern NSString *const kMYFoundationVersionStateNotChangedNotificationName;
extern NSString *const kMYFoundationVersionStateFirstNotificationName;
extern NSString *const kMYFoundationVersionStateBumpedUpNotificationName;

@protocol MYHelperDelegate;

@interface MYHelper : NSObject
@property (nonatomic, assign) id<MYHelperDelegate> delegate;

+ (MYHelper *)sharedHelper;

+ (NSString *)appVersionString;
+ (NSString *)appBuildVersionString;

+ (NSNumber *)appVersionNumber;
+ (NSNumber *)appBuildVersionNumber;

+ (void)setTrackingAppVersion;
+ (NSString *)getTrackingAppVersion;

+ (void)setTrackingFoundationVersion;
+ (NSString *)getTrackingFoundationVersion;

- (void)checkAppVersionState;
- (MYAppVersionState)appVersionState;

- (void)checkFoundationVersionState;
- (MYFoundationVersionState)foundationVersionState;
@end

@protocol MYHelperDelegate <NSObject>
@optional
- (void)appVersionState:(MYAppVersionState)state;
- (void)appVersionStateNotChanged;
- (void)appVersionStateFirst;
- (void)appVersionStateBumpedUp;

- (void)foundationVersionState:(MYFoundationVersionState)state;
- (void)foundationVersionStateNotChanged;
- (void)foundationVersionStateFirst;
- (void)foundationVersionStateBumpedUp;
@end