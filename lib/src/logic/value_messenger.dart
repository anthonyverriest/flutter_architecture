import 'package:flutter/foundation.dart';

//ADAPTED FROM CHANGENOTIFIER
class ValueMessenger {
  static final ValueMessenger _messenger = ValueMessenger._internal();

  factory ValueMessenger() {
    return _messenger;
  }

  ValueMessenger._internal();

  static final Map<Type, int> _emptyCounts = <Type, int>{};

  Map<Type, int> _counts = _emptyCounts;

  static final Map<Type, List> _emptyListeners = <Type, List>{};

  Map<Type, List> _listeners = _emptyListeners;

  final Map<Type, int> _notificationCallStackDepth = {};
  final Map<Type, int> _reentrantlyRemovedListeners = {};
  bool _debugDisposed = false;

  static bool debugAssertNotDisposed(ValueMessenger notifier) {
    assert(() {
      if (notifier._debugDisposed) {
        throw FlutterError(
          'A ${notifier.runtimeType} was used after being disposed.\n'
          'Once you have called dispose() on a ${notifier.runtimeType}, it '
          'can no longer be used.',
        );
      }
      return true;
    }());
    return true;
  }

  @protected
  bool hasListeners<Bloc>() {
    assert(ValueMessenger.debugAssertNotDisposed(this));
    // ignore: avoid_bool_literals_in_conditional_expressions
    return _counts[Bloc] == null ? false : _counts[Bloc]! > 0;
  }

  void register<Bloc, State>(void Function(State) listener) {
    assert(ValueMessenger.debugAssertNotDisposed(this));
    if (!_listeners.containsKey(Bloc)) {
      _listeners[Bloc] = List<void Function(State)?>.filled(0, null);
      _counts[Bloc] = 0;
    }

    if (_counts[Bloc] == _listeners[Bloc]!.length) {
      if (_counts[Bloc] == 0) {
        _listeners[Bloc] = List<void Function(State)?>.filled(1, null);
      } else {
        final List newListeners = List<void Function(State)?>.filled(
            _listeners[Bloc]!.length * 2, null);
        for (int i = 0; i < _counts[Bloc]!; i++) {
          newListeners[i] = _listeners[Bloc]![i];
        }
        _listeners[Bloc] = newListeners;
      }
    }
    _listeners[Bloc]![_counts[Bloc]!] = listener;
    _counts[Bloc] = _counts[Bloc]! + 1;
  }

  void _removeAt<Bloc, State>(int index) {
    _counts[Bloc] = _counts[Bloc]! - 1;
    if (_counts[Bloc]! * 2 <= _listeners.length) {
      final List<void Function(State)?> newListeners =
          List<void Function(State)?>.filled(_counts[Bloc]!, null);

      // Listeners before the index are at the same place.
      for (int i = 0; i < index; i++) {
        newListeners[i] = _listeners[Bloc]![i];
      }

      // Listeners after the index move towards the start of the list.
      for (int i = index; i < _counts[Bloc]!; i++) {
        newListeners[i] = _listeners[Bloc]![i + 1];
      }

      _listeners[Bloc] = newListeners;
    } else {
      // When there are more listeners than half the length of the list, we only
      // shift our listeners, so that we avoid to reallocate memory for the
      // whole list.
      for (int i = index; i < _counts[Bloc]!; i++) {
        _listeners[Bloc]![i] = _listeners[Bloc]![i + 1];
      }
      _listeners[Bloc]![_counts[Bloc]!] = null;
    }
  }

  void unregister<Bloc, State>(void Function(State) listener) {
    assert(_listeners.containsKey(Bloc));
    // This method is allowed to be called on disposed instances for usability
    // reasons. Due to how our frame scheduling logic between render objects and
    // overlays, it is common that the owner of this instance would be disposed a
    // frame earlier than the listeners. Allowing calls to this method after it
    // is disposed makes it easier for listeners to properly clean up.
    for (int i = 0; i < _counts[Bloc]!; i++) {
      final void Function(State)? listenerAtIndex = _listeners[Bloc]![i];
      if (listenerAtIndex == listener) {
        if (_notificationCallStackDepth[Bloc] != null &&
            _notificationCallStackDepth[Bloc]! > 0) {
          // We don't resize the list during notifyListeners iterations
          // but we set to null, the listeners we want to remove. We will
          // effectively resize the list at the end of all notifyListeners
          // iterations.
          _listeners[Bloc]![i] = null;
          _reentrantlyRemovedListeners[Bloc] =
              _reentrantlyRemovedListeners[Bloc] ?? 0 + 1;
        } else {
          // When we are outside the notifyListeners iterations we can
          // effectively shrink the list.
          _removeAt<Bloc, State>(i);
        }
        break;
      }
    }
  }

  @mustCallSuper
  void dispose() {
    assert(ValueMessenger.debugAssertNotDisposed(this));
    assert(() {
      _debugDisposed = true;
      return true;
    }());
    _listeners = _emptyListeners;
    _counts = _emptyCounts;
  }

  void send<Bloc, State>(State message) {
    assert(ValueMessenger.debugAssertNotDisposed(this));
    if (_counts[Bloc] == null) {
      return;
    }

    _notificationCallStackDepth[Bloc] =
        _notificationCallStackDepth[Bloc] ?? 0 + 1;

    final int end = _counts[Bloc]!;
    for (int i = 0; i < end; i++) {
      try {
        _listeners[Bloc]![i]?.call(message);
      } catch (exception, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: exception,
          stack: stack,
          library: 'foundation library',
          context: ErrorDescription(
              'while dispatching notifications for $runtimeType'),
          informationCollector: () => <DiagnosticsNode>[
            DiagnosticsProperty<ValueMessenger>(
              'The $runtimeType sending notification was',
              this,
              style: DiagnosticsTreeStyle.errorProperty,
            ),
          ],
        ));
      }
    }

    _notificationCallStackDepth[Bloc] = _notificationCallStackDepth[Bloc]! - 1;

    if (_notificationCallStackDepth[Bloc] == 0 &&
        _reentrantlyRemovedListeners[Bloc] != null &&
        _reentrantlyRemovedListeners[Bloc]! > 0) {
      // We really remove the listeners when all notifications are done.
      final int newLength =
          _counts[Bloc]! - _reentrantlyRemovedListeners[Bloc]!;
      if (newLength * 2 <= _listeners.length) {
        // As in _removeAt, we only shrink the list when the real number of
        // listeners is half the length of our list.
        final List<void Function(State)?> newListeners =
            List<void Function(State)?>.filled(newLength, null);

        int newIndex = 0;
        for (int i = 0; i < _counts[Bloc]!; i++) {
          final void Function(State)? listener = _listeners[Bloc]![i];
          if (listener != null) {
            newListeners[newIndex++] = listener;
          }
        }

        _listeners[Bloc] = newListeners;
      } else {
        // Otherwise we put all the null references at the end.
        for (int i = 0; i < newLength; i += 1) {
          if (_listeners[Bloc]![i] == null) {
            // We swap this item with the next not null item.
            int swapIndex = i + 1;
            while (_listeners[Bloc]![swapIndex] == null) {
              swapIndex += 1;
            }
            _listeners[Bloc]![i] = _listeners[Bloc]![swapIndex];
            _listeners[Bloc]![swapIndex] = null;
          }
        }
      }

      _reentrantlyRemovedListeners[Bloc] = 0;
      _counts[Bloc] = newLength;
    }
  }
}
