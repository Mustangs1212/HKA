#include <stdio.h>
#include <string.h>

#define MAX 1000 // maximale Länge vom Eingabe

int main(void)
{
    char s[MAX];

    if (fgets(s, MAX, stdin) == NULL) {
        return 1; // Fehler beim Einlesen
    }

    // Zeilenumbruch am Ende entfernen, falls vorhanden
    size_t len = strlen(s);
    if (len > 0 && s[len - 1] == '\n') {
        s[len - 1] = '\0';
    }

    // String mit strtok in Wörter aufteilen
    char *word = strtok(s, " "); // erstes Wort
    while (word != NULL) {
        printf("%s\n", word);
        word = strtok(NULL, " "); // Nächstes Wort
    }
    return 0;
}