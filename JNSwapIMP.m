// JNSwapIMP.m
// Copyright (c) 2015 Joseph Newton
// Some rights reserved: http://opensource.org/licenses/MIT
// https://github.com/JNApps/jnswapimp

#import "JNSwapIMP.h"

//Code between /**!!**/ blocks copied from JRSwizzle.m v1.0
// Copyright (c) 2007-2011 Jonathan 'Wolf' Rentzsch: http://rentzsch.com
// https://github.com/rentzsch/jrswizzle
/**!!**/
#if TARGET_OS_IPHONE
#import <objc/runtime.h>
#import <objc/message.h>
#else
#import <objc/objc-class.h>
#endif

#define SetNSErrorFor(FUNC, errorVAR, FORMAT,...)	\
    if (errorVAR) {	\
        NSString *errStr = [NSString stringWithFormat:@"%s: " FORMAT,FUNC,##__VA_ARGS__]; \
        *errorVAR = [NSError errorWithDomain:@"NSCocoaErrorDomain" \
                                         code:-1	\
                                     userInfo:[NSDictionary dictionaryWithObject:errStr forKey:NSLocalizedDescriptionKey]]; \
    }
#define SetNSError(errorVAR, FORMAT,...) SetNSErrorFor(__func__, errorVAR, FORMAT, ##__VA_ARGS__)

#if OBJC_API_VERSION >= 2
#define GetClass(obj)	object_getClass(obj)
#else
#define GetClass(obj)	(obj ? obj->isa : Nil)
#endif
/**!!**/

@implementation NSObject (JNSwapIMP)

+ (IMP)jn_swapMethod:(SEL)origSel withIMP:(IMP)altIMP error:(NSError **)error {
    Method origMethod = class_getInstanceMethod(self, origSel);
    if (!origMethod) {
#if TARGET_OS_IPHONE
        SetNSError(error, @"original method %@ not found for class %@", NSStringFromSelector(origSel), [self class]);
#else
        SetNSError(error, @"original method %@ not found for class %@", NSStringFromSelector(origSel), [self className]);
#endif
        return nil;
    }
    
    class_addMethod(self,
                    origSel,
                    class_getMethodImplementation(self, origSel),
                    method_getTypeEncoding(origMethod));
    
    return method_setImplementation(origMethod, altIMP);
}

+ (IMP)jn_swapClassMethod:(SEL)origSel withIMP:(IMP)altIMP error:(NSError **)error {
    return [GetClass((id)self) jn_swapMethod:origSel withIMP:altIMP error:error];
}

@end
