//
//  SLLRSSParser.m
//  SLLRSSParserDemo
//
//  Created by Sébastien Leclerc Lavallée on 2013-01-23.
//  Copyright (c) 2013 Sébastien Leclerc Lavallée. All rights reserved.
//

#import "SLLRSSParser.h"
#import "SLLRSSEntry.h"
#import "TBXML+HTTP.h"
#import <UIKit/UIKit.h>

@interface NSString (HTMLChars)

- (NSString *)stringByRemovingHTMLChars;

@end

@implementation NSString (HTMLChars)

- (NSString *)stringByRemovingHTMLChars {
    NSMutableString *mutableCopy = [self mutableCopy];

    [mutableCopy replaceOccurrencesOfString:@"&#39;" withString:@"'" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableCopy length])];
    [mutableCopy replaceOccurrencesOfString:@"&amp;" withString:@"&" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableCopy length])];
    [mutableCopy replaceOccurrencesOfString:@"&lt;" withString:@"<" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableCopy length])];
    [mutableCopy replaceOccurrencesOfString:@"&gt;" withString:@">" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableCopy length])];
    [mutableCopy replaceOccurrencesOfString:@"&#64;" withString:@"@" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutableCopy length])];
    
    return mutableCopy;
}

@end

@interface SLLRSSParser(){
    NSArray *feedItems;
}

@end

@implementation SLLRSSParser

- (SLLRSSParser *)initWithFeedUrlString:(NSString *)feedUrlString
{
    if(self = [super init])
    {
        self.feedUrl = feedUrlString;
    }
    
    return self;
}

- (void)parseRSSFeed:(SLLRSSParserCompleted)completeBlock
{
    TBXMLSuccessBlock successBlock = ^(TBXML *tbxmlDocument) {
        // If TBXML found a root node, process element and iterate all children
        if (tbxmlDocument.rootXMLElement->firstChild) {
            [self parseRSSItems:tbxmlDocument.rootXMLElement->firstChild];
            completeBlock(feedItems);
        }
    };
    
    // Create a failure block that gets called if something goes wrong
    TBXMLFailureBlock failureBlock = ^(TBXML *tbxmlDocument, NSError * error) {
        NSLog(@"Error! %@ %@", [error localizedDescription], [error userInfo]);
    };
    
    // Initialize TBXML with the URL of an XML doc. TBXML asynchronously loads and parses the file.
    TBXML *tbxml = [[TBXML alloc] initWithURL:[NSURL URLWithString:self.feedUrl]
                                      success:successBlock
                                      failure:failureBlock];
}

- (void) parseRSSItems:(TBXMLElement *)channelElement {
    NSMutableArray *rssEntries = [[NSMutableArray alloc] init];
    
    if (channelElement->firstChild) {
        TBXMLElement *currentItemElement = channelElement->firstChild;
        
        // Traverse all item elements
        do {
            if ([[TBXML elementName:currentItemElement] isEqualToString:@"item"]) {
                SLLRSSEntry *currentEntry = [[SLLRSSEntry alloc] init];
            
                currentEntry.title = [[TBXML textForElement:[TBXML childElementNamed:@"title" parentElement:currentItemElement]] stringByRemovingHTMLChars];
                currentEntry.link = [TBXML textForElement:[TBXML childElementNamed:@"link" parentElement:currentItemElement]];
                currentEntry.date = [TBXML textForElement:[TBXML childElementNamed:@"pubDate" parentElement:currentItemElement]];
                currentEntry.excerpt = [TBXML textForElement:[TBXML childElementNamed:@"description" parentElement:currentItemElement]];
                
                if ([TBXML childElementNamed:@"content:encoded" parentElement:currentItemElement]) {
                    currentEntry.content = [TBXML textForElement:[TBXML childElementNamed:@"content:encoded" parentElement:currentItemElement]];
                }
                
                TBXMLElement *imageElement = [TBXML childElementNamed:@"media:content" parentElement:currentItemElement];

                if (imageElement) {
                    currentEntry.imageUrl = [TBXML valueOfAttributeNamed:@"url" forElement:imageElement];
                }
                
                //Add current entry to list
                [rssEntries addObject:currentEntry];
            }//fi element is item
            
            // Obtain next sibling element
        } while ((currentItemElement = currentItemElement->nextSibling));
    }

    feedItems = rssEntries;
}

@end
