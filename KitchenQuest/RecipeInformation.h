//
//  RecipeInformation.h
//  KitchenQuest
//
//  Created by William Cremin on 12/14/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

typedef void(^RecipeInfoCompletion)(BOOL success, NSString *result);

@interface RecipeInformation : NSObject

+ (void)getRecipeURLWithID:(NSString *)idNumber completion:(RecipeInfoCompletion)completion;

@end
