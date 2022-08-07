class CustomError {
  final String code;
  final String message;
  final String plugin;

  @override
  List<Object> get props => [code, message, plugin];

  @override
  String toString() {
    return 'CustomError{code: $code, message: $message, plugin: $plugin}';
  }

   CustomError({
     this.code = '',
     this.message = '',
     this.plugin = '',
  });
}