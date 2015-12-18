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

//+ (void)addSavedRecipesObject:(Recipe *)value {
//    
//    NSManagedObjectContext *context = [[CoreDataStack sharedStack]managedObjectContext];
//    
//    Recipe *newRecipe = [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
//    newRecipe.title = value.title;
//    newRecipe.idNumber = value.idNumber;
//    newRecipe.imageURL = value.imageURL;
//    newRecipe.usedIngredientCount = value.usedIngredientCount;
//    newRecipe.missedIngredientCount = value.missedIngredientCount;
//    newRecipe.likes = value.likes;
//    newRecipe.isSaved = YES;
//    
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
//    NSError *fetchUserError;
//    NSInteger count = [context countForFetchRequest:request error:&fetchUserError];
//    
//    if (count == 0) {
//        User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
//        newRecipe.user = newUser;
//        [newUser.savedRecipes addObject:newRecipe];
//    } else {
//        NSArray *userResults = [context executeFetchRequest:request error:&fetchUserError];
//        User *existingUser = userResults[0];
//        
//        NSMutableSet *savedRecipes = [User fetchSavedRecipes];
//        for (Recipe *savedRecipe in savedRecipes) {
//            if ([newRecipe.idNumber isEqualToString:savedRecipe.idNumber]) {
//                return;
//            }
//        }
//        newRecipe.user = existingUser;
//        [existingUser.savedRecipes addObject:newRecipe];
//    }
//    
//    NSError *saveError;
//    [context save:&saveError];
//    if (!saveError) {
//        NSLog(@"%@ SAVED", newRecipe.title);
//    } else {
//        NSLog(@"%@", saveError);
//    }
//}

+ (nullable NSArray *)fetchSavedRecipes {
    NSManagedObjectContext *context = [[CoreDataStack sharedStack]managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipe" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    BOOL savedRecipe = YES;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isSaved = %hhd", savedRecipe];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSArray *fetchedRecipes = [context executeFetchRequest:fetchRequest error:&error];
    NSArray *emptyArray = [[NSArray alloc]init];
    if ([fetchedRecipes isEqualToArray:emptyArray]) {
        NSLog(@"No recipes");
    } else {
        return fetchedRecipes;
    }
    return nil;
}

//+ (void)removeSavedRecipesObject:(Recipe *)value {
//    NSManagedObjectContext *context = [[CoreDataStack sharedStack]managedObjectContext];
//    NSString *title = [NSString stringWithFormat:@"%@", value.title];
//    [context deleteObject:value];
//    
//    NSError *saveError;
//    [context save:&saveError];
//    if (!saveError) {
//        NSLog(@"%@ DELETED", title);
//    } else {
//        NSLog(@"%@", saveError);
//    }
//    
//}


@end
