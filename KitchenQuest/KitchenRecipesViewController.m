//
//  KitchenRecipesViewController.m
//  KitchenQuest
//
//  Created by William Cremin on 12/14/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import "KitchenRecipesViewController.h"

@interface KitchenRecipesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation KitchenRecipesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set up xib
    
    UINib *nib = [UINib nibWithNibName:@"KitchenTableViewCell" bundle:nil];
    
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"KitchenTableViewCell"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
