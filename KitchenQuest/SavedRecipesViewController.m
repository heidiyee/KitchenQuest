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

@interface SavedRecipesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *savedRecipesTableView;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation SavedRecipesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSMutableSet *savedRecipes = [User fetchSavedRecipes];
    [self setDataSource:[savedRecipes allObjects]];
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
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KitchenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KitchenTableViewCell"];
    
    cell.recipe = self.dataSource[indexPath.row];
    
    return cell;
}

@end
