//
//  CCResourceAsyncLoaderTest.m
//  cocos2d-extensions
//
//  Created by Keisuke Hata on 11/06/22.
//


// Import the interfaces
#import "CCResourceAsyncLoaderTest.h"
#import "CCResourceAsyncLoader.h"

SYNTHESIZE_EXTENSION_TEST(CCResourceAsyncLoaderTest)

enum {
    
    kTag_CCRAL_Test_Loader = 0x1,
    kTag_CCRAL_Test_Label
};

@interface CCResourceAsyncLoaderTest()

- (void) loadComplete;

@end

@implementation CCResourceAsyncLoaderTest

-(id) init
{
	if( (self=[super init])) {
		
        CCLabelTTF *label = [CCLabelTTF labelWithString:@" " fontName:@"Marker Felt" fontSize:24];
        
        // ローダーの生成
        CCResourceAsyncLoader *loader = nil;
        NSArray *resourceNames = [NSArray arrayWithObjects:
                                  @"1.png",
                                  @"2.png",
                                  @"3.png",
                                  @"4.png",
                                  nil];
        
        // ローディング中のラベル
        NSString *s = [NSString stringWithFormat:@"Now Loading...[%d]",[resourceNames count]];
        [label setString:s];
        label.tag = kTag_CCRAL_Test_Label;
        label.position = ccp(160,40);
        [self addChild:label];
        
        // ローダーセットアップ
        CCSendMessages *message = [CCSendMessages actionWithTarget:self];
        [[message addMessage] loadComplete];
        loader = [CCResourceAsyncLoader loaderWithCount:[resourceNames count]];
        loader.tag = kTag_CCRAL_Test_Loader;
        for (NSString *path in resourceNames) {
            [loader addLoadAsyncTexture:path message:message];
        }
        // ローダー起動
        [self addChild:loader];
	}
	return self;
}

- (void) loadComplete {

    CCNode *obj = [self getChildByTag:kTag_CCRAL_Test_Loader];
    NSAssert([obj isKindOfClass:[CCResourceAsyncLoader class]],@"Not CCResourceAsyncLoader");

    CCResourceAsyncLoader *loader = (CCResourceAsyncLoader *)obj;
    loader.resourceCount--;
    CCLOG(@"count:%d",loader.resourceCount);

    // Load Complete!!
    if( loader.resourceCount == 0 ) {
        
        /* write next scene jump code */
        /* for example
         
        CCSendMessages *message = [CCSendMessages actionWithTarget:[CCDirector sharedDirector]];
     
        // to Next Scene Action
        [[message addMessage] replaceScene:[CCTransitionCrossFade 
                                         transitionWithDuration:1.0 
                                        scene:[CCResourceAsyncLoaderTest scene]]];
        [self runAction:message];
         */
    }

    CCLabelTTF *label = (CCLabelTTF *)[self getChildByTag:kTag_CCRAL_Test_Label];
    NSAssert(label!=nil,@"label is nil");
    NSString *s = [NSString stringWithFormat:@"Now Loading...[%d]",loader.resourceCount];
    [label setString:s];
    CCLOG(@"TextureLoaded...");
}

- (void) dealloc
{
	[super dealloc];
}

@end
