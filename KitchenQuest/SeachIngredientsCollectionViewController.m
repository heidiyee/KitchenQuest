//
//  SeachIngredientsCollectionViewController.m
//  KitchenQuest
//
//  Created by Heidi Yee on 12/15/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import "SeachIngredientsCollectionViewController.h"
#import "Recipe.h"
#import "IngredientAutocomplete.h"
#import "RecipeInformation.h"
#import "User.h"
#import "IngredientCollectionViewCell.h"
#import "SavedRecipesViewController.h"

@import QuartzCore;

NSInteger const kNumberOfColumns = 3;
NSInteger const kNumberOfRows = 5;
CGFloat const kCornerRadius = 4;
CGFloat const kButtonCornerRadius = 8.0;

@interface SeachIngredientsCollectionViewController () <UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, IngredientCollectionViewCellDelegate>

@property (strong, nonatomic) NSMutableArray *ingredients;
@property (strong, nonatomic) NSMutableArray *searchIngredients;
//@property (strong, nonatomic) NSString *ingredientsForResults;
@property (weak, nonatomic) IBOutlet UITextView *ingredientsTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *ingredientCollectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ingredientSegmentControl;
@property (weak, nonatomic) IBOutlet UIButton *imHungryButton;

@end

@implementation SeachIngredientsCollectionViewController

- (void)setIngredients:(NSMutableArray *)ingredients {
    _ingredients = ingredients;
    
    [self.ingredientCollectionView reloadData];
}

-(void)setSearchIngredients:(NSMutableArray *)searchIngredients {
    _searchIngredients = searchIngredients;
    
    [self.ingredientSegmentControl reloadInputViews];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.ingredientsTextView.delegate = self;
    self.ingredientsTextView.layer.borderWidth = 1.0f;
    self.ingredientsTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.ingredientsTextView.layer.cornerRadius = kCornerRadius;
    self.ingredients = [[NSMutableArray alloc]init];
    self.searchIngredients = [[NSMutableArray alloc]init];
    [self setupSegmentControl];
    self.ingredientSegmentControl.layer.cornerRadius = kCornerRadius;
    
//        [User fetchSavedRecipes];
    
//        NSManagedObjectContext *context = [[CoreDataStack sharedStack]managedObjectContext];
//        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
//        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipe" inManagedObjectContext:context];
//        [fetchRequest setEntity:entity];
//        NSError *error;
//        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//        if (fetchedObjects == nil) {
//            NSLog(@"Nada");
//        } else {
//            for (Recipe *recipe in fetchedObjects) {
//                [User removeSavedRecipesObject:recipe];
////                NSLog(@"%@", recipe.title);
//            }
//        }
    
    self.imHungryButton.layer.cornerRadius = kButtonCornerRadius;
    self.ingredientCollectionView.backgroundColor = [UIColor clearColor];

}


#pragma mark - text view delegate


- (void)textViewDidChange:(UITextView *)textView {
    
    //TEST AUTOCOMPLETE FROM API FOR SEARCH
//    [IngredientAutocomplete autocompleteWithSearchTerm:[NSString stringWithFormat:@"%@", textView.text] completion:^(NSArray *result, NSError *error) {
//        if (result) {
//            [self.searchIngredients removeAllObjects];
//            [self.searchIngredients addObjectsFromArray:result];
//            [self setupSegmentControl];
//        }
//        if (error) {
//            NSLog(@"%@", error);
//        }
//    }];
    
    
    
    
    
    if ([textView.text containsString:@"\n"]) {
        NSString *ingredientString = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (ingredientString.length > 1) {
            if (![self.ingredients containsObject:[NSString stringWithFormat:@"%@",ingredientString]]) {
                [self.ingredients addObject:[NSString stringWithFormat:@"%@",ingredientString]];
                [self.ingredientCollectionView reloadData];
            } else {
                NSLog(@"already have that ingredient");
            }

        }
        self.ingredientsTextView.text = @"";
        [textView resignFirstResponder];
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
    cell.contentView.layer.cornerRadius = kButtonCornerRadius;
    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat boundsWidth = self.ingredientCollectionView.frame.size.width;
    CGFloat boundsHeight = self.ingredientCollectionView.frame.size.height;
    
    CGFloat cellSizeHeight = (boundsHeight / kNumberOfRows);
    CGFloat cellSizeWidth = ((boundsWidth / kNumberOfColumns) - 2);
    
    return CGSizeMake(cellSizeWidth, cellSizeHeight);
}


#pragma mark - Custom Cell Delegate

- (void)ingredientCollectionViewCellDidDeleteIngredient:(NSString *)ingredient {
    NSLog(@"%@", ingredient);
    
    [self.ingredients removeObject:ingredient];
    [self.ingredientCollectionView reloadData];
}

- (IBAction)hungryButtonSelected:(UIButton *)sender {
    if (self.ingredients.count == 0) {
        NSLog(@"Add ingredients");
    } else {
//        NSString *joinedComponents = [self.ingredients componentsJoinedByString:@","];
//        NSString *lowercaseJoined = [joinedComponents lowercaseString];
//        self.ingredientsForResults = [lowercaseJoined stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    }
    
}


#pragma mark - segment control

- (void)setupSegmentControl {
    NSInteger indexPath = 0;
    [self.ingredientSegmentControl setTitle:@"" forSegmentAtIndex:0];
    [self.ingredientSegmentControl setTitle:@"" forSegmentAtIndex:1];
    [self.ingredientSegmentControl setTitle:@"" forSegmentAtIndex:2];
    
    if (self.searchIngredients.count > 0) {
        for (NSString *ingredient in self.searchIngredients) {
            [self.ingredientSegmentControl setTitle:ingredient forSegmentAtIndex:indexPath];
            indexPath ++;
        }
    } 
}

- (IBAction)ingredientSegmentControlSelected:(UISegmentedControl *)sender {
    NSString *name = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    if (name.length > 0) {
        if (![self.ingredients containsObject:[NSString stringWithFormat:@"%@",name]]) {
            [self.ingredients addObject:[NSString stringWithFormat:@"%@",name]];
            [self.ingredientCollectionView reloadData];
        } else {
            NSLog(@"already have that ingredient");
        }

    }
}


#pragma mark - segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"RecipeResults"]) {
        if ([sender isKindOfClass:[UIButton class]]) {
            SavedRecipesViewController *recipeResultsVC = (SavedRecipesViewController *)segue.destinationViewController;
            
//            NSMutableArray *recipeResults = [[NSMutableArray alloc]init];
            recipeResultsVC.recipeIngredients = self.ingredients;

        }
    }
}


@end
