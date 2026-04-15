#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc, char *argv[]) {
    // 1. Prüfen, ob ein Argument übergeben wurde
    if (argc < 2) {
        printf("Nutzung: %s <anzahl_n>\n", argv[0]);
        return 1;
    }

    // 2. Argument in Integer umwandeln
    int n = atoi(argv[1]);

    for (int i = 1; i <= n; i++) {
        pid_t pid = fork();

        if (pid < 0) {
            // Fehlerfall
            perror("Fork fehlgeschlagen");
            exit(1);
        } 
        else if (pid == 0) {
            // --- KINDPROZESS ---
            printf("This is child process %d.\n", i);
            sleep(5);
            exit(0); // WICHTIG: Kind beenden, damit es nicht weiter schleift!
        }
        // Elternprozess macht einfach mit dem nächsten Schleifendurchlauf weiter
    }

    // --- ELTERNPROZESS ---
    // Warten auf genau n Kinder
    while(wait(NULL) < 0);

    printf("Parent process finished.\n");

    return 0;
}
