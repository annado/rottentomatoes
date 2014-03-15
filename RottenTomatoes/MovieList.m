//
//  MovieList.m
//  RottenTomatoes
//
//  Created by Anna Do on 3/15/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "MovieList.h"
#import "Movie.h"

@implementation MovieList

- (id)initWithUrl: (NSString *)url {
    self = [super init];
    
    self.url = url;
    self.list = [[NSArray alloc] init];
    
    return self;
}

- (void)load: (void (^)(void))callback
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.list = object[@"movies"];
        callback(); // TODO
    }];
}

- (int)count
{
    return [self.list count];
}

- (Movie *)get: (int)index
{
    if (index < [self count]) {
        NSDictionary *dict = [self.list objectAtIndex:index];
        return [[Movie alloc] initWithDictionary:dict];
    } else {
        return nil;
    }
}

@end
