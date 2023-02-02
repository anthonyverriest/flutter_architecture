# flutter_architecture

A Flutter Example Architecture project.

No packages are used in this example hence lowering the dependencies.

## Architecture: 
**Presentation -> Logic -> Data**

#### build_context

Syntactic sugar for methods that relies on the build context.

#### SPABuilder

Inherited widget that contains a SPANavigator accessible through context.spaNavigator<T>.

#### SPANavigator

Holds the current SPA page to show on screen. It will trigger an SPABuilder when the value changes.

#### ValueBroadcastNotifier

It does the same as ValueNotifier but also calls the *send* method of the ValueMessenger when notifying the listenners.

#### ValueMessenger

Adapted from ChangeNotifier. It is a singleton that stores listeners for a given Type.

