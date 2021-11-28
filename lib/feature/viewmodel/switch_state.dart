class SwitchState {
  final String title;
  bool value;
  SwitchState({
    required this.title,
    required this.value,
  });

  bool setBool(bool value) {
    this.value=value;
    return !value;
  }
}
