import 'package:mobx/mobx.dart';

part 'rating_store.g.dart';

class RatingStore = _RatingStore with _$RatingStore;

/// this is the [Store] class to help setting up the [Rating] component
abstract class _RatingStore with Store {
  @observable
  int rating;

  @observable
  int ratingCount;

  @observable
  bool enabled;

  void clear() {
    rating = 0;
    ratingCount = 5;
    enabled = true;
  }
}
