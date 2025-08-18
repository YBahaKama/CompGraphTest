#include <cg/vec2.hpp>
#include <gtest/gtest.h>

TEST(Vec2Test, DefaultConstructor) {
	cg::Vec2 v;
	EXPECT_FLOAT_EQ(v.x, 0.0f);
	EXPECT_FLOAT_EQ(v.y, 0.0f);
}

TEST(Vec2Test, ParameterizedConstructor) {
	cg::Vec2 v(1.0f, 2.0f);
	EXPECT_FLOAT_EQ(v.x, 1.0f);
	EXPECT_FLOAT_EQ(v.y, 2.0f);
}