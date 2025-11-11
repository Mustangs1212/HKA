* \#include <stdio.h> bedeutet. Standart in out. Jedes C muss das implementieren
* char\* name = "Nunu"; steht für Charfolge bzw. **String**

 	printf("%s", name);

 	char c = 'a'; mit %c

* int num; mit %d
* float kommazahl = 0.000001f;
* double kommazahl = 0.000000000000002; mit %lf
* bool b = false;
* unsigned int %u
* Daten Einlesen: scanf("s", \&name);

 	\& stehet für die Adresse

 	Segmentation fault: Speicher Fehler, nicht genug reserviert bzw keine. Also muss man z.B. char\* name\[256]; schreiben

 	scanf("%\[^\\n]", \&name); Eingabe bis einem Enter

* printf("%lf + %lf = %lf", zahl1, zahl2, zahl1 + zahl2); Einfache Addtion in print Funktion
* void showPhoneNumbers(char \*\*myPhoneNumbers\[4]\[256]) {} myPhoneNumbers ist ein String-Array, der Länge 4 und ein String kann aus 256 Zeichen bestehen.
* strcpy(phoneNumbers\[4], "Hallo"); man muss z.B.: davor phoneNumbers\[100]\[256]{...} einsezten.
