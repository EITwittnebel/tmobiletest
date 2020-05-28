# T-Mobile Testing Assignment

## Assumptions

I assume that the provided files of "TokenViewController" .h and .m files cannot be modified. The only difference is
that I added import files to "TokenViewController.m" so that I can define mock classes as was necessary.

## Created Objects

In order for the code to compile, I created TapestryShell, TapestryServices, Settings, and Device objects.
Since TapestryShell and TapestryServices called a shared instance, I made these singletons. For the most part, these
classes dont actually do anything, the tests manually set the data retrieved from the API call that would occur in the
function serviceCallUsingMutableRequest().

## Test cases:

I provided test cases for the following:

There are several tests for the API to deal with cases. There is a test for an API call where the provided JSON has all
data in a proper format. There are API calls for where the provided JSON is either missing a field (eg. dealerCode), or
the value is empty. There is also a test for An API call where the data is not properly formatted.

There is a test for the activity indicator, testing that it is animating during viewDidLoad and stops animating during
viewDidAppear.

I also provided a test for shouldAutorotate, and a test for supportedInterfaceOrientations, using mock booleans and
supported modes.

### Comments:

Given the provided assumptions the code could be much more testable and modular. Having the pseudo-network call in the
same file as the TokenViewController is not ideal, and separating it into a separate file would allow for easier
testing.
