//
//  SDHTTPRequestOperation.h
//
//  Created by Sean O'Connor on 9/09/2014.
//  Copyright (c) 2014 SODev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFOAuth2Client.h"

@interface SDHTTPRequestOperation : AFHTTPRequestOperation
@property (nonatomic, strong) AFOAuthCredential *oAuthCredential;
@property (nonatomic, strong) NSString *oAuthURLString;
@property (readwrite, nonatomic, strong) NSURLRequest *request;
@end
