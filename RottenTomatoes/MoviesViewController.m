//
//  MoviesViewController.m
//  RottenTomatoes
//
//  Created by Anna Do on 3/12/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "MoviesViewController.h"

@interface MoviesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;
@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"In Theaters Now";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
// TODO?   self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class]  forCellReuseIdentifier:@"MoviesCell"];
    [self getMovies];
}

- (void)getMovies
{
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?page_limit=50&apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

        self.movies = object[@"movies"];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewController methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MoviesCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *movie = [self.movies objectAtIndex:indexPath.row];
    cell.textLabel.text = [movie objectForKey:@"title"];

//    cell.detailTextLabel.text = [movie objectForKey:@"synopsis"];
//    NSLog(@"Row: %i", indexPath.row);
    
    return cell;
}

@end
