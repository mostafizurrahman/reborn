


enum SecretRemoveType{
  deleteSecret, privateContact, globalContact, makeFavorite
}

enum SecretTapType{
  tapRight, tapParent, tapRightPrivate, tapParentPrivate, noSecret
}

enum ThemeType {
  dark, light, system
}

extension ThemeValueType on ThemeType {
  int get intValue {
    if (this == ThemeType.light) {
      return 0;
    }
    if (this == ThemeType.dark) {
      return 1;
    }
    return 2;
  }

  static ThemeType initType(final int value) {
    if (value == 0) {
      return ThemeType.light;
    }
    if (value == 1) {
      return ThemeType.dark;
    }
    return ThemeType.system;
  }

}