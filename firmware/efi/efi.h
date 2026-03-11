#include <stdint.h>

#if __has_include(<uchar.h>)
    #include <uchar.h>
#endif

#define EFIAPI __attribute__((ms_abi)) // x86_64 Microsoft Calling Convention

// Data types: UEFI Spec
typedef uint8_t  BOOLEAN;
typedef int64_t  INTN;
typedef uint64_t UINTN;
typedef int8_t   INT8;
typedef uint8_t  UINT8;
typedef int16_t  INT16;
typedef uint16_t UINT16;
typedef int32_t  INT32;
typedef uint32_t UINT32;
typedef int64_t  INT64;
typedef uint64_t UINT64;
typedef char     CHAR8;

#ifndef _UCHAR_H
    typedef uint_least16_t char16_t;
#endif
typedef char16_t CHAR16;
