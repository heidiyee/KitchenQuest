//
//  RecipeWebViewController.m
//  KitchenQuest
//
//  Created by William Cremin on 12/14/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import "RecipeWebViewController.h"
#import "User.h"
@import WebKit;
#import "RecipeInformation.h"

@interface RecipeWebViewController () <WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation RecipeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setupWebView];
    [self fetchRecipeID];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray *savedRecipes = [User fetchSavedRecipes];
    for (Recipe *savedRecipe in savedRecipes) {
        if ([self.recipe.idNumber isEqualToString:savedRecipe.idNumber]) {
            self.recipe.isSaved = YES;
        } else {
            self.recipe.isSaved = NO;
        }
    }
}

- (void)setupWebView {
    self.webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    self.webView.navigationDelegate = self;
}

- (void)fetchRecipeID {
    [RecipeInformation getRecipeURLWithID:self.recipeID completion:^(NSString * _Nullable result, NSError * _Nullable error) {
        if (result) {
            NSURL *url = [NSURL URLWithString:result];
            [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        }
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)setupNavBar {
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]init];
    [saveButton setStyle:UIBarButtonItemStylePlain];
    [saveButton setTarget:self];
    [saveButton setAction:@selector(saveRecipe:)];
    if (self.recipe.isSaved) {
        [saveButton setImage:[UIImage imageNamed:@"barButtonHeartFill.png"]];
    } else {
        [saveButton setImage:[UIImage imageNamed:@"barButtonHeart.png"]];
    }
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
}

- (void)saveRecipe:(UIBarButtonItem *)sender {
    if (self.recipe.isSaved) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Remove saved recipe" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *yes = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [self.recipe setIsSaved:NO];
            [[[CoreDataStack sharedStack]managedObjectContext]save:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *no = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:no];
        [alert addAction:yes];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [self.recipe setIsSaved:YES];
        [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"barButtonHeartFill.png"]];
    }
}

@end
