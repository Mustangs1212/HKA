package hashtable;


import java.util.Map;

public class HashtableTest extends de.hska.iwi.ads.dictionary.MapTest{
    @Override
    public <K extends Comparable<K>, V> Map<K, V> createMap() {

        return new Hashtable<>(15);
    }
}
