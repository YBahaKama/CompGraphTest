#include <cg/vec2.hpp>
#include <iostream>

int main() {
    cg::Vec2 a(1.0f, 2.0f);
    cg::Vec2 b(3.0f, 4.0f);
    auto c = a + b;
    std::cout << "Result: " << c.x << ", " << c.y << "\n";
}
