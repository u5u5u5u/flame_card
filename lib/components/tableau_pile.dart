import 'dart:ui';
import 'package:base_flame_game/klondike_game.dart';
import 'package:flame/components.dart';
import 'card.dart';

class TableauPile extends PositionComponent {
  TableauPile({super.position}) : super(size: KlondikeGame.cardSize);

  final _borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10
    ..color = const Color(0x50fffff);

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(KlondikeGame.cardRRect, _borderPaint);
  }

  final List<Card> _cards = [];
  final Vector2 _fanOffset = Vector2(0, KlondikeGame.cardHeight * 0.05);

  void acquireCard(Card card) {
    if (_cards.isEmpty) {
      card.position = position;
    } else {
      card.position = _cards.last.position + _fanOffset;
    }
    card.priority = _cards.length;
    _cards.add(card);
  }

  void flipTopCard() {
    assert(_cards.last.isFaceDown);
    _cards.last.flip();
  }
}
