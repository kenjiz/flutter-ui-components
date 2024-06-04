import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(milliseconds: 300);

/// Event is droppable to ensure only one event is processed and ignore the incoming until the current event is done.
/// Debounce to avoid call spam.
///
EventTransformer<E> throttleDroppable<E>([Duration? duration]) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration ?? throttleDuration), mapper);
  };
}
