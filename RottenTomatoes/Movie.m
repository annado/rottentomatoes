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

@end
