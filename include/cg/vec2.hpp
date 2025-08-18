#pragma once
#include "Export.h"

namespace cg {

	class CG_API Vec2 {
	public:
		float x, y;

		Vec2();
		Vec2(float x, float y);

		float length() const;

		Vec2 operator+(const Vec2& other) const;

		float dot(const Vec2& other) const;

		float cross(const Vec2& other) const;
	};
}