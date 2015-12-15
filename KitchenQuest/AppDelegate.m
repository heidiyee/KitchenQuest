//
//  AppDelegate.m
//  KitchenQuest
//
//  Created by William Cremin on 12/14/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreDataStack.h"
#import "Recipe.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self bootstrap];
//    NSManagedObjectContext *context = [[CoreDataStack sharedStack]managedObjectContext];
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recipe"];
//    NSError *fetchError;
//    NSArray *fetchResults = [context executeFetchRequest:request error:&fetchError];
//    for (Recipe *recipe in fetchResults) {
//        NSLog(@"%@", recipe.title);
//    }
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[CoreDataStack sharedStack] saveContext];
}

- (void)bootstrap {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recipe"];
    NSError *error;
    NSInteger count = [[[CoreDataStack sharedStack]managedObjectContext]countForFetchRequest:request error:&error];
    if (count == 0) {
        NSString *jsonPath = [[NSBundle mainBundle]pathForResource:@"testData" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        NSError *jsonError;
        NSArray *recipes = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
        if (jsonError) { NSLog(@"JSON error"); return; }
        for (NSDictionary *recipe in recipes) {
        Recipe *newRecipe = [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:[[CoreDataStack sharedStack]managedObjectContext]];
            newRecipe.title = recipe[@"title"];
            newRecipe.idNumber = recipe[@"id"];
            newRecipe.imageURL = recipe[@"image"];
            newRecipe.usedIngredientCount = recipe[@"usedIngredientCount"];
            newRecipe.missedIngredientCount = recipe[@"missedIngredientCount"];
            newRecipe.likes = recipe[@"likes"];
        }
        NSError *saveError;
        BOOL isSaved = [[[CoreDataStack sharedStack]managedObjectContext] save:&saveError];
        if (isSaved) {
            NSLog(@"Saved");
        } else {
            NSLog(@"%@", saveError.localizedDescription);
        }
    }
}

@end
