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
#import "IngredientCollectionViewCell.h"

@import QuartzCore;

@interface ViewController () <UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, IngredientCollectionViewCellDelegate>

@property (strong, nonatomic) NSMutableArray *ingredients;
@property (weak, nonatomic) IBOutlet UITextView *ingredientsTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *ingredientCollectionView;

@end

@implementation ViewController

- (void)setIngredients:(NSMutableArray *)ingredients {
    _ingredients = ingredients;
    [self.ingredientCollectionView reloadData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.ingredientsTextView.delegate = self;
    self.ingredientsTextView.layer.borderWidth = 1.0f;
    self.ingredientsTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    
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
    self.ingredients = [[NSMutableArray alloc]init];
    
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

- (void)textViewDidChange:(UITextView *)textView {
    if ([self.ingredientsTextView.text containsString:@" "]) {
        
        [self.ingredients addObject:[NSString stringWithFormat:@"%@",textView.text]];
        [self.ingredientCollectionView reloadData];
        
        self.ingredientsTextView.text = @"";
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
}


#pragma mark - Collection View Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.ingredients.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IngredientCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IngredientCollectionViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.ingredient = self.ingredients[indexPath.row];
    cell.contentView.backgroundColor = [UIColor colorWithRed:0.34 green:0.74 blue:0.94 alpha:1.0];
    cell.contentView.layer.cornerRadius = 15.0;
    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 3.0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return CGSizeMake(70, 50);
}


#pragma mark - Custom Cell Delegate

- (void)ingredientCollectionViewCellDidDeleteIngredient:(NSString *)ingredient {
    NSLog(@"%@", ingredient);

    [self.ingredients removeObject:ingredient];
    [self.ingredientCollectionView reloadData];

        NSLog(@"%li", self.ingredients.count);
    
}

- (IBAction)hungryButtonSelected:(UIButton *)sender {
    if (self.ingredients.count == 0) {
        NSLog(@"Add ingredients");
    } else {
        NSLog(@"send to tableview");
    }
    
}


@end
