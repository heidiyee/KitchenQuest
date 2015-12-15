//
//  User.m
//  KitchenQuest
//
//  Created by William Cremin on 12/14/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import "User.h"
#import "Recipe.h"

@implementation User

+ (void)addSavedRecipesObject:(Recipe *)value {
    NSManagedObjectContext *context = [[CoreDataStack sharedStack]managedObjectContext];
    Recipe *newRecipe = [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
    newRecipe.title = value.title;
    newRecipe.idNumber = value.idNumber;
    newRecipe.imageURL = value.imageURL;
    newRecipe.usedIngredientCount = value.usedIngredientCount;
    newRecipe.missedIngredientCount = value.missedIngredientCount;
    newRecipe.likes = value.likes;
    
    NSError *saveError;
    [context save:&saveError];
    if (!saveError) {
        NSLog(@"%@ SAVED", newRecipe.title);
    } else {
        NSLog(@"%@", saveError);
    }
}

+ (void)removeSavedRecipesObject:(Recipe *)value {
    NSManagedObjectContext *context = [[CoreDataStack sharedStack]managedObjectContext];
    [context deleteObject:value];
    
    NSError *saveError;
    [context save:&saveError];
    if (!saveError) {
        NSLog(@"OBJECT DELETED");
    } else {
        NSLog(@"%@", saveError);
    }
}


@end
