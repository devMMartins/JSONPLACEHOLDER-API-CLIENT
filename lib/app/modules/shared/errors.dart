class PostError extends Error {
  final int code;

  PostError(this.code);
}