//
//  Movie.m
//  RottenTomatoes
//
//  Created by Anna Do on 3/15/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary: (NSDictionary *)dictionary
{
    self = [super init];
    self.dictionary = dictionary;
    return self;
}

- (NSString *)title
{
    return [self.dictionary objectForKey:@"title"];
}

- (NSURL *)posterThumbnailURL
{
    NSString *url = [[self.dictionary objectForKey:@"posters"] objectForKey:@"thumbnail"];
    return [NSURL URLWithString:url];
}

- (NSURL *)posterFullSizeURL
{
    NSString *url = [[self.dictionary objectForKey:@"posters"] objectForKey:@"original"];
    return [NSURL URLWithString:url];
}

- (NSString *)synopsis
{
    return [self.dictionary objectForKey:@"synopsis"];
}

- (NSString *)cast
{
    NSMutableArray *actorArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *cast in [self.dictionary objectForKey:@"abridged_cast"]) {
        [actorArray addObject:[cast objectForKey:@"name"]];
    }
    return [actorArray componentsJoinedByString:@", "];
}

@end
