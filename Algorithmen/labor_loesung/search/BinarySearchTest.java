package search;

import de.hska.iwi.ads.search.Search;
import org.junit.jupiter.api.Test;

public class BinarySearchTest extends de.hska.iwi.ads.search.SearchTest{
    Integer[] array = {1, 3, 5, 7, 9, 11, 13, 15, 17, 19};
    BinarySearch binarySearch = new BinarySearch();

    @Override
    public <E extends Comparable<E>> Search<E> createSearch() {
        return new BinarySearch();
    }

    @Test
    public void testVorhandeneElemente() {


        // Test für vorhandene Elemente
        assert binarySearch.search(array, 7, 0, array.length - 1) == 3;
        assert binarySearch.search(array, 1, 0, array.length - 1) == 0;
        assert binarySearch.search(array, 19, 0, array.length - 1) == 9;

    }

    @Test
    public void testSonderfaelle() {
        // Test für nicht vorhandene Elemente
        assert binarySearch.search(array, -1, 0, array.length - 1) == -1;
        assert binarySearch.search(array, 20, 0, array.length - 1) == array.length;
        assert binarySearch.search(array, 8, 0, array.length - 1) == 4;
    }

    @Test
    public void testLeereArray() {
        Integer[] emptyArray = {};
        assert binarySearch.search(emptyArray, 5, 0, emptyArray.length - 1) == -1;
    }

}
