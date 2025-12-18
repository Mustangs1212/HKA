package list;


import java.util.AbstractMap;
import java.util.Objects;

public class DoubleLinkedList<K extends Comparable<K>, V>
        extends de.hska.iwi.ads.dictionary.AbstractDoubleLinkedList<K, V>{


     // Hilfsmethode
    @SuppressWarnings("unchecked")
    private ListElement findElement(Object keyObj) {
        K key = (K) keyObj;

        ListElement current = head;
        while (current != null) {
            if (current.entry.getKey().equals(key)) {
                return current;
            }
            current = current.next;
        }
        return null;
    }

    /**
     * Gibt den Wert zum Schlüssel zurück oder null, falls nicht vorhanden.
     */
    @Override
    @SuppressWarnings("unchecked")
    public V get(Object keyObj) {
        if (keyObj == null) {
            throw new NullPointerException("Key must not be null");
        }
        ListElement element = findElement(keyObj);
        return (element == null) ? null : (V) element.entry.getValue();
    }

    /**
     * Fügt ein Element am Anfang der Liste ein.
     * Falls Schlüssel vorhanden → alten Wert zurückgeben + überschreiben.
     */
    @Override
    public V put(K key, V value) {
        Objects.requireNonNull(key, "Key must not be null");

        // Falls Schlüssel schon existiert → überschreiben
        ListElement existing = findElement(key);
        if (existing != null) {
            V oldValue = (V) existing.entry.getValue();
            existing.entry.setValue(value);
            return oldValue;
        }

        // Neues Entry erzeugen
        Entry<K, V> newEntry = new AbstractMap.SimpleEntry<>(key, value);

        // Kopf verschieben
        head = new ListElement(newEntry, null, head);
        size++;

        return null;
    }
}
