//
//  KitchenTableViewCell.m
//  KitchenQuest
//
//  Created by Regular User on 12/14/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import "KitchenTableViewCell.h"
#import "Constants.h"
#import "Recipe.h"

@interface KitchenTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *recipeImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (strong, nonatomic) Recipe * recipe;

@end

@implementation KitchenTableViewCell

-(void)setRecipe:(Recipe *)recipe {
[Recipe fetchRecipesWithSearchTerms:@"tofu,broccoli,eggs" completion:^(NSArray *result, NSError *error) {
           if (result) {
                for (Recipe *recipe in result) {
                    self.titleLabel.text = recipe.title;
                    self.likesLabel.text = recipe.likes;
                    self.recipeImage = recipe.imageURL;
    //                NSLog(@"%@", recipe.title);
                }
           }
        if (error) {
            //            NSLog(@"%@", error);
            //
        }
    }];
 }

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    }

@end
