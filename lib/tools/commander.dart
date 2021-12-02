typedef Command<M, V> = void Function(M, String, V);
typedef Commands<M, V> = Map<String, Command<M, V>>;
typedef CommandConverter<V> = V Function(String);

class Commander<M, V> {
  final List<String> source;
  final M model;
  final Commands<M, V> commands;
  final CommandConverter<V> converter;

  Commander.from({required this.source, required this.model, required this.commands, required this.converter});

  M apply() {
    return source.fold(model, _resolveCommand);
  }

  M _resolveCommand(M currentState, String commandInput) {
    final commandInputParsed = commandInput.split(' ');
    final command = commandInputParsed[0];
    final parameter = commandInputParsed[1];

    commands[command]?.call(currentState, command, converter(parameter));

    return currentState;
  }
}
