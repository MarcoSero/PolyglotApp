//
// Created by Marco Sero on 20/03/15.
// Copyright (c) 2015 Marco Sero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class Contact;

@protocol ContactJSExports <JSExport>
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSURL *imageURL;
+ (instancetype)createWithFirstName:(NSString *)firstName lastName:(NSString *)lastName imageUrl:(NSString *)imageUrl;
@end

@interface Contact : NSObject <ContactJSExports>

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSURL *imageURL;

- (NSString *)fullName;

@end