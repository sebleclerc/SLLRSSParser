# SLLRSSParser

SLLRSSParser is a simple RSS parser for Objective-C with ARC and blocks.

## Installation
### Requirements

You need to have TBXML copied into the solution.

### SLLRSSParser

You need to copy both files from the SLLRSSParse folder : 
* SLLRSSParser.h / .m

## Usage
(see demo XCode project in '/SLLRSSParserDemo')

```objective-c
SLLRSSParser *parser = [[SLLRSSParser alloc] initWithFeedUrlString:@"http://www.sebleclerc.ca/feed"];
    
[parser parseRSSFeed:^(NSArray *listFeedItems){
//Do things
}];
```

## FAQ

The return block does not return on main thread, so you need to return to it before updating the UI.

## Credits

SLLRSSParser is brought to you by [Seb Leclerc](http://sebleclerc.ca). If you have feature, bug or comments, feel free to [open an issue](https://github.com/sebleclerc/SLLRSSParser/issues/new) or contact me.

Thanks to [Sam Vermette](http://samvermette.com) for his [SVProgressHUD](https://github.com/samvermette/SVProgressHUD) component in the Demo app.