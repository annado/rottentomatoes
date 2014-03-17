//
//  MovieCell.h
//  RottenTomatoes
//
//  Created by Anna Do on 3/15/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

@interface MovieCell : UITableViewCell
//- (void)setMovie: (Movie *)movie;
@property (nonatomic, strong) Movie *movie;
@end
