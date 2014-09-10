SDHTTPRequestOperation
======================

Self Authenticating Subclass of AFHTTPRequestOperation

##Usage
SDHTTPRequestOperation is a subclass of AFHTTPRequestOperation, it allows you to specify an AFOAuthCredential and the oAuth URL and have the request perform the authentication loop before completing the request

# you need to overwrite the kClientID and kSecretCode constants in the SDHTTPRequestOperation.m

##Example
    
    // CREATE THE REQUEST
    NSMutableURLRequest *request = [NSURL URLWithString:@"http://example.com"];
    SDHTTPRequestOperation *requestOperation = [[SDHTTPRequestOperation alloc] initWithRequest:request];

    // SET THE OAUTH CREDENTIALS
    AFOAuthCredential *cred = [AFOAuthCredential retrieveCredentialWithIdentifier:@"GETMYCREDENTIALS!!!"];
    [requestOperation setOAuthCredential:cred];
    
    // SET THE OAUTH URL
    NSString *oAuthURLString = @"oAuthURLString";
    
    // ADD THE REQUEST OPERATION TO THE QUEUE
    [[NSOperationQueue new] addOperation:requestOperation];
```
