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

@interface RecipeWebViewController () <WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation RecipeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebView];
    [self setupNavBar];
}

- (void)setupWebView {
    self.webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    self.webView.navigationDelegate = self;
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)setupNavBar {
    self.navigationController.navigationBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveRecipe:)];
}

- (void)saveRecipe:(UIBarButtonItem *)sender {
//    if (self.recipe.saved) {
//        [User removeSavedRecipesObject:self.recipe];
//    } else {
//        [User addSavedRecipesObject:self.recipe];
//    }
}

@end
