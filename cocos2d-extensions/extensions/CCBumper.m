/*
 * CCBumper 
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

#import "CCBumper.h"

enum {
  
    kTag_CCBumper_Logo = 0x1
};

@interface CCBumper()

- (CCBumper *) initWithContentsOfFile : (NSString *)logoFile;

@end

@implementation CCBumper

+ (CCScene *) scene : (NSString *)logoFile {
    
    CCScene *scene = [CCScene node];
	[scene addChild:[[[self alloc] initWithContentsOfFile:logoFile] autorelease]];
	
	return scene;
}

- (CCBumper *) initWithContentsOfFile : (NSString *)logoFile {
 
    self = [super init];
    if( self ) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];

        CCSprite *logo = [CCSprite spriteWithFile:logoFile];
        NSAssert(logo!=nil,@"Can't load CCBumper sprite");
        
        [self addChild:logo];
        logo.tag = kTag_CCBumper_Logo;
        logo.position = ccp( size.width/2,size.height/2 );
    }
    return self;
}

@end
