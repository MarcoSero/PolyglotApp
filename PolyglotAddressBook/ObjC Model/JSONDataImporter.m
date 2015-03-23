//
// Created by Marco Sero on 21/03/15.
// Copyright (c) 2015 Marco Sero. All rights reserved.
//

#import "JSONDataImporter.h"
#import "Contact.h"

@interface JSONDataImporter ()
@property (nonatomic, strong) dispatch_queue_t backgroundQueue;
@property (nonatomic, strong) JSContext *context;
@end

@implementation JSONDataImporter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _context = [[JSContext alloc] init];
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self setupBackgroundQueue];
    [self setupJavascriptLibraries];
    [self setupJavascriptClasses];
}

- (void)setupBackgroundQueue
{
    self.backgroundQueue = dispatch_queue_create("com.marcosero.PolyglotAddressBook.js_background_queue", NULL);
}

- (void)setupJavascriptLibraries
{
    [self loadJSFileInMainBundle:@"ContactsLoader"];
}

- (void)setupJavascriptClasses
{
    self.context[@"Contact"] = [Contact class];
}

- (void)loadJSFileInMainBundle:(NSString *)filename
{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:filename ofType:@"js"];
    NSString *mustacheJSString = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
    [self.context evaluateScript:mustacheJSString];
}

- (void)loadContactsFromDisk:(void (^)(NSArray *))completion
{
    dispatch_async(self.backgroundQueue, ^{
        NSString *storeFilepath = [[NSBundle mainBundle] pathForResource:@"store" ofType:@"json"];
        NSString *contactsJSON = [NSString stringWithContentsOfFile:storeFilepath encoding:NSUTF8StringEncoding error:nil];

        JSValue *load = self.context[@"loadContactsFromJSON"];
        JSValue *loadResult = [load callWithArguments:@[ contactsJSON ]];
        NSArray *contacts = [loadResult toArray];

        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(contacts);
            });
        }
    });
}

@end