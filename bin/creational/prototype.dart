void main() {
  List<Shape> shapes = [];
  List<Shape> shapesCopy = [];

  Circle circle = Circle();
  circle.x = 10;
  circle.y = 20;
  circle.radius = 15;
  circle.color = 'red';
  shapes.add(circle);

  Circle anotherCircle = circle.clone() as Circle;
  shapes.add(anotherCircle);

  Rectangle rectangle = Rectangle();
  rectangle.width = 10;
  rectangle.height = 20;
  rectangle.color = 'blue';
  shapes.add(rectangle);

  cloneAndCompare(shapes, shapesCopy);
}

void cloneAndCompare(List<Shape> shapes, List<Shape> shapesCopy) {
  for (var shape in shapes) {
    shapesCopy.add(shape.clone());
  }

  for (int i = 0; i < shapes.length; i++) {
    if (shapes.elementAt(i) != shapesCopy.elementAt(i)) {
      print('$i: Shapes are different objects (yay!)');
      if (shapes.elementAt(i) == shapesCopy.elementAt(i)) {
        print('$i: And they are identical (yay!)');
      } else {
        print('$i: But they are not identical (boo!)');
      }
    } else {
      print('$i: Shape objects are the same (boo!)');
    }
  }
}

abstract class Shape {
  late int x;
  late int y;
  late String color;

  Shape();

  Shape.target(Shape? target) {
    if (target != null) {
      x = target.x;
      y = target.y;
      color = target.color;
    }
  }

  Shape clone();

  @override
  bool operator ==(Object other) {
    if (other is! Shape) return false;
    Shape shape2 = other;
    return shape2.x == x && shape2.y == y && identical(shape2.color, color);
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ color.hashCode;
}

final class Circle extends Shape {
  late int radius;

  Circle();

  Circle.target(Circle? target) : super.target(target) {
    if (target != null) {
      radius = target.radius;
    }
  }

  @override
  Shape clone() {
    return Circle.target(this);
  }

  @override
  bool operator ==(Object other) {
    if (other is! Circle || super != other) return false;
    Circle shape2 = other;
    return shape2.radius == radius;
  }

  @override
  int get hashCode => radius.hashCode ^ super.hashCode;
}

final class Rectangle extends Shape {
  late int width;
  late int height;

  Rectangle();

  Rectangle.target(Rectangle? target) : super.target(target) {
    if (target != null) {
      width = target.width;
      height = target.height;
    }
  }

  @override
  Shape clone() {
    return Rectangle.target(this);
  }

  @override
  bool operator ==(Object other) {
    if (other is! Rectangle || super != other) return false;
    Rectangle shape2 = other;
    return shape2.width == width && shape2.height == height;
  }

  @override
  int get hashCode => width.hashCode ^ height.hashCode ^ super.hashCode;
}
