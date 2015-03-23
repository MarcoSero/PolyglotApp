//
// Created by Marco Sero on 20/03/15.
// Copyright (c) 2015 Marco Sero. All rights reserved.
//

#import "Contact.h"


@implementation Contact

+ (instancetype)createWithFirstName:(NSString *)firstName lastName:(NSString *)lastName imageUrl:(NSString *)imageUrl
{
    Contact *contact = [[Contact alloc] init];
    contact.firstName = firstName;
    contact.lastName = lastName;
    contact.imageURL = [NSURL URLWithString:imageUrl];
    return contact;
}

- (NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (NSString *)description
{
    return self.fullName;
}

@end