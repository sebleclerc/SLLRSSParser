//
//  SLLRSSEntry.h
//  SLLRSSParserDemo
//
//  Created by Sébastien Leclerc Lavallée on 16-08-17.
//  Copyright © 2016 SLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLLRSSEntry : NSObject

- (SLLRSSEntry *)init;

- (NSString *)description;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *excerpt;
@property (nonatomic, strong) NSString *content;

@end
