## Normalisiere



* Nach dem letzten geschriebenen Zeichen kommt '\\0' 
* Wenn ein leer Zeichen gelesen wird, einfach weiterlesen







\*write = ...

→ schreibe ein Zeichen an die Speicheradresse, auf die write gerade zeigt.



write++

→ erhöhe den Zeiger, sodass er auf das nächste Zeichen im Speicher zeigt.









s → zeigt immer auf den Anfang des Strings



write → zeigt auf das Ende des bearbeiteten Strings





## CopyStr

* **size\_t** --> für Größen und Indizes. Anzahl von Bytes, Länge von Arrays oder Speichergrößen
* **malloc**((len + 1) \* sizeof(char)) reserviert genug Speicher für alle Zeichen plus das Nullterminierungszeichen.
* **sizeof** ist ein Operator in C, der die Größe (in Bytes) eines Datentyps oder einer Variablen zurückgibt.



## putBack

* size\_t len --> Länge des Original-Strings bestimmen
* **free():** Wenn man Zwischenergebnisse nicht mehr braucht, bleiben sie sonst im Speicher und verursachen ein Speicherleck.



## rev

* **Dynmaischen Speicher:** Existiert bis du free() aufrufst
* Statischer Speicher:Existiert solange die Funktion läuft oder global bis Programmende
* man teilt das Wort in einzelnen Buchstaben und mit putBack werden sie wieder zusammengefügt.



* Die Rekursion arbeitet von vorne nach hinten (erstes Zeichen wird zurückbehalten).
* putBack hängt das erste Zeichen ans Ende des bereits rekursiv umgedrehten Reststrings.
* Am Ende entsteht der komplett umgedrehte String.
