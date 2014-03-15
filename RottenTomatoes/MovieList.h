//
//  MovieList.h
//  RottenTomatoes
//
//  Created by Anna Do on 3/15/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Movie;

@interface MovieList : NSObject

@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) NSString *url;

- (id)initWithUrl: (NSString *)url;
- (void)load: (void (^)(void))callback;
- (int)count;
- (Movie *)get: (int)index;
@end
