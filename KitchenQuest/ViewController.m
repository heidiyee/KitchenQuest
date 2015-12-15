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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [Recipe fetchRecipesWithSearchTerms:@"eggs,bread,cinnamon" completion:^(BOOL success, NSArray *result) {
//        if (success) {
//            for (Recipe *recipe in result) {
//                NSLog(@"%@", recipe.title);
//            }
//        } else {
//            NSLog(@"Error");
//        }
//    }];
//
//    [IngredientAutocomplete autocompleteWithSearchTerm:@"tof" completion:^(BOOL success, NSArray *result) {
//        if (success) {
//            for (NSString *word in result) {
//                NSLog(@"%@", word);
//            }
//        } else {
//            NSLog(@"Error");
//        }
//    }];
//    
//    [RecipeInformation getRecipeInformationWithID:@"156991" completion:^(BOOL success, NSString *result) {
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
