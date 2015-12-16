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

@interface SavedRecipesViewController () <UITableViewDataSource, UITableViewDelegate, RecipeCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *savedRecipesTableView;
@property (strong, nonatomic) NSMutableArray *recipeDataSource;
@property (strong, nonatomic) Recipe *recipe;

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
    NSMutableSet *savedRecipes = [User fetchSavedRecipes];
    NSMutableArray *mutableDataSource = [NSMutableArray arrayWithArray:[savedRecipes allObjects]];
    [self setRecipeDataSource:mutableDataSource];
    [self setupTableView];
}

- (void)setupTableView {
    self.savedRecipesTableView.delegate = self;
    self.savedRecipesTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"KitchenTableViewCell" bundle:nil];
    [self.savedRecipesTableView registerNib:nib forCellReuseIdentifier:@"KitchenTableViewCell"];
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
