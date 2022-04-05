#include <stdint.h>

extern "C" __attribute__((visibility("default"))) __attribute__((used))
char const *get_native_string(int32_t code) {
    if (code == 0) { // sentry dsn
        return "";
    } else if (code == 1) { // base url dev
        return "https://api.sywhcy.com/api/focus-fish";
    } else if (code == 2) { // base url prod
        return "https://api.sywhcy.com/api/focus-fish";
    } else {
        return "error";
    }
}
