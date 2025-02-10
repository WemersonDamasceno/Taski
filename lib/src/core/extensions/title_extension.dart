extension TitleExtension on String {
  get formatteTitle {
    if (length > 10) {
      return '${substring(0, 10)}...';
    }
    return this;
  }
}
