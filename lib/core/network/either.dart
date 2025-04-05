///Handles api calls with error handling
class Either<L, R> {
  late L _l;
  late R _r;

  bool _isLeftInit = false;
  bool _isRightInit = false;

  bool _isLeft = false;

  void setLeft(L value) {
    _isLeft = true;
    _isLeftInit = true;
    _l = value;
  }

  void setRight(R value) {
    _isLeft = false;
    _isRightInit = true;
    _r = value;
  }

  L getLeft() {
    return _l;
  }

  R getRight() {
    return _r;
  }

  bool isLeft() {
    return _isLeft;
  }

  @override
  String toString() {
    if (_isLeftInit) {
      return _l.toString();
    } else if (_isRightInit) {
      return _r.toString();
    } else {
      return "";
    }
  }
}
