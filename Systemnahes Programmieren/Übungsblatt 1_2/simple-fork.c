#include <stdio.h>
#include <unistd.h>

int main(void) {
    fork();

    printf("Hello!\n");
    sleep(1);
    return 0;
}
