// JNSwapIMP.h
// Copyright (c) 2015 Joseph Newton
// Some rights reserved: http://opensource.org/licenses/MIT
// https://github.com/JNApps/jnswapimp

#import "JRSwizzle.h"

/*!
 *  @discussion The JNSwapIMP category gives the ability to swap out the implementation of any object that inherits from NSObject. Swapping out the implementation allows a custom override of any method for any object or class.
 */
@interface NSObject (JNSwapIMP)

/*! 
 *  @method jn_swapMethod:withIMP:error:
 *  @abstract This method replaces the implemenation of the provided selector with the implementation specified
 *  @discussion The implementation of the method is changed while the name remain the same, meaning that any calls to the method will actually call the specified implementation. Although the change don't persist outside of the current process, it is strongly recommended to swap-back the original implementation (returned from this method upon success) after use or before exiting the process to avoid potential crashes or memory leakage
 *  @param origSel The selector whose implementation will be replaced
 *  @param altIMP The new implemenation for `origSel`
 *  @param error An error pointer to hold description in case of failure
 *  @returns The original implementation of `origSel`
 */
+ (IMP)jn_swapMethod:(SEL)origSel withIMP:(IMP)altIMP error:(NSError **)error;

/*! 
 *  @method jn_swapClassMethod:withIMP:error:
 *  @abstract This method replaces the implemenation of the provided class selector with the implementation specified
 *  @discussion The implementation of the method is changed while the name remain the same, meaning that any calls to the method will actually call the specified implementation. Although the change don't persist outside of the current process, it is strongly recommended to swap-back the original implementation (returned from this method upon success) after use or before exiting the process to avoid potential crashes or memory leakage
 *  @param origSel The selector whose implementation will be replaced
 *  @param altIMP The new implemenation for `origSel`
 *  @param error An error pointer to hold description in case of failure
 *  @returns The original implementation of `origSel`
 */
+ (IMP)jn_swapClassMethod:(SEL)origSel withIMP:(IMP)altIMP error:(NSError **)error;

@end
