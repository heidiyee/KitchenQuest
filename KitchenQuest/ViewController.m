//
//  ViewController.m
//  KitchenQuest
//
//  Created by William Cremin on 12/14/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import "ViewController.h"

@import QuartzCore;

@interface ViewController () <UITextViewDelegate>

@property (strong, nonatomic) NSMutableArray *ingredients;
@property (weak, nonatomic) IBOutlet UITextView *ingredientsTextView;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat constrainstHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ingredientsTextView.delegate = self;
    self.ingredientsTextView.layer.borderWidth = 1.0f;
    self.ingredientsTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.ingredientsTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.height = 30;
    self.constrainstHeight = 60;


}

- (UIButton *)createButtonWithText:(NSString *)ingredient {
    
    NSString *testString = ingredient;
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc]init];
    CGRect rect = [testString boundingRectWithSize:CGSizeMake(100.0, 100.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:context];
    
    NSLog(@"%@", NSStringFromCGRect(rect));
    UIButton *ingredientButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width + 5, self.height, rect.size.width + 50, 15.0)];
    ingredientButton.layer.cornerRadius = 8.0;
    
    if (self.width + 150 > [UIScreen mainScreen].bounds.size.width) {
        self.width = 0;
        self.height += 20;
        self.constrainstHeight += 20;
        self.textViewHeightConstraint.constant = self.constrainstHeight;
    } else {
        self.width += rect.size.width + 55;
    }

    [ingredientButton setTitle:[NSString stringWithFormat:@"%@ x", ingredient] forState:UIControlStateNormal];
    ingredientButton.titleLabel.textColor = [UIColor whiteColor];
    ingredientButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    ingredientButton.backgroundColor = [UIColor colorWithRed:0.34 green:0.74 blue:0.94 alpha:0.8];

    return ingredientButton;
}

- (void)textViewDidChange:(UITextView *)textView {
    if ([self.ingredientsTextView.text containsString:@" "]) {
        UIButton *button = [self createButtonWithText:self.ingredientsTextView.text];
        [self.ingredientsTextView.textInputView addSubview:button];
        self.ingredientsTextView.text = @"";
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
}

//-(void)textFieldDidBeginEditing:(UITextField *)textFiellld {
//    if ([textField.text containsString:@" "]) {
//        UIButton *button = [self createButtonWithText:textField.text];
//        [textField addSubview:button];
//    }
//}


@end
