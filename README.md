# JNSwapIMP

## Description

JNSwapIMP is a source code package that offers a quick and easy interface to hack into the Objective-C runtime. JNSwapIMP allows you to swap out the implementations of any method from any object that inherits from NSObject, making it very easy to redesign how a particular method functions or to hack into a sealed class and reprogram some of its functionality.

This project was inspired by [Rentzsch’s JRSwizzle](https://github.com/rentzsch/jrswizzle) project. In lieu having two objects or classes and “swizzling” their methods, JNSwapIMP swaps out implementation of the target method with a predefined function having the same signature as the target method.

## Use

To use JNSwampImp, a function with the same signature as the target method (including the hidden ‘self’ and ‘_cmd’ parameters) needs to be defined. After the function is defined, simply call: `[SomeClass jn_swapMethod:@selector(foo) withIMP:(IMP)&function error:&error];`

## Example

Let’s say that we want to swap out the implementation of NSArray’s ‘objectAtIndex:’ method to make the indices of the objects start at 1 instead of 0.

We first need to declare a global variable to hold the old implementation so that we can call it after modifying the index:

`IMP oldImp;`

Next we need to declare the function whose implementation we’ll swap in:

`id function(id self, SEL _cmd, NSUInteger index) {
	return oldImp(self, _cmd, index-1);
}`

Whenever you define a method, the ‘self’ and ‘_cmd’ are included for you. When creating a function to swap in, we need to declare these parameters ourself. We call the oldImp function which now corresponds to NSArray’s original ‘objectAtIndex:’ method so that we don’t have to redefine this method ourself.

The last step is to call our JNSwapIMP method:

`oldImp = [NSArray jn_swapMethod:@selector(objectAtIndex:) withIMP:(IMP)&function error:&error];`

And just like that, all NSArray instances and all instances that inherit from NSArray are now 1-Indexed arrays.

## Support

Please use [JNSwapIMP’s Github Issues tab](https://github.com/JNApps/jnswapimp/issues) to [file bugs or feature requests](https://github.com/JNApps/jnswapimp/issues/new).

To contribute, please fork this project, make and commit your changes, and then send me a pull request.

## License

This source code is distributed under the [MIT License](http://opensource.org/licenses/mit-license.php).

## Version History

* **v1.0:** Feb 22, 2015

	* Published to GitHub

* **v1.0pr:** Jan 7, 2015

	* Development