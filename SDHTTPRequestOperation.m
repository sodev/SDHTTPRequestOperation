//
//  SDHTTPRequestOperation.m
//
//  Created by Sean O'Connor on 9/09/2014.
//  Copyright (c) 2014 SODev. All rights reserved.
//

#import "SDHTTPRequestOperation.h"
static NSString * const kClientID = @"57607a138d1aff9b7fdc";
static NSString * const kSecretCode = @"0a33d1fc70bd495b459800953eb041ef8afc4e30";

@implementation SDHTTPRequestOperation
@synthesize oAuthCredential;
@synthesize oAuthURLString;
// sythesise the request property to be readwrite locally
@synthesize request = _request;

#pragma mark - Override Operation methods
- (void)start
{
    // CHECK IF CREDENTIALS ARE EXPIRED
    // if no credential is set then it will return isExpired = NO
    if ([oAuthCredential isExpired]) {
        [self refreshAccessToken];
    } else {
        [self setAccessToken];
        [super start];
    }
}

#pragma mark - OAuth Methods
- (void)refreshAccessToken
{
    // REFRESH THE ACCESS TOKEN
    AFOAuth2Client *oAuthClient = [[AFOAuth2Client alloc] initWithBaseURL:nil
                                                                 clientID:kClientID
                                                                   secret:kSecretCode];
    [oAuthClient authenticateUsingOAuthWithURLString:oAuthURLString
                                        refreshToken:[oAuthCredential refreshToken]
                                             success:^(AFOAuthCredential *credential) {
                                                 // SET AOUTH CREDENTIALS
                                                 [self setOAuthCredential:credential];
                                                 
                                                 // RESTART OPERATION
                                                 [self start];
                                             } failure:^(NSError *error) {
                                                 // FAILED, RETRY
                                                 [self refreshAccessToken];
                                             }];
    
}
- (void)setAccessToken
{
    // SET THE BEARER IN THE REQUEST
    // if no credential is set then this won't impact the request
    NSMutableURLRequest *mutableRequest = (NSMutableURLRequest *)_request;
    NSString *bearerString = [NSString stringWithFormat:@"%@ %@",[oAuthCredential tokenType], [oAuthCredential accessToken]];
    [mutableRequest setValue:bearerString forHTTPHeaderField:@"Authorization"];
    _request = mutableRequest;
}

@end
