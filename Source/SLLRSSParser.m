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
            
                currentEntry.title = [TBXML textForElement:[TBXML childElementNamed:@"title" parentElement:currentItemElement]];
                currentEntry.link = [TBXML textForElement:[TBXML childElementNamed:@"link" parentElement:currentItemElement]];
                currentEntry.date = [TBXML textForElement:[TBXML childElementNamed:@"pubDate" parentElement:currentItemElement]];
                currentEntry.excerpt = [TBXML textForElement:[TBXML childElementNamed:@"description" parentElement:currentItemElement]];
                currentEntry.content = [TBXML textForElement:[TBXML childElementNamed:@"content:encoded" parentElement:currentItemElement]];
                
                TBXMLElement *imageElement = [TBXML childElementNamed:@"media:content" parentElement:currentItemElement];
                currentEntry.imageUrl = [TBXML valueOfAttributeNamed:@"url" forElement:imageElement];
                
                //Add current entry to list
                [rssEntries addObject:currentEntry];
            }//fi element is item
            
            // Obtain next sibling element
        } while ((currentItemElement = currentItemElement->nextSibling));
    }

    feedItems = rssEntries;
}

@end
