package hashtable;

import java.util.AbstractMap;

public class Hashtable<K extends Comparable<K>, V> extends de.hska.iwi.ads.dictionary.AbstractHashMap<K, V>{
    public Hashtable(int capacity) {
        super(capacity);

        if(capacity < 1){
            throw new IllegalArgumentException("Capacity must be at least 1");
        }
    }
    @Override
    public V get(Object o) {
        if (o == null) {
            throw new NullPointerException("Key must not be null");
        }
        @SuppressWarnings("unchecked")
        K key = (K) o;


        int hash = Math.abs(key.hashCode()) % hashtable.length;


        // Quadratisches Sondieren
        for (int i = 0; i < hashtable.length; i++) {
            int index = (hash + i * i) % hashtable.length;

            Entry<K, V> entry = hashtable[index];

            if (entry == null) {
                return null;
            }

            if (entry.getKey().equals(key)) {
                return entry.getValue();
            }
        }
        return null;
    }

    @Override
    public V put(K key, V value) {

        if (key == null) {
            throw new NullPointerException("Key must not be null");
        }
        int hash = Math.abs(key.hashCode()) % hashtable.length;

        // Quadratisches Sondieren
        for (int i = 0; i < hashtable.length; i++) {
            int index = (hash + i * i) % hashtable.length;
            Entry<K, V> entry = hashtable[index];

            if (entry == null) {
                // Leerer Slot gefunden, neues Entry einfügen
                hashtable[index] = new AbstractMap.SimpleEntry<>(key, value);
                return null;
            }

            if (entry.getKey().equals(key)) {
                // Schlüssel bereits vorhanden, Wert aktualisieren
                V oldValue = entry.getValue();
                hashtable[index] = new AbstractMap.SimpleEntry<>(key, value);
                return oldValue;
            }

        }

        // Kein Platz mehr gefunden
        throw new DictionaryFullException();
    }

}
