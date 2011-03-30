# libechonest
### An objective-c library for [The Echonest API](http://developer.echonest.com/docs/v4/)

## Installation

1. Get the libechonest project.
2. Compile it.
3. Include the library's headers and link to `libechonest.a`

In addition to linking libechonest.a, your app will need to link to the following frameworks and libraries:

* CFNetwork.framework
* MediaPlayer.framework
* MobileCoreServices.framework
* SystemConfiguration.framework
* libz.dylib

__NOTE__: You *must* add `-Objc` and `-load_all` to your project's "Additional Linker Flags" settings. (See [Building Objective-C static libraries with categories](http://developer.apple.com/library/mac/#qa/qa1490/_index.html) for why.)

## Usage

    #import <ENAPI.h>

    ...
    [ENAPI initWithApiKey:@"YOURAPIKEY"];
    ENAPIRequest *request = [ENAPIRequest requestForEndpoint:@"artist/audio"];
    request.delegate = self;                              // our class impelments ENAPIRequestDelegate
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

Note that if a parameter supports multiple values, but you're only using one, you can set it normally, e.g.,

    [request setValue:@"mood:chill" forParameter:@"description"];

    

