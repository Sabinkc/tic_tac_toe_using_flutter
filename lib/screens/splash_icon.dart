import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/colors.dart';

class SplashIcon extends StatelessWidget {
  const SplashIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CommonColors.primaryColor,
        body: Center(
          child: CustomPaint(
            size: Size(150, 150), // Halved grid size
            painter: TicTacToeSplashPainter(),
          ),
        ),
      ),
    );
  }
}

class TicTacToeSplashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4 // Halved stroke width for grid lines
      ..style = PaintingStyle.stroke;

    // Draw the grid lines (3x3)
    double gridSize = size.width / 3;
    for (int i = 1; i < 3; i++) {
      // Vertical lines
      canvas.drawLine(
          Offset(gridSize * i, 0), Offset(gridSize * i, size.height), paint);
      // Horizontal lines
      canvas.drawLine(
          Offset(0, gridSize * i), Offset(size.width, gridSize * i), paint);
    }

    // Draw smaller X and O shapes with custom font style (hardcoded positions for splash effect)
    _drawX(canvas, paint, gridSize, 0, 0); // Position of X (top-left corner)
    _drawO(
        canvas, paint, gridSize, 2, 2); // Position of O (bottom-right corner)
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // No need to repaint
  }

  // Draw X with smaller size
  void _drawX(Canvas canvas, Paint paint, double gridSize, int row, int col) {
    double offsetX = gridSize * col;
    double offsetY = gridSize * row;

    // Reduce the size of the X by making the lines shorter and thinner
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2; // Smaller stroke width for X

    // Draw the diagonal lines for X
    canvas.drawLine(Offset(offsetX + gridSize * 0.2, offsetY + gridSize * 0.2),
        Offset(offsetX + gridSize * 0.8, offsetY + gridSize * 0.8), paint);
    canvas.drawLine(Offset(offsetX + gridSize * 0.8, offsetY + gridSize * 0.2),
        Offset(offsetX + gridSize * 0.2, offsetY + gridSize * 0.8), paint);
  }

  // Draw O with smaller size
  void _drawO(Canvas canvas, Paint paint, double gridSize, int row, int col) {
    double offsetX = gridSize * col;
    double offsetY = gridSize * row;

    // Draw the O (circle) with a smaller radius and thinner stroke width
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2; // Smaller stroke width for O

    // Draw the circle for O
    canvas.drawCircle(Offset(offsetX + gridSize / 2, offsetY + gridSize / 2),
        gridSize * 0.3, paint);
  }
}
