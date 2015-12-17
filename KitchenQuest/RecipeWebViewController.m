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
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"barButtonHeartFill.png" ] style:UIBarButtonItemStylePlain target:self action:@selector(saveRecipe:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)saveRecipe:(UIBarButtonItem *)sender {
    if (self.recipe.isSaved) {
        [User removeSavedRecipesObject:self.recipe];
        [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"barButtonHeart.png"]];
    } else {
        [User addSavedRecipesObject:self.recipe];
        [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"barButtonHeartFill.png"]];
    }
}

@end
