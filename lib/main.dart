import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const SnakeGameApp());
}

class SnakeGameApp extends StatelessWidget {
  const SnakeGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake Game',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const SnakeGame(),
    );
  }
}

class SnakeGame extends StatefulWidget {
  const SnakeGame({Key? key}) : super(key: key);

  @override
  _SnakeGameState createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  static const int rows = 20;
  static const int columns = 20;
  static const int squareSize = 20;
  final Random _random = Random();

  List<Offset> _snake = [const Offset(5, 5)];
  Offset _food = const Offset(10, 10);
  String _direction = 'up'; // 'up', 'down', 'left', 'right'
  Timer? _timer;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _startGame();
    _focusNode.requestFocus();
  }

  void _startGame() {
    _snake = [const Offset(5, 5)];
    _food = _generateFood();
    _direction = 'up';
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        _moveSnake();
        if (_checkCollision()) {
          _gameOver();
        }
        if (_snake.first == _food) {
          _snake.add(_snake.last);
          _food = _generateFood();
        }
      });
    });
  }

  Offset _generateFood() {
    while (true) {
      final x = _random.nextInt(columns).toDouble();
      final y = _random.nextInt(rows).toDouble();
      final foodPosition = Offset(x, y);
      if (!_snake.contains(foodPosition)) {
        return foodPosition;
      }
    }
  }

  void _moveSnake() {
    final head = _snake.first;
    Offset newHead;

    switch (_direction) {
      case 'up':
        newHead = Offset(head.dx, head.dy - 1);
        break;
      case 'down':
        newHead = Offset(head.dx, head.dy + 1);
        break;
      case 'left':
        newHead = Offset(head.dx - 1, head.dy);
        break;
      case 'right':
        newHead = Offset(head.dx + 1, head.dy);
        break;
      default:
        return;
    }

    _snake.insert(0, newHead);
    _snake.removeLast();
  }

  bool _checkCollision() {
    final head = _snake.first;

    if (head.dx < 0 || head.dy < 0 || head.dx >= columns || head.dy >= rows) {
      return true; // Wall collision
    }
    if (_snake.skip(1).contains(head)) {
      return true; // Self collision
    }

    return false;
  }

  void _gameOver() {
    _timer?.cancel();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: const Text('You lost! Do you want to play again?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _startGame();
            },
            child: const Text('Restart'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  void _changeDirection(String newDirection) {
    if ((newDirection == 'up' && _direction != 'down') ||
        (newDirection == 'down' && _direction != 'up') ||
        (newDirection == 'left' && _direction != 'right') ||
        (newDirection == 'right' && _direction != 'left')) {
      _direction = newDirection;
    }
  }

  void _onKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      switch (event.logicalKey.keyLabel) {
        case 'Arrow Up':
          _changeDirection('up');
          break;
        case 'Arrow Down':
          _changeDirection('down');
          break;
        case 'Arrow Left':
          _changeDirection('left');
          break;
        case 'Arrow Right':
          _changeDirection('right');
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake Game'),
      ),
      body: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: _onKeyEvent,
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.delta.dy < 0) {
              _changeDirection('up');
            } else if (details.delta.dy > 0) {
              _changeDirection('down');
            }
          },
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx < 0) {
              _changeDirection('left');
            } else if (details.delta.dx > 0) {
              _changeDirection('right');
            }
          },
          child: Container(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int y = 0; y < rows; y++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int x = 0; x < columns; x++)
                        Container(
                          width: squareSize.toDouble(),
                          height: squareSize.toDouble(),
                          decoration: BoxDecoration(
                            color: _snake.contains(Offset(x.toDouble(), y.toDouble()))
                                ? Colors.green
                                : (_food == Offset(x.toDouble(), y.toDouble())
                                    ? Colors.red
                                    : Colors.grey[800]),
                            border: Border.all(color: Colors.black),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }
}