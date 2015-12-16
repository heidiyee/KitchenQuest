//
//  KitchenTableViewCell.m
//  KitchenQuest
//
//  Created by Regular User on 12/14/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import "KitchenTableViewCell.h"
#import "ImageFetcherService.h"
#import "Constants.h"
#import "Recipe.h"

@interface KitchenTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *recipeNameLabel;


@property (weak, nonatomic) IBOutlet UILabel *likesLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;



@end

@implementation KitchenTableViewCell



-(void)setRecipe:(Recipe *)recipe {
    self.recipeNameLabel.text = recipe.title;
    self.likesLabel.text = recipe.likes;
    
    //    NSLog(@"profileImageURL %@", question.owner.profileImageURL.description);
    [self.imageView setImage:@"food.png"];

    
    [ImageFetcherService fetchImageInBackgroundFromUrl:recipe.imageURL completionHandler:^(UIImage * _Nullable data, NSError * _Nullable error) {
        
        if (error) {
            
        }
        [self.imageView setImage:data];
        self.imageView.highlightedImage = recipe.imageURL;
        self.imageView.highlighted = YES;
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
