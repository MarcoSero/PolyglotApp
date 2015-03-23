//
// Created by Marco Sero on 21/03/15.
// Copyright (c) 2015 Marco Sero. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JSONDataImporter : NSObject

- (void)loadContactsFromDisk:(void (^)(NSArray *))completion;

@end