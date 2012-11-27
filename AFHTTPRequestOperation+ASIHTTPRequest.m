// AFHTTPRequestOperation+ASI.m
// 
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFHTTPRequestOperation+ASIHTTPRequest.h"

@implementation AFHTTPRequestOperation (ASIHTTPRequest)

- (id)initWithURL:(NSURL *)URL {
    self = [self initWithRequest:[NSURLRequest requestWithURL:URL]];
    if (!self) {
        return nil;
    }
    
    return self;
}

+ (AFHTTPRequestOperation *)requestWithURL:(NSURL *)URL {
    return [[self alloc] initWithURL:URL];
}

- (void)setDelegate:(id <ASIHTTPRequestDelegate>)delegate {
    [self setCompletionBlockWithDelegate:delegate];
}

- (void)startSynchronous {
    NSLog(@"[Warning]: %@ %@ makes a synchronous network request. It is strongly recommended that all networking is done asynchronously, by setting a callback and either calling -start or adding the operation to an NSOperationQueue.", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    [self start];
    [self waitUntilFinished];
}

- (void)startAsynchronous {
    [self start];
}

#pragma mark -

- (void)setCompletionBlockWithDelegate:(id <ASIHTTPRequestDelegate>)delegate {
    [self setCompletionBlockWithDelegate:delegate didFinishSelector:@selector(requestFinished:) didFailSelector:@selector(requestFailed:)];
}

- (void)setCompletionBlockWithDelegate:(id <ASIHTTPRequestDelegate>)delegate
                     didFinishSelector:(SEL)didFinishSelector
                       didFailSelector:(SEL)didFailSelector
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    __weak id <NSObject, ASIHTTPRequestDelegate> weakDelegate = (id <NSObject, ASIHTTPRequestDelegate>)delegate;
    [self setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([weakDelegate respondsToSelector:didFinishSelector]) {
            [weakDelegate performSelector:didFinishSelector withObject:operation];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([weakDelegate respondsToSelector:didFailSelector]) {
            [weakDelegate performSelector:didFailSelector withObject:operation];
        }
    }];
#pragma clan diagnostic pop
}

@end
