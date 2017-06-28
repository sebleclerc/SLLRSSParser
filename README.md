# SLLRSSParser

SLLRSSParser is a simple RSS parser for Objective-C with ARC and blocks.

## Installation
### Cocoapods

The best and easiest method to install and use SLLRSSParser is with [CocoaPods](https://cocoapods.org). You simply add this line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```
pod 'SLLRSSParser'
```

### Manual

You need to have [TBXML](https://github.com/71squared/TBXML) copied into the solution. Copy everything from the TBXML-Code and TBXML-Headers folders.

Then, you need to copy all the SLLRSSParser files:  
* SLLRSSParser.h / .m  
* SLLRSSEntry.h / .m

## Usage
(see demo XCode project in ```/SLLRSSParserDemo```)

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