import 'V2.dart';
import 'SDLFont.dart';

abstract class Font {
  static Font create(String family, int size) {
    return SDLFont(family, size);
  }

  V2 TextSize(String text);
  void Destroy();
}

// Represents all sizes of a single font
class _FontFamily {
  final String family;
  final _sizes = <int, Font>{};

  _FontFamily(this.family);

  Font operator[](int size) {
    if (!_sizes.containsKey(size)) _sizes[size] = Font.create(family, size);
    return _sizes[size]!;
  }

  void Destroy() {
    for (var font in _sizes.values) {
      font.Destroy();
    }
  }
}

class Fonts {
  static final _families = <String, _FontFamily>{};

  static void Destroy() {
    for (var family in _families.values) {
      family.Destroy();
    }
    _families.clear();
  }

  _FontFamily operator[](String? familyName) {
    familyName ??= 'res/Menlo Regular.ttf';
    if (!_families.containsKey(familyName)) {
      _families[familyName] = _FontFamily(familyName);
    }
    return _families[familyName]!;
  }
}