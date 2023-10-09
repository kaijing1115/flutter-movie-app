extension MyString on String {
  bool compareIgnoreCase(String string1) {
    if (toLowerCase() == string1.toLowerCase()) {
      return true;
    }
    return false;
  }
}
