//
//  RecipeResultsViewController.m
//  KitchenQuest
//
//  Created by William Cremin on 12/15/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import "RecipeResultsViewController.h"
#import "Recipe.h"
#import "KitchenTableViewCell.h"

@interface RecipeResultsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray<Recipe*> * Recipes;

@end

@implementation RecipeResultsViewController

- (void) setRecipes:(NSArray *)Recipes{
    _Recipes = Recipes;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource: self];
    
//    [self fetchResultsForSearchTearm:@"soy,broccoli,eggs"];
    
    UINib *nib = [UINib nibWithNibName:@"KitchenTableViewCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"KitchenTableViewCell"];
    
    NSLog(@"%li", self.recipeIngredients.count);
    NSString *joinedComponents = [_recipeIngredients componentsJoinedByString:@","];
    if ( self.recipeIngredients.count > 0)
    {
        
 [Recipe fetchRecipesWithSearchTerms:joinedComponents completion:^(NSArray *result, NSError *error) {
      if (result) {
                [self setRecipes:result];
//               NSLog(@"%@", result.title);
      }
       if (error) {
           NSLog(@"%@", error);
        }
    }];
    }
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.Recipes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KitchenTableViewCell *cell = (KitchenTableViewCell*) [self.tableView dequeueReusableCellWithIdentifier:@"KitchenTableViewCell"];
    
    cell.recipe = [self.Recipes objectAtIndex:indexPath.row];
    return cell;
}


-(CGFloat)tableview:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


@end
