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
@property (nonatomic, strong) UIView *alertView;
@end

@implementation MovieListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"In Theaters Now";
        _url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?page_limit=50&apikey=g9au4hv6khv6wzvzgt55gpqs";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupAlertView];
    [self setupTableView];
    [self setupPullToRefresh];
    [self setupNavigationBar];
}

- (void)setupAlertView
{
    UIView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"AlertView" owner:self options:nil] objectAtIndex:0];
    alertView.frame = CGRectMake(0,64,340,34);
    self.alertView = alertView;
    [self.view addSubview:alertView];
}

- (void)loadMovies
{
    self.alertView.hidden = true;
    MovieList *movies = [[MovieList alloc] initWithUrl:_url];
    [movies load:^(void) {
        [SVProgressHUD dismiss];
        [self.refreshControl endRefreshing];
        self.movies = movies;
        [self.tableView reloadData];
    } failure:^(void) {
        [SVProgressHUD dismiss];
        [self.refreshControl endRefreshing];
        self.alertView.hidden = false;
    }];
}

- (void)setupTableView
{
    self.tableView.rowHeight = 111;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [self loadMovies];
}

- (void)setupNavigationBar
{
    UIBarButtonItem *backButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Movies"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    
    [[self navigationItem] setBackBarButtonItem:backButton];
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
    [self loadMovies];
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

    cell.movie = [self.movies get:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    Movie *movie = [self.movies get:indexPath.row];
    MovieViewController *movieController = [[MovieViewController alloc] initWithMovie:movie];
    
    [[self navigationController] pushViewController:movieController animated:YES];
}

@end
