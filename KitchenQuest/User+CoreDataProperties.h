//
//  User+CoreDataProperties.h
//  KitchenQuest
//
//  Created by William Cremin on 12/14/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Recipe *> *savedRecipes;

@end

@interface User (CoreDataGeneratedAccessors)

+ (void)addSavedRecipesObject:(Recipe *)value;
+ (void)removeSavedRecipesObject:(Recipe *)value;
- (void)addSavedRecipes:(NSSet<Recipe *> *)values;
- (void)removeSavedRecipes:(NSSet<Recipe *> *)values;

@end

NS_ASSUME_NONNULL_END
