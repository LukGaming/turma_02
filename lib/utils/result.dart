sealed class Result<T> {
  const Result();
  factory Result.ok(T value) = Ok._;
  factory Result.error(Exception error) = Error._;
}

class Ok<T> extends Result<T> {
  final T value;

  const Ok._(this.value);
}

class Error<T> extends Result<T> {
  final Exception error;
  const Error._(this.error);
}

extension ResultExtension<T> on Result<T> {
  Ok<T> get asOk => this as Ok<T>;
}
