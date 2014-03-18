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
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;
@property (strong, nonatomic) Movie *movie;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIView *alertView;
@end

@implementation MovieViewController

- (id)initWithMovie:(Movie *)movie
{
    self = [super initWithNibName:@"MovieViewController" bundle:nil];
    if (self) {
        self.movie = movie;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [self.movie title];
    [self setImage];
    self.synopsisLabel.text = [self.movie synopsis];
    self.castLabel.text = [self.movie cast];
    [self setupAlertView];
    self.activityIndicator.hidesWhenStopped = true;
}

- (void)setupAlertView
{
    UIView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"AlertView" owner:self options:nil] objectAtIndex:0];
    alertView.frame = CGRectMake(0,64,340,34);
    alertView.hidden = true;
    self.alertView = alertView;
    [self.view addSubview:alertView];
}

- (void)setImage
{
    NSURL *url = [self.movie posterFullSizeURL];
    [self.activityIndicator startAnimating];
    
    [self.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:url]
        placeholderImage:[UIImage imageNamed:@"placeholder-avatar"]
                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                     self.imageView.alpha = 0.0;
                     self.imageView.image = image;
                     [UIView animateWithDuration:0.25
                                      animations:^{
                                          self.imageView.alpha = 1.0;
                                      }];
                     [self.activityIndicator stopAnimating];
                 }
                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                     [self.activityIndicator stopAnimating];
                     self.alertView.hidden = false;
                 }];
}
@end
