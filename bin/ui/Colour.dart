class Colour {
  final int r, g, b, a;
  const Colour(this.r, this.g, this.b, [this.a = 255]);

  static const red   = Colour(255, 0, 0);
  static const green = Colour(0, 255, 0);
  static const blue  = Colour(0, 0, 255);

  static const cyan    = Colour(0, 255, 255);
  static const magenta = Colour(255, 0, 255);
  static const yellow  = Colour(255, 255, 0);

  static const white = Colour(255, 255, 255);
  static const black = Colour(0, 0, 0);
  static const transparent = Colour(0, 0, 0, 0);
}