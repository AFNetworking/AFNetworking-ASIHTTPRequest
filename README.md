AFNetworking ASIHTTPRequest Adapter
===================================

One of the stumbling blocks for developers transitioning existing projects from [ASIHTTPRequest](https://github.com/pokeb/asi-http-request/tree) to [AFNetworking](https://github.com/afnetworking/afnetworking) is making the shift from a delegate + selector pattern to a block-based interface.

This is a way to attempt to ease that transition, by translating ASI's API and design patterns into the way AFNetworking operates.  

A `@compatibility_alias` allows you to swap out ASIHTTPRequest in favor of AFNetworking, and potentially have existing code written for ASI to work _without modification_. This could be especially useful for anyone curious about the performance implications of AFNetworking in their application, but don't want to wait until the full migration is complete to see everything work.

For now, this is limited to a only the essential methods: construction / initialization, setting the `delegate` of an operation, with the option to override the `didFinishSelector` and `didFailSelector` (`requestDidFinish:` & `requestDidFail:` by default), and starting the operation.

### Contact

[Mattt Thompson](http://github.com/mattt)  
[@mattt](https://twitter.com/mattt)

## License

AFNetworking and AFNetworking+ASIHTTPRequest are available under the MIT license. See the LICENSE file for more info.
