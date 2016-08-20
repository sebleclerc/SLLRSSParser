//
//  SLLRSSParser.h
//  SLLRSSParserDemo
//
//  Created by Sébastien Leclerc Lavallée on 2013-01-23.
//  Copyright (c) 2013 Sébastien Leclerc Lavallée. All rights reserved.
//

#import <Foundation/Foundation.h>

//Typedef callbacks
typedef void (^SLLRSSParserCompleted)(NSArray *listFeedItems);

@interface SLLRSSParser : NSObject

- (SLLRSSParser *)initWithFeedUrlString:(NSString *)feedUrlString;
- (void)parseRSSFeed:(SLLRSSParserCompleted)completeBlock;

@property (copy, nonatomic) NSString *feedUrl;

@end
