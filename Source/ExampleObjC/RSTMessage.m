//
//  RSTMessage.m
//  ExampleObjC
//
//  Created by Chris Ballinger on 4/27/18.
//

#import <Foundation/Foundation.h>
#import "RSTMessage.h"
#import "example.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ByteSlice)
+ (nullable NSString*) stringFromByteSlice:(struct ByteSlice)byteSlice;
@end

@implementation NSString (ByteSlice)
+ (nullable NSString*) stringFromByteSlice:(struct ByteSlice)byteSlice {
    return [[NSString alloc] initWithBytesNoCopy:(void*)byteSlice.bytes length:byteSlice.length encoding:NSUTF8StringEncoding freeWhenDone:NO];
}
@end

@interface RSTMessage()
@property (nonatomic, readonly) struct message *message;
@end

@implementation RSTMessage

- (instancetype) initWithText:(NSString*)text {
    self = [super init];
    if (self) {
        _message = message_new(text.UTF8String);
    }
    return self;
}

- (void) dealloc {
    message_destroy(_message);
    _message = nil;
}

- (NSString*) name {
    struct ByteSlice slice = message_get_text(_message);
    return [NSString stringFromByteSlice:slice];
}

@end

NS_ASSUME_NONNULL_END
