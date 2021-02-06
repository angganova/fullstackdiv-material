/// Zest global widget State to indicate the lifecycle of the widget
enum AppWidgetState {
  /// This is to check the state of the widget Lifecycle
  /// Useful to check your widget lifecycle from view model

  /// Initial state
  /// This indicate that the widget is not initiated
  stateEmpty,

  /// Mandatory
  /// This indicate that the widget is initiated already with widgetInitState
  /// Example :
  /// viewModel.widgetInitState();
  stateInitiated,

  /// Optional
  /// This indicate that the widget already call postFrameCallback
  /// Example : ( Put this in the initState() function )
  /// WidgetsBinding.instance.addPostFrameCallback((_) {
  /// viewModel.widgetPostFrame(context);
  /// });
  statePostFrame,

  /// Optional
  /// This indicate that the widget is not visible in the front with
  /// widgetPause
  /// Example :
  /// viewModel.widgetPause();
  statePaused,

  /// Optional
  /// This indicate that the widget is coming back to visible in the front with
  /// widgetResume
  /// Example :
  /// viewModel.widgetResume();
  stateResumed,

  /// Mandatory
  /// This indicate that the widget is already disposed and removed from the
  /// widget tree with widgetDispose
  /// Example : ( Put this in the dispose() function )
  /// viewModel.widgetDispose();
  stateDisposed
}
