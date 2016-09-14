//
//  SLLRSSEntry.m
//  SLLRSSParserDemo
//
//  Created by Sébastien Leclerc Lavallée on 16-08-17.
//  Copyright © 2016 SLL. All rights reserved.
//

#import "SLLRSSEntry.h"

@implementation SLLRSSEntry

-(SLLRSSEntry *)init
{
    self = [super init];
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"SLLRSSEntry, title:%@, date:%@, author:%@, link:%@, imageUrL:%@", self.title, self.date, self.author, self.link, self.imageUrl];
}

@end
