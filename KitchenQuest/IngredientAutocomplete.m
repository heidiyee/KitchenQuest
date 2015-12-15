//
//  IngredientAutocomplete.m
//  KitchenQuest
//
//  Created by William Cremin on 12/14/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import "IngredientAutocomplete.h"
#import "Recipe.h"

NSString *autocompleteEndpointURL = @"https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/food/ingredients/autocomplete";

@implementation IngredientAutocomplete

+ (void)autocompleteWithSearchTerm:(NSString *)term completion:(AutocompleteCompletion)completion {
    NSString *urlString = [NSString stringWithFormat:@"%@?query=%@", autocompleteEndpointURL, term];
    NSURL *urlForRequest = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlForRequest];
    [request addValue: [NSString stringWithFormat:@"%@", [Constants apiKey]] forHTTPHeaderField:@"X-Mashape-Key"];
    [[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *searchTerms = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSMutableArray *searchTermsToDisplay = [[NSMutableArray alloc]init];
        for (NSDictionary *searchTerm in searchTerms) {
            NSString *name = searchTerm[@"name"];
            [searchTermsToDisplay addObject:name];
        }
        if (!error) {
            completion(true, searchTermsToDisplay);
        } else {
            NSLog(@"%@", error);
        }

    }] resume];
}

@end
