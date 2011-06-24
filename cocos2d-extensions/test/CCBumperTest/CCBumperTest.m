//
//  CCBumperTest.m
//  cocos2d-extensions
//
//  Created by Keisuke Hata on 11/06/25.
//

#import "CCBumperTest.h"
#import "CCSendMessages.h"
#import "CCBumper.h"

/* Sample Crossfade CCBumper 
 
 Usage:
 AppDelegate.m

 [[CCDirector sharedDirector] replaceScene:[CCBumperCrossFade scene]]
 
 */

@implementation CCBumperCrossFade

+ (CCScene *) scene {

    return [CCBumperCrossFade scene:@"Bumper.png"];
}

- (void) onEnter {
    
    // Next SceneChange settings
    CCSendMessages *message = [CCSendMessages actionWithTarget:[CCDirector sharedDirector]];
    CCTransitionCrossFade *crossFade = [CCTransitionCrossFade transitionWithDuration:1.0 scene:[CCBumperTest scene]];
    [[CCDirector sharedDirector] replaceScene:crossFade];
    
    // Create Action
    const float fadeDuration = 3.0;
    CCSequence *seq = [CCSequence actions:[CCDelayTime actionWithDuration:fadeDuration],message, nil];
    [self runAction:seq];
    
    [super onEnter];
}

@end

@implementation CCBumperTest

+ (CCScene *) scene {
    
    CCScene *scene = [CCScene node];
    [scene addChild:[CCBumperTest node]];
    
    return scene;
}


- (id)init
{
    self = [super init];
    if (self) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello!!" fontName:@"Marker Felt"  fontSize:40];
        [self addChild:label];
        label.position = ccp(size.width/2,size.height/2);
    }
    
    return self;
}

@end
