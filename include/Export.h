#pragma once

#if defined(_WIN32) || defined(_WIN64)
#if defined(CG_EXPORTS)
#define CG_API __declspec(dllexport)
#elif defined(CG_IMPORTS)
#define CG_API __declspec(dllimport)
#else
#define CG_API
#endif
#else
#if __GNUC__ >= 4
#define CG_API __attribute__((visibility("default")))
#else
#define CG_API
#endif
#endif
