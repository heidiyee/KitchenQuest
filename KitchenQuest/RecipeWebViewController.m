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
            [User removeSavedRecipesObject:self.recipe];
//            [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"barButtonHeart.png"]];
            self.navigationItem.rightBarButtonItem = nil;
        }];
        UIAlertAction *no = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:no];
        [alert addAction:yes];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [User addSavedRecipesObject:self.recipe];
        [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"barButtonHeartFill.png"]];
    }
}

@end
