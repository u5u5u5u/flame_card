import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'dart:ui';
import '../klondike_game.dart';
import 'card.dart';
import 'waste_pile.dart';

class StockPile extends PositionComponent with TapCallbacks {
  StockPile({super.position}) : super(size: KlondikeGame.cardSize);

  final List<Card> _cards = [];

  void acquireCard(Card card) {
    assert(!card.isFaceUp);
    card.position = position;
    card.priority = _cards.length;
    _cards.add(card);
  }

  @override
  void onTapUp(TapUpEvent event) {
    final wastePile = parent!.firstChild<WastePile>()!;
    if (_cards.isEmpty) {
      wastePile.removeAllCards().reversed.forEach((card) {
        card.flip();
        acquireCard(card);
      });
    }
    for (var i = 0; i < 3; i++) {
      final card = _cards.removeLast();
      card.flip();
      wastePile.acquireCard(card);
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(KlondikeGame.cardRRect, _borderPaint);
    canvas.drawCircle(
      Offset(width / 2, height / 2),
      KlondikeGame.cardWidth * 0.3,
      _circlePaint,
    );
  }

  final _borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10
    ..color = const Color(0xff3f5b5d);
  final _circlePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 100
    ..color = const Color(0x883f5b5d);
}
