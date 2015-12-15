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
//    [Recipe fetchRecipesWithSearchTerms:@"tofu,broccoli,eggs" completion:^(NSArray *result, NSError *error) {
//        if (result) {
//            for (Recipe *recipe in result) {
////                [User addSavedRecipesObject:recipe];
//                NSLog(@"%@", recipe.title);
//            }
//        }
//        if (error) {
//            NSLog(@"%@", error);
//        }
//    }];
    
    // TEST FETCH + DELETE OBJECTS FROM CORE DATA
    
//    [User fetchSavedRecipes];

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
//            [User removeSavedRecipesObject:recipe];
//        }
//    }

    // TEST AUTOCOMPLETE FROM API FOR SEARCH
//    [IngredientAutocomplete autocompleteWithSearchTerm:@"tof" completion:^(NSArray *result, NSError *error) {
//        if (result) {
//            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//                NSString *leftButtonText = result[0];
//                if (result[1]) {
//                    NSString *centerButtonText = result[1];
//                    if (result[2]) {
//                        NSString *rightButtonText = result[2];
//                    }
//                }
//            }];
//        }
//        if (error) {
//            NSLog(@"%@", error);
//        }
//    }];

    // TEST GET RECIPE INFO FROM API
//    [RecipeInformation getRecipeURLWithID:@"156991" completion:^(NSString *result, NSError *error) {
//        if (result) {
//            NSLog(@"%@", result);
//        }
//        if (error) {
//            NSLog(@"%@", error);
//        }
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
