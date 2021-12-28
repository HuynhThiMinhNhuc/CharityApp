class FormatNumberK {
  static String call(int number) {
    return number > 1000 ? "${number/1000}K" : number.toString();
  }
}