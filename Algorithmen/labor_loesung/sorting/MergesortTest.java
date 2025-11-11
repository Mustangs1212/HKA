package sorting;
import org.junit.jupiter.api.Test;
public class MergesortTest {
    @Test
    public void testMergesort() {
        Integer[] array = {38, 27, 43, 3, 9, 82, 10};
        Integer[] hilfsarray = new Integer[array.length];
        Mergesort mergesort = new Mergesort();

        mergesort.sort(array);
        Integer[] expected = {3, 9, 10, 27, 38, 43, 82};
        assert java.util.Arrays.equals(array, expected);
    }
    @Test
    public void testEmptyArray() {
        Integer[] array = {};
        Mergesort mergesort = new Mergesort();

        mergesort.sort(array);
        Integer[] expected = {};
        assert java.util.Arrays.equals(array, expected);
    }

    @Test
    public void testSingleElementArray() {
        Integer[] array = {42};
        Mergesort mergesort = new Mergesort();

        mergesort.sort(array);
        Integer[] expected = {42};
        assert java.util.Arrays.equals(array, expected);
    }

    @Test
    public void testAlreadySortedArray() {
        Integer[] array = {1, 2, 3, 4, 5};
        Mergesort mergesort = new Mergesort();

        mergesort.sort(array);
        Integer[] expected = {1, 2, 3, 4, 5};
        assert java.util.Arrays.equals(array, expected);
    }

    @Test
    public void testNegativeNumbers() {
        Integer[] array = {-3, -1, -4, -2, 0};
        Mergesort mergesort = new Mergesort();

        mergesort.sort(array);
        Integer[] expected = {-4, -3, -2, -1, 0};
        assert java.util.Arrays.equals(array, expected);
    }

    @Test
    public void testArrayWithDuplicates() {
        Integer[] array = {5, 3, 8, 3, 9, 5, 1};
        Mergesort mergesort = new Mergesort();

        mergesort.sort(array);
        Integer[] expected = {1, 3, 3, 5, 5, 8, 9};
        assert java.util.Arrays.equals(array, expected);
    }

    @Test
    public void testStringArray() {
        String[] array = {"banana", "apple", "orange", "kiwi"};
        Mergesort mergesort = new Mergesort();

        mergesort.sort(array);
        String[] expected = {"apple", "banana", "kiwi", "orange"};
        assert java.util.Arrays.equals(array, expected);
    }

    @Test
    public void isStable() {
        Mergesort mergesort = new Mergesort();
        class Pair implements Comparable<Pair> {
            String value;
            int id;

            Pair(String value, int id) {
                this.value = value;
                this.id = id;
            }

            @Override
            public int compareTo(Pair other) {
                return this.value.compareTo(other.value);
            }
        }

        Pair[] array = {
                new Pair("apple", 1),
                new Pair("banana", 2),
                new Pair("apple", 3),
                new Pair("banana", 4)
        };

        mergesort.sort(array);

        assert array[0].value.equals("apple") && array[0].id == 1;
        assert array[1].value.equals("apple") && array[1].id == 3;
        assert array[2].value.equals("banana") && array[2].id == 2;
        assert array[3].value.equals("banana") && array[3].id == 4;
    }
}
