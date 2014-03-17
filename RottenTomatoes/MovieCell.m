//
//  MovieCell.m
//  RottenTomatoes
//
//  Created by Anna Do on 3/15/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "MovieCell.h"
#import "Movie.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation MovieCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMovie:(Movie *)movie
{
    self.movieTitleLabel.text = [movie title];
    self.summaryLabel.text = [movie synopsis];
    self.castLabel.text = [movie cast];
    [self setMoviePosterWithURL:[movie posterThumbnailURL]];

    self.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setMoviePosterWithURL:(NSURL *)url
{
    [self.moviePosterView setImageWithURLRequest:[NSURLRequest requestWithURL:url]
        placeholderImage:[UIImage imageNamed:@"placeholder-avatar"]
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
           self.moviePosterView.alpha = 0.0;
           self.moviePosterView.image = image;
           [UIView animateWithDuration:0.25
                animations:^{
                    self.moviePosterView.alpha = 1.0;
                }];
       }
       failure:NULL];
}

@end
