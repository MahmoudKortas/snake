# snake
Classic Snake game built with Flutter. Control the snake with swipe gestures or keyboard arrows, eat food to grow, and avoid collisions. Fully customizable and fun to play!

# Snake Game in Flutter

A simple and classic Snake game built with Flutter. This project demonstrates the use of basic Flutter widgets, gesture detection, keyboard event handling, and a game loop using a timer.

## Features

- **Responsive Gameplay**: The snake moves across a grid, consuming food to grow in size.
- **Controls**:
  - Use **arrow keys** on a keyboard to control the snake's direction.
  - Swipe gestures are supported for mobile devices.
- **Game Over Dialog**: Displays a prompt to restart the game or exit when the snake collides with itself or the wall.
- **Customizable Grid**: Easily modify grid dimensions and square sizes.

## Getting Started

### Prerequisites

- Flutter SDK installed on your machine.
- A code editor like [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).
- A physical or virtual device (emulator) for testing.

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/snake-game-flutter.git
   cd snake-game-flutter
   flutter run
   
2. Install dependencies:
   flutter pub get
   
3.Run the app:
   flutter run

How to Play

    Start the game by running the app.
    Use one of the following controls:
        Arrow Keys: On a keyboard, press the arrow keys to move the snake up, down, left, or right.
        Swipe Gestures: Swipe in any direction on mobile to move the snake.
    Consume red squares (food) to grow the snake.
    Avoid colliding with the walls or the snake's body.
    If the snake collides, the game will show a "Game Over" dialog with options to restart or exit.

Code Highlights

    Gesture Handling: Swipe gestures for controlling the snake using GestureDetector.
    Keyboard Events: Capturing arrow key events using RawKeyboardListener.
    Game Loop: Timer-based loop to update the game state and check for collisions.
    Dynamic Grid Rendering: A grid-based approach using Row and Column widgets.

Customization

To modify the game's grid size or the snake's speed:

Open main.dart and change the following constants:

static const int rows = 20;         // Number of rows in the grid

static const int columns = 20;     // Number of columns in the grid

static const int squareSize = 20;  // Size of each square in pixels

Adjust the snake's speed by modifying the timer duration:

Timer.periodic(const Duration(milliseconds: 200), (timer) { ... });

Dependencies

    Flutter SDK: >=2.0.0

License

This project is licensed under the MIT License. See the LICENSE file for details.
Acknowledgments

    Inspired by the classic Snake game.
    Built with Flutter's versatile framework.

Contributions

Contributions are welcome! Feel free to fork the repository and submit a pull request with your improvements.

Enjoy coding and have fun playing the Snake game! 🎮🐍 
