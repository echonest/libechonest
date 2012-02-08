# libechonest
### An objective-c library for [The Echo Nest API](http://developer.echonest.com/docs/v4/)

## Installation

1. Get the libechonest project.
2. Compile it.
3. Include the library's headers and link to `libechonest.a`

In addition to linking to libechonest.a, your app will need to link to the following frameworks and libraries:

* AVFoundation.framework
* CFNetwork.framework
* MediaPlayer.framework
* MobileCoreServices.framework
* SystemConfiguration.framework
* libz.dylib

__NOTE__: You *must* add `-Objc` and `-all_load` to your project's "Additional Linker Flags" settings. (See [Building Objective-C static libraries with categories](http://developer.apple.com/library/mac/#qa/qa1490/_index.html) for why.)

## Usage

    #import <ENAPI.h>

    ...
    [ENAPI initWithApiKey:@"YOUR_API_KEY"];
    ENAPIRequest *request = [ENAPIRequest requestForEndpoint:@"artist/audio"];
    request.delegate = self;                              // our class implements ENAPIRequestDelegate
    [request setValue:@"Radiohead" forParameter:@"name"]; // name=Radiohead
    [request setIntegerValue:15 forParameter:@"results"]; // results=15
    [request startAsynchronous];

    ...

    - (void)requestFinished:(ENAPIRequest *)request {
        NSAssert1(200 == request.responseStatusCode, @"Expected 200 OK, Got: %d", request.responseStatusCode);
        NSArray *audio = [request.response valueForKeyPath:@"response.audio"];
    }

    ...

### Setting parameter values

Note there are typed `setValue:forParameter:` methods on `ENAPIRequest` for integers, floats, and `BOOL`s. Parameters that support multiple values are set using an `NSArray` of the values.

    ENAPIRequest *request = [ENAPIRequest requestForEndpoint:@"artist/search"];
    [request setBoolValue:YES forParameter:@"fuzzy_match"];
    [request setFloatValue:0.5f forParameter:@"min_hotttnesss"];
    [request setValue:@"radiohead" forParameter:@"name"];
    // multiple values
    NSArray *descriptions = [NSArray arrayWithObjects:@"mood:chill", @"location:london", nil];
    [request setValue:descriptions forParameter:@"description"];

Note that if a parameter supports multiple values, but if you're only using one, you can set it normally, e.g.,

    [request setValue:@"mood:chill" forParameter:@"description"];

### Accessing assets 

Access to artist sandboxes requires OAuth signing of requests. ENAPIRequest now handles OAuth signing for GET requests, like the `sandbox/access` endpoint. This support requires stating your Echo Nest API consumer key and shared secret. 

A new initializer is provided: 
    
    [ENAPI initWithApiKey:@"YOUR_API_KEY" 
              ConsumerKey:@"YOUR_CONSUMER_KEY" 
          AndSharedSecret:@"YOUR_SHARED_SECRET"];

Or, you can set the consumer key and shared secret via setters:

    [ENAPI setConsumerKey:@"YOUR_CONSUMER_KEY"];
    [ENAPI setSharedSecret:@"YOUR_SHARED_KEY"];

Note: your shared secret for your account is listed on your Echo Nest Developer Profile page. It is not a token that is acquired from an endpoint. 

Currently endpoints only require OAuth signing (so, no OAuth token is required). Only the API Key, Consumer Key, and Shared Secret are needed. 

Access to sandboxes requires that you require to the Terms of Service individually (https://developer.echonest.com/account/sandboxes).

Usage:

    #import <ENAPI.h>

    ...

    ENAPIRequest * req = [[ENAPIRequest alloc] initWithEndpoint:@"sandbox/access"];

    // Note - you must agree to the sandbox terms of service to gain 
    //        access to the individual artist sandboxes 

    [req setValue:assetId text forParameter:@"id"];	    // id={desired-asset}
    [req setValue:@"emi_gorillaz" forParameter:@"sandbox"]; // sandbox=emi_gorillaz

    req.delegate = self;	     			    // our class implements ENAPIRequestDelegate
    
    [req startAsynchronous];
