Swift Events
===================

Swift Events gives you the possibility to create custom events. The original repository was created by [Stephen Haney](https://github.com/StephenHaney/Swift-Custom-Events).

It's even possible to add new event listeners with a custom priority as a `UInt8`

## Getting started

The easiest way to get started with Swift Events is to use Swift PM.

### Prerequisites

To use Swift Events in your project make sure you are using at least the Swift-4.0-REALEASE-toolchain.

Because Swift Events just depends on `Foundation` you can use it anywhere, on the server-side, macOS, iOS, watchOS, tvOS...

### Installing

With Swift PM (= Package Manager):

Add the following to the dependencies of your `Package.swift`

```swift
.package( url: "https://github.com/robinwalterfit/Swift-Events.git", .upToNextMajor( from: "1.1.4" ) )
```

Then in your code place at the top of the files where you need Swift Events:

```swift
import Events
```

## Running the tests

Run the tests in Xcode.

## Deployment

Just follow the instructions of Installing and it should work.

## Built With

... :heart:

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on my code of conduct, and the process for submitting pull requests to me.

## Versioning

I use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/robinwalterfit/Swift-Events/tags).

## Authors

* Original author: **Stephen Haney** – *Initial work* – [StephenHaney](https://github.com/StephenHaney/)
* **Robin Walter** – [robinwalterfit](https://github.com/robinwalterfit)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* If you want see some examples about the usage just visit the [wiki](https://github.com/robinwalterfit/Swift-Events/wiki)
* If you have any ideas for a better `quicksort algorithm` then check out [this gist](https://gist.github.com/robinwalterfit/60a42c388d35b66cba7cf7864bc0fb98) and let's discuss about the changes.
