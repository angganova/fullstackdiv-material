import 'package:mobx/mobx.dart';

part 'rating_store.g.dart';

class RatingStore = _RatingStore with _$RatingStore;

/// this is the [Store] class to help setting up the [Rating] component
abstract class _RatingStore with Store {
  @observable
  int _rating;

  @observable
  int _ratingCount;

  @observable
  bool _enabled;

  @computed
  int get rating {
    return _rating;
  }

  @computed
  int get ratingCount {
    return _ratingCount;
  }

  @computed
  bool get enabled {
    return _enabled;
  }

  set rating(int rating) {
    _rating = rating;
  }

  set ratingCount(int ratingCount) {
    _ratingCount = ratingCount;
  }

  set enabled(bool enabled) {
    _enabled = enabled;
  }

  void clear() {
    _rating = 0;
    _ratingCount = 5;
    _enabled = true;
  }
}
