import 'package:flutter/material.dart';
import 'package:turma_02/utils/command.dart';
import 'result.dart';

class CommandBuilder<T> extends StatefulWidget {
  final Command<T> command;
  final Widget Function(Exception error)? onError;
  final Widget Function()? onRunning;
  final Widget Function(T result) child;
  const CommandBuilder({
    super.key,
    required this.command,
    required this.child,
    this.onError,
    this.onRunning,
  });

  @override
  State<CommandBuilder> createState() => _CommandBuilderState<T>();
}

class _CommandBuilderState<T> extends State<CommandBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.command,
      builder: (context, child) {
        if (widget.command.running) {
          if (widget.onRunning != null) {
            return widget.onRunning!.call();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (widget.command.error) {
          if (widget.onError != null) {
            return widget.onError!.call((widget.command.result as Error).error);
          }
          return Center(
            child: Text("Ocorreu um erro"),
          );
        }
        return widget.child(widget.command.result!.asOk.value);
      },
    );
  }
}
