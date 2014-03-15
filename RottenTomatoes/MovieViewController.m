//
//  MovieViewController.m
//  RottenTomatoes
//
//  Created by Anna Do on 3/13/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "MovieViewController.h"

@interface MovieViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) NSDictionary *movie;
@end

@implementation MovieViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//    }
//    return self;
//}

- (id)initWithMovie:(NSDictionary *)movie
{
    self.movie = movie;
    self = [super initWithNibName:@"MovieViewController" bundle:nil];
    if (self) {
        self.title = [self.movie objectForKey:@"title"];
    }
//    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.movie objectForKey:@"posters"] objectForKey:@"thumbnail"]]]]];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
