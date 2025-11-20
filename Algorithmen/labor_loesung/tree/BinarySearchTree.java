package tree;

public class BinarySearchTree<K extends Comparable<K>, V>
        extends de.hska.iwi.ads.dictionary.AbstractBinaryTree<K, V> {

    @Override
    public V get(Object o) {
        @SuppressWarnings("unchecked")
        K key = (K) o;

        Node current = root;
        while (current != null) {
            int cmp = key.compareTo(current.entry.getKey());
            if (cmp == 0) {
                return current.entry.getValue();
            } else if (cmp < 0) {
                current = current.left;
            } else {
                current = current.right;
            }
        }
        return null; // Schlüssel nicht gefunden
    }

    @Override
    public V put(K key, V value) {
        if (root == null) {
            root = new Node(key, value);
            size++;                 // <<< NEU: Größe erhöhen
            return null;
        }

        Node current = root;
        Node parent = null;

        while (current != null) {
            parent = current;
            int cmp = key.compareTo(current.entry.getKey());

            if (cmp == 0) {
                // Schlüssel existiert → Wert ersetzen
                V oldVal = current.entry.getValue();
                current.entry.setValue(value);
                return oldVal;      // <<< Größe bleibt unverändert!
            }
            else if (cmp < 0) {
                current = current.left;
            }
            else {
                current = current.right;
            }
        }

        // Neues Blatt erzeugen
        int cmp = key.compareTo(parent.entry.getKey());
        if (cmp < 0) {
            parent.left = new Node(key, value);
        } else {
            parent.right = new Node(key, value);
        }

        size++;                     // <<< NEU: Größe erhöhen

        return null;                // neuer Eintrag
    }

}
