import 'package:flutter/foundation.dart';
import 'package:flutter_architecture/src/logic/value_messenger.dart';

//COPIED FROM VALUENOTIFIER
class ValueBroadcastNotifier<U, T> extends ChangeNotifier
    implements ValueListenable<T> {
  final messenger = ValueMessenger();

  ValueBroadcastNotifier(this._value);

  @override
  T get value => _value;
  T _value;
  set value(T newValue) {
    if (_value == newValue) {
      return;
    }
    _value = newValue;
    notifyListeners();
    messenger.send<U, T>(newValue); //Added line
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';
}
