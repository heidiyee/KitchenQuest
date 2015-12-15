//
//  Recipe.m
//  KitchenQuest
//
//  Created by William Cremin on 12/14/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import "Recipe.h"

NSString *recipeEndpointURL = @"https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients";

@implementation Recipe

+ (void)fetchRecipesWithSearchTerms:(NSString *)terms completion:(SearchCompletion)completion {
    NSString *urlString = [NSString stringWithFormat:@"%@?ingredients=%@", recipeEndpointURL, terms];
    NSURL *urlForRequest = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlForRequest];
    [request addValue: [NSString stringWithFormat:@"%@", [Constants apiKey]] forHTTPHeaderField:@"X-Mashape-Key"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableArray *recipeResults = [[NSMutableArray alloc]init];
        if (data) {
            NSArray *recipes = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            for (NSDictionary *recipe in recipes) {
                Recipe *newRecipe = [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:[[CoreDataStack sharedStack]managedObjectContext]];
                newRecipe.title = recipe[@"title"];
                newRecipe.idNumber = recipe[@"id"];
                newRecipe.imageURL = recipe[@"image"];
                newRecipe.usedIngredientCount = recipe[@"usedIngredientCount"];
                newRecipe.missedIngredientCount = recipe[@"missedIngredientCount"];
                newRecipe.likes = recipe[@"likes"];
                [recipeResults addObject:newRecipe];
            }
        }
        if (!error) {
            completion(true, recipeResults);
        } else {
            NSLog(@"%@", error);
        }
    }] resume];
}

@end
