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

-(SLLRSSEntry *)initWithTitle:(NSString *)entryTitle andLink:(NSString *)entryLink
{
    if (self = [super init]) {
        self.entryTitle = entryTitle;
        self.entryLink = entryLink;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"SLLRSSEntry, title:%@, date:%@, author:%@, link:%@", self.entryTitle, self.entryDate, self.entryAuthor, self.entryLink];
}

@end
