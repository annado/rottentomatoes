//
//  Movie.h
//  RottenTomatoes
//
//  Created by Anna Do on 3/15/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSDictionary *dictionary;

- (id)initWithDictionary: (NSDictionary *)dictionary;
- (NSString *)title;
- (NSURL *)posterThumbnailURL;
- (NSURL *)posterDetailURL;
- (NSString *)synopsis;
- (NSString *)cast;

@end
