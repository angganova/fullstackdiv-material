/// Zest Global rest call state to indicate the rest call of the taxi
enum ApiCallState {
  /// Initial state
  stateEmpty,

  /// Requesting state
  stateRequesting,

  /// Retry state
  stateRetrying,

  /// Result response confirmed
  stateResulted,

  /// Error state from server
  stateErrorServer,

  /// Error state from internet
  stateErrorInternet
}
