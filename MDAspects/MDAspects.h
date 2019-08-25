//
//  Aspects.h
//  Aspects - A delightful, simple library for aspect oriented programming.
//
//  Copyright (c) 2014 Peter Steinberger. Licensed under the MIT license.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, MDAspectOptions) {
    MDAspectPositionAfter   = 0,            /// 默认，当原方法执行完调用
    MDAspectPositionInstead = 1,            /// 替换原方法
    MDAspectPositionBefore  = 2,            /// 原方法执行前调用
    
    MDAspectOptionAutomaticRemoval = 1 << 3 /// Will remove the hook after the first execution.
};

/// Opaque Aspect Token that allows to deregister the hook.
@protocol MDAspectToken <NSObject>

/// Deregisters an aspect.
/// @return YES if deregistration is successful, otherwise NO.
- (BOOL)remove;

@end

/// The AspectInfo protocol is the first parameter of our block syntax.
@protocol MDAspectInfo <NSObject>

/// The instance that is currently hooked.
- (id)instance;

/// The original invocation of the hooked method.
- (NSInvocation *)originalInvocation;

/// All method arguments, boxed. This is lazily evaluated.
- (NSArray *)arguments;

@end

/**
 Aspects uses Objective-C message forwarding to hook into messages. This will create some overhead. Don't add aspects to methods that are called a lot. Aspects is meant for view/controller code that is not called a 1000 times per second.

 Adding aspects returns an opaque token which can be used to deregister again. All calls are thread safe.
 */
@interface NSObject (MDAspects)

/// Adds a block of code before/instead/after the current `selector` for a specific class.
///
/// @param block Aspects replicates the type signature of the method being hooked.
/// The first parameter will be `id<AspectInfo>`, followed by all parameters of the method.
/// These parameters are optional and will be filled to match the block signature.
/// You can even use an empty block, or one that simple gets `id<AspectInfo>`.
///
/// @note Hooking static methods is not supported.
/// @return A token which allows to later deregister the aspect.
+ (id<MDAspectToken>)aspect_hookSelector:(SEL)selector
                      withOptions:(MDAspectOptions)options
                       usingBlock:(id)block
                            error:(NSError **)error;

/// Adds a block of code before/instead/after the current `selector` for a specific instance.
- (id<MDAspectToken>)aspect_hookSelector:(SEL)selector
                      withOptions:(MDAspectOptions)options
                       usingBlock:(id)block
                            error:(NSError **)error;
//拦截类方法
+ (id<MDAspectToken>)aspect_hookClassSelector:(SEL)selector withOptions:(MDAspectOptions)options usingBlock:(id)block error:(NSError *__autoreleasing *)error;
//拦截类方法
- (id<MDAspectToken>)aspect_hookClassSelector:(SEL)selector withOptions:(MDAspectOptions)options usingBlock:(id)block error:(NSError *__autoreleasing *)error;



@end


typedef NS_ENUM(NSUInteger, MDAspectErrorCode) {
    MDAspectErrorSelectorBlacklisted,                   /// Selectors like release, retain, autorelease are blacklisted.
    MDAspectErrorDoesNotRespondToSelector,              /// Selector could not be found.
    MDAspectErrorSelectorDeallocPosition,               /// When hooking dealloc, only AspectPositionBefore is allowed.
    MDAspectErrorSelectorAlreadyHookedInClassHierarchy, /// Statically hooking the same method in subclasses is not allowed.
    MDAspectErrorFailedToAllocateClassPair,             /// The runtime failed creating a class pair.
    MDAspectErrorMissingBlockSignature,                 /// The block misses compile time signature info and can't be called.
    MDAspectErrorIncompatibleBlockSignature,            /// The block signature does not match the method or is too large.

    MDAspectErrorRemoveObjectAlreadyDeallocated = 100   /// (for removing) The object hooked is already deallocated.
};

extern NSString *const MDAspectErrorDomain;
