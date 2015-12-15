//
//  ViewController.m
//  KitchenQuest
//
//  Created by William Cremin on 12/14/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import "ViewController.h"
#import "Recipe.h"
#import "IngredientAutocomplete.h"
#import "RecipeInformation.h"
#import "User.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TEST FETCH RECIPE FROM API + SAVE TO CORE DATA
//    [Recipe fetchRecipesWithSearchTerms:@"eggs,bread,cinnamon" completion:^(BOOL success, NSArray *result) {
//        if (success) {
//            for (Recipe *recipe in result) {
//                [User addSavedRecipesObject:recipe];
////                NSLog(@"%@", recipe.title);
//            }
//        } else {
//            NSLog(@"Error");
//        }
//    }];
    
    // TEST FETCH + DELETE OBJECTS FROM CORE DATA
//    NSManagedObjectContext *context = [[CoreDataStack sharedStack]managedObjectContext];
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipe" inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSError *error;
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    if (fetchedObjects == nil) {
//        NSLog(@"Nada");
//    } else {
//        for (Recipe *recipe in fetchedObjects) {
//            NSLog(@"%@", recipe.title);
//        }
//    }

    // TEST AUTOCOMPLETE FROM API FOR SEARCH
//    [IngredientAutocomplete autocompleteWithSearchTerm:@"tof" completion:^(BOOL success, NSArray *result) {
//        if (success) {
//            for (NSString *word in result) {
//                NSLog(@"%@", word);
//            }
//        } else {
//            NSLog(@"Error");
//        }
//    }];

    // TEST GET RECIPE INFO FROM API
//    [RecipeInformation getRecipeURLWithID:@"156991" completion:^(BOOL success, NSString *result) {
//        if (success) {
//            NSLog(@"%@", result);
//        } else {
//            NSLog(@"Error");
//        }
//    }];
//    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
