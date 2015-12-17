//
//  SavedRecipesViewController.m
//  KitchenQuest
//
//  Created by William Cremin on 12/15/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import "SavedRecipesViewController.h"
#import "User.h"
#import "Recipe.h"
#import "KitchenTableViewCell.h"
#import "RecipeInformation.h"
#import "RecipeWebViewController.h"

@interface SavedRecipesViewController () <UITableViewDataSource, UITableViewDelegate, RecipeCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *savedRecipesTableView;

@end

@implementation SavedRecipesViewController

- (void)setRecipeDataSource:(NSMutableArray *)recipeDataSource {
    _recipeDataSource = recipeDataSource;
    [self.savedRecipesTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.restorationIdentifier isEqualToString:@"SavedRecipes"]) {
        NSMutableSet *savedRecipes = [User fetchSavedRecipes];
        NSMutableArray *mutableDataSource = [NSMutableArray arrayWithArray:[savedRecipes allObjects]];
        [self setRecipeDataSource:mutableDataSource];
    }
    [self setupTableView];
}

- (void)setupTableView {
    self.savedRecipesTableView.delegate = self;
    self.savedRecipesTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"KitchenTableViewCell" bundle:nil];
    [self.savedRecipesTableView registerNib:nib forCellReuseIdentifier:@"KitchenTableViewCell"];
    self.savedRecipesTableView.rowHeight = 208.0;
    self.savedRecipesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.savedRecipesTableView.backgroundColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:0.6];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recipeDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KitchenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KitchenTableViewCell"];
    cell.delegate = self;
    cell.recipe = self.recipeDataSource[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Recipe *selectedRecipe = self.recipeDataSource[indexPath.row];
    NSString *selectedID = [NSString stringWithFormat:@"%@", selectedRecipe.idNumber];
    
    RecipeWebViewController *webViewController = [[RecipeWebViewController alloc]init];
    webViewController.recipe = selectedRecipe;
    webViewController.recipeID = selectedID;
    
    [self.navigationController pushViewController:webViewController animated:YES];
}


#pragma mark - Recipe Cell Delegate

- (void)recipeCellDidRemove:(Recipe *)recipe {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Remove saved recipe" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.recipeDataSource removeObject:recipe];
        [self.savedRecipesTableView reloadData];
        [User removeSavedRecipesObject:recipe];
    }];
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:no];
    [alert addAction:yes];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
