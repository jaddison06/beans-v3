#ifndef C_CODEGEN_H
#define C_CODEGEN_H

// old-style booleans to ensure Dart compatibility
typedef char BEANS_BOOL;
#define TRUE 1
#define FALSE 0

// ----------NATIVE\3RDPARTY\LIBE131\E131.GEN----------

typedef enum {
    BeansE131ErrorCode_success = 0,
    BeansE131ErrorCode_socket = 1,
    BeansE131ErrorCode_source_name = 2,
    BeansE131ErrorCode_unicast_dest = 3,
} BeansE131ErrorCode;

#endif // C_CODEGEN_H