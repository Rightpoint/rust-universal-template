//
//  empty.m
//  ExampleCore
//
//  Created by Chris Ballinger on 4/27/18.
//

#import <Foundation/Foundation.h>
#import "example.h"

/// This file is needed to prevent the linker
/// from stripping the symbols from the libexample.a library
@interface ExampleCoreEmpty: NSObject
@end
@implementation ExampleCoreEmpty
- (void) empty {
    message_new("");
    @throw NSInternalInconsistencyException;
}
@end
