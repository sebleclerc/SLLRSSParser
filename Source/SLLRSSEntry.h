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
- (SLLRSSEntry *)initWithTitle:(NSString *)entryTitle andLink:(NSString *)entryLink;

- (NSString *)description;

@property (nonatomic, strong) NSString *entryTitle;
@property (nonatomic, strong) NSString *entryLink;
@property (nonatomic, strong) NSString *entryCommentsLink;
@property (nonatomic, strong) NSString *entryDate;
@property (nonatomic, strong) NSString *entryAuthor;
@property (nonatomic, strong) NSString *entryExcerpt;
@property (nonatomic, strong) NSString *entryContent;

@end
