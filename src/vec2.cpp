#include "cg/vec2.hpp"
#include <cmath>

namespace cg {

	Vec2::Vec2() : x(0.0f), y(0.0f) {}

	Vec2::Vec2(float x, float y) : x(x), y(y) {}

	float Vec2::length() const {
		return std::sqrt(x * x + y * y);
	}

    Vec2 Vec2::operator+(const Vec2& other) const {
        return Vec2(x + other.x, y + other.y);
    }

	float Vec2::dot(const Vec2& other) const {
		return x * other.x + y * other.y;
	}

	float Vec2::cross(const Vec2& other) const {
		return x * other.y - y * other.x;
	}
} 
