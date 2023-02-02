# flutter_architecture

A Flutter Example Architecture project.

No packages are used in this example hence lowering the dependencies.

## Architecture: 
**Presentation -> Logic -> Data**

Presentation
* Wrappers
* Pages
* Navigation
Logic
* Blocs
* Services
Data
* Repositories
* Providers
* Models

#### build_context

Syntactic sugar for methods that rely on the build context.

#### SPABuilder

Inherited widget that contains a SPANavigator accessible through *context.spaNavigator\<T\>* and draws the page widget.

#### SPANavigator

Holds the current page to show on screen. It will trigger the related SPABuilder when the value changes.

#### ValueBroadcastNotifier

It does the same as ValueNotifier but also calls the *send* method of the ValueMessenger when notifying the listenners.

#### ValueMessenger

Adapted from ChangeNotifier. It is a singleton that stores listeners for a given Type.

