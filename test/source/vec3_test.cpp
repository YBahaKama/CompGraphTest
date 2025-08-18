#include <cg/vec3.hpp>
#include <gtest/gtest.h>


TEST(Vec3Test, DefaultConstructor) {
	cg::vec3 v;
	EXPECT_FLOAT_EQ(v.x, 0.0f);
	EXPECT_FLOAT_EQ(v.y, 0.0f);
	EXPECT_FLOAT_EQ(v.z, 0.0f);
}

TEST(Vec3Test, ParameterizedConstructor) {
	cg::vec3 v(1.0f, 2.0f, 3.0f);
	EXPECT_FLOAT_EQ(v.x, 1.0f);
	EXPECT_FLOAT_EQ(v.y, 2.0f);
	EXPECT_FLOAT_EQ(v.z, 3.0f);
}

