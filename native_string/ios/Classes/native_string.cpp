#include <stdint.h>

extern "C" __attribute__((visibility("default"))) __attribute__((used))
char const *get_native_string(int32_t code) {
    if (code == 0) { // sentry dsn
        return "";
    } else if (code == 0) { // sentry dsn
        return "";
    } else if (code == 0) { // sentry dsn
        return "";
    } else {
        return "error";
    }
}
