//
//  MoviesViewController.m
//  RottenTomatoes
//
//  Created by Anna Do on 3/12/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieViewController.h"
#import "MovieList.h"
#import "Movie.h"

@interface MovieListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MovieList *movies;
@end

@implementation MovieListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"In Theaters Now";
        self.movies = [[MovieList alloc] initWithUrl:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?page_limit=50&apikey=g9au4hv6khv6wzvzgt55gpqs"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class]  forCellReuseIdentifier:@"MoviesCell"];
    [self.movies load:^(void) {
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
    
    NSLog(@"indexPath.row = %i",indexPath.row);
    Movie *movie = [self.movies get:indexPath.row];
    cell.textLabel.text = [movie title];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRow: %i", indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    Movie *movie = [self.movies get:indexPath.row];
    MovieViewController *movieController = [[MovieViewController alloc] initWithMovie:movie];
    [[self navigationController] pushViewController:movieController animated:YES];
}

@end
