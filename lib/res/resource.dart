sealed class Resource<T> {
  const Resource({
    this.data,
    this.message,
    this.errors,
  });

  factory Resource.success(T data) = ResourceSuccess<T>;
  factory Resource.error(
    String message, [
    T? data,
    Map<String, dynamic>? errors,
  ]) = ResourceError<T>;
  factory Resource.loading([T? data]) = Loading<T>;

  final T? data;
  final String? message;
  final Map<String, dynamic>? errors;
}

class ResourceSuccess<T> extends Resource<T> {
  const ResourceSuccess(T data) : super(data: data);
}

class ResourceError<T> extends Resource<T> {
  const ResourceError(String message, [T? data, Map<String, dynamic>? erros])
      : super(data: data, message: message, errors: erros);
}

class Loading<T> extends Resource<T> {
  const Loading([T? data]) : super(data: data);
}
