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
#import "Model.h"

@interface KitchenTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *recipeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;



@end

@implementation KitchenTableViewCell



//-(void)setModel:(Model *)model {
//    self.recipeNameLabel.text = model.recipeName;
//    self.likesLabel.text = model.likesLabel;
//    
//    //    NSLog(@"profileImageURL %@", question.owner.profileImageURL.description);
//    [self.imageView setImage:@"food.png"];
//
//    
//    [ImageFetcherService fetchImageInBackgroundFromUrl:model.profileImageURL completionHandler:^(UIImage * _Nullable data, NSError * _Nullable error) {
//        
//        if (error) {
//            
//        }
//        [self.imageView setImage:data]
//        imageView.highlighted = imageView.image;
//        imageView.highlighted = YES;
//    }];
//    
//}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
