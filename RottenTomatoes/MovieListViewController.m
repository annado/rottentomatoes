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
#import "MovieCell.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface MovieListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MovieList *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSString *url;
@end

@implementation MovieListViewController

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
    [self setupTableView];
    [self setupPullToRefresh];
}

- (void)loadMoviesFromUrlString:(NSString *)url
{
    self.movies = [[MovieList alloc] initWithUrl:url];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [self.movies load:^(void) {
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    }];
}

- (void)setupTableView
{
    self.tableView.rowHeight = 111;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    
    [self loadMoviesFromUrlString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?page_limit=50&apikey=g9au4hv6khv6wzvzgt55gpqs"];
}

- (void)setupPullToRefresh
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh)
             forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    self.refreshControl = refreshControl;
}

- (void)refresh
{
    NSLog(@"refreshing...");
    
    [self.refreshControl endRefreshing];
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
    static NSString *CellIdentifier = @"MovieCell";
    
    MovieCell *cell = (MovieCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSLog(@"Cell %i",indexPath.row);
    Movie *movie = [self.movies get:indexPath.row];
    [cell setMovie:movie];
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
