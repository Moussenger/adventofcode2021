import 'dart:async';
import 'dart:isolate';

typedef IsolateCallback<M, R> = FutureOr<R> Function(M);

const exitError = 'Isolated exit without a valid result or an error';

Future<R> compute<R, M>(IsolateCallback<M, R> callback, M message) async {
  final resultPort = ReceivePort();
  final errorPort = ReceivePort();
  final exitPort = ReceivePort();
  final isolate = await Isolate.spawn<_ComputeConfiguration<M, FutureOr<R>>>(
    _spawn,
    _ComputeConfiguration<M, R>(sendPort: resultPort.sendPort, callback: callback, message: message),
    errorsAreFatal: true,
    onError: errorPort.sendPort,
    onExit: exitPort.sendPort,
  );

  final result = Completer<R>();

  errorPort.listen((error) {
    final exception = Exception(error[0]);
    final stack = StackTrace.fromString(error[1]);

    if (result.isCompleted) {
      Zone.current.handleUncaughtError(exception, stack);
    } else {
      result.completeError(exception, stack);
    }
  });

  exitPort.listen((message) => !result.isCompleted ? result.completeError(Exception(exitError)) : null);
  resultPort.listen((message) => !result.isCompleted ? result.complete(message as R) : null);

  await result.future;
  resultPort.close();
  exitPort.close();
  errorPort.close();
  isolate.kill();
  return result.future;
}

Future<void> _spawn<M, R>(_ComputeConfiguration<M, FutureOr<R>> configuration) async {
  configuration.sendPort.send(await configuration.run());
}

class _ComputeConfiguration<M, R> {
  final SendPort sendPort;
  final M message;
  final IsolateCallback<M, R> callback;

  _ComputeConfiguration({required this.sendPort, required this.callback, required this.message});

  FutureOr<R> run() => callback(message);
}
