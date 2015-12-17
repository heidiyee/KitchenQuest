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
    newRecipe.isSaved = YES;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSError *fetchUserError;
    NSInteger count = [context countForFetchRequest:request error:&fetchUserError];
    
    if (count == 0) {
        User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        newRecipe.user = newUser;
        [newUser.savedRecipes addObject:newRecipe];
    } else {
        NSArray *userResults = [context executeFetchRequest:request error:&fetchUserError];
        User *existingUser = userResults[0];
        
        NSMutableSet *savedRecipes = [User fetchSavedRecipes];
        for (Recipe *savedRecipe in savedRecipes) {
            if ([newRecipe.idNumber isEqualToString:savedRecipe.idNumber]) {
                return;
            }
        }
        newRecipe.user = existingUser;
        [existingUser.savedRecipes addObject:newRecipe];
    }
    
    NSError *saveError;
    [context save:&saveError];
    if (!saveError) {
        NSLog(@"%@ SAVED", newRecipe.title);
    } else {
        NSLog(@"%@", saveError);
    }
}

+ (nullable NSMutableSet *)fetchSavedRecipes {
    NSManagedObjectContext *context = [[CoreDataStack sharedStack]managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedUsers = [context executeFetchRequest:fetchRequest error:&error];
    NSArray *emptyArray = [[NSArray alloc]init];
    if ([fetchedUsers isEqualToArray:emptyArray]) {
        NSLog(@"No users found");
    } else {
        User *existingUser = fetchedUsers[0];
//        for (Recipe *recipe in existingUser.savedRecipes) {
//            NSLog(@"%@ FETCHED", recipe.title);
//        }
        return existingUser.savedRecipes;
    }
    return nil;
}

+ (void)removeSavedRecipesObject:(Recipe *)value {
    NSManagedObjectContext *context = [[CoreDataStack sharedStack]managedObjectContext];
    NSString *title = [NSString stringWithFormat:@"%@", value.title];
    [context deleteObject:value];
    
    NSError *saveError;
    [context save:&saveError];
    if (!saveError) {
        NSLog(@"%@ DELETED", title);
    } else {
        NSLog(@"%@", saveError);
    }
}


@end
