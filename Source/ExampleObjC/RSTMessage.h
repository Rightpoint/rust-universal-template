//
//  RSTMessage.h
//  ExampleObjC
//
//  Created by Chris Ballinger on 4/27/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface RSTMessage: NSObject
@property (nonatomic, readonly, nullable) NSString *name;

- (instancetype) initWithText:(NSString*)text NS_DESIGNATED_INITIALIZER;

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;
@end
NS_ASSUME_NONNULL_END
