// import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
// import 'package:flame/palette.dart';

class HiddenCoin extends PositionComponent {
  HiddenCoin({
    required super.position,
  }) : super(
          size: Vector2(40, 40),
          anchor: Anchor.center,
        );

  @override
  void onLoad() {
    add(
      CircleHitbox(
        collisionType: CollisionType.passive,
      ),
    );
    super.onLoad();
  }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   canvas.drawCircle(
  //     (size / 2).toOffset(),
  //     size.x,
  //     BasicPalette.yellow.paint(),
  //   );
  // }
}
