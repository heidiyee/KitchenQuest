//
//  IngredientAutocomplete.h
//  KitchenQuest
//
//  Created by William Cremin on 12/14/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

typedef void(^AutocompleteCompletion)(BOOL success, NSArray *result);

@interface IngredientAutocomplete : NSObject

+ (void)autocompleteWithSearchTerm:(NSString *)term completion:(AutocompleteCompletion)completion;

@end
