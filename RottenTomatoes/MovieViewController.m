//
//  MovieViewController.m
//  RottenTomatoes
//
//  Created by Anna Do on 3/13/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "MovieViewController.h"
#import "Movie.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MovieViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextView *castTextView;
@property (strong, nonatomic) Movie *movie;
@end

@implementation MovieViewController

- (id)initWithMovie:(Movie *)movie
{
    self = [super initWithNibName:@"MovieViewController" bundle:nil];
    if (self) {
        NSLog(@"MovieViewController init");

        self.movie = movie;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [self.movie title];
    [self setPosterImage];
    [self setSummary];
    self.castTextView.text = [self.movie cast];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSummary
{
    self.descriptionTextView.text = [self.movie synopsis];
}

- (void)setPosterImage
{
    NSLog(@"setPosterImage");
//    [self.imageView setImageWithURL:[self.movie posterDetailURL]];
    
    
    [self.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[self.movie posterDetailURL]]
                                placeholderImage:[UIImage imageNamed:@"placeholder-avatar"]
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                             self.imageView.alpha = 0.0;
                                             self.imageView.image = image;
                                             [UIView animateWithDuration:0.25
                                                              animations:^{
                                                                  self.imageView.alpha = 1.0;
                                                              }];
                                         }
                                         failure:NULL];

}

@end
