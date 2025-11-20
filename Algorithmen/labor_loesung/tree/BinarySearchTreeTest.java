package tree;

import java.util.Map;

public class BinarySearchTreeTest extends de.hska.iwi.ads.dictionary.MapTest{
    @Override
    public <K extends Comparable<K>, V> Map<K, V> createMap() {

        return new BinarySearchTree<>();
    }
}
