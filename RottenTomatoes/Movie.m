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

- (NSString *)posterUrl
{
    return [[self.dictionary objectForKey:@"posters"] objectForKey:@"thumbnail"];
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
