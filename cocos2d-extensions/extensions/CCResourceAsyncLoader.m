/*
 * CCResourceAsyncLoader 
 *
 * Copyright (c) 2011 by Keisuke Hata(@Seasons)
 * http://d.hatena.ne.jp/Seasons/
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "CCResourceAsyncLoader.h"

@interface CCResourceAsyncLoader()
- (id) initWithCount:(int)maxResourceCount;
@end

@implementation CCResourceAsyncLoader

@synthesize maxResourceCount = maxResourceCount_;
@synthesize resourceCount    = resourceCount_;

+ (id) loaderWithCount : (int)maxResourceCount {
    
    return [[[self alloc] initWithCount:maxResourceCount] autorelease];
}

- (id) initWithCount:(int)maxResourceCount {
    
    self = [super init];
    if( self ) {
        
        resourceCount_    = 0;
        maxResourceCount_ = maxResourceCount;
        loadResourceLists_ = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) addLoadAsyncTexture :(NSString *)textureFilePath
                      message:(CCSendMessages *)message {
    
    NSAssert( resourceCount_ < maxResourceCount_ , @"Load ResourceCount over!!" );
    NSAssert( [loadResourceLists_ objectForKey:textureFilePath]==nil , @"Key already exists!!" );
    
    resourceCount_ ++;
    [loadResourceLists_ setObject:message forKey:textureFilePath];
}

- (void) onEnter {
    
    NSArray *keys = [loadResourceLists_ allKeys];
    for (NSString *key in keys) {
        [[CCTextureCache sharedTextureCache] addImageAsync:key
                                                    target:[loadResourceLists_ objectForKey:key]
                                                  selector:@selector(execute)];
    }
    [super onEnter];
}

- (void) onExit {
    
    // [IMPORTANT]
    // loadResourceLists have retain object, so you must release in onExit.
    // Otherwise , dealloc method never be called.
    [loadResourceLists_ release];
    [super onExit];
}

@end
