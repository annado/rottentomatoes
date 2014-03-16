//
//  MovieCell.m
//  RottenTomatoes
//
//  Created by Anna Do on 3/15/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "MovieCell.h"
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

- (void)setMovieTitle: (NSString *)title
{
    self.movieTitleLabel.text = title;
}

- (void)setSynopsis: (NSString *)synopsis
{
    self.summaryLabel.text = synopsis;
}

- (void)setMoviePosterWithURL:(NSString *)url
{
    [self.moviePosterView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]
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

- (void)setCast:(NSString *)cast
{
    self.castLabel.text = cast;
}

@end
