package sorting;
import org.junit.jupiter.api.Test;
public class ReverseMergeSortTest {
    @Test
    public void sortedArray() {
        ReverseMergesort sorter = new ReverseMergesort();
        Comparable[] array = {5, 3, 8, 1, 2, 7};
        sorter.sort(array);
        Comparable[] expected = {1, 2, 3, 5, 7, 8};
        assert java.util.Arrays.equals(array, expected) : "Test failed: array is not sorted in reverse order.";
    }

    @Test
    public void reverseSortedArray() {
        ReverseMergesort sorter = new ReverseMergesort();
        Comparable[] array = {8, 7, 5, 3, 2, 1};
        sorter.sort(array);
        Comparable[] expected = {1, 2, 3, 5, 7, 8};
        assert java.util.Arrays.equals(array, expected) : "Test failed: array is not sorted in reverse order.";
    }

    @Test
    public void arrayWithDuplicates() {
        ReverseMergesort sorter = new ReverseMergesort();
        Comparable[] array = {5, 3, 8, 3, 2, 7, 5};
        sorter.sort(array);
        Comparable[] expected = {2, 3, 3, 5, 5, 7, 8};
        assert java.util.Arrays.equals(array, expected) : "Test failed: array with duplicates is not sorted in reverse order.";
    }

    @Test
    public void arrayWithNegativeNumbers() {
        ReverseMergesort sorter = new ReverseMergesort();
        Comparable[] array = {5, -3, 8, -1, 2, -7};
        sorter.sort(array);
        Comparable[] expected = {-7, -3, -1, 2, 5, 8};
        assert java.util.Arrays.equals(array, expected) : "Test failed: array with negative numbers is not sorted in reverse order.";
    }

    @Test
    public void singleElementArray() {
        ReverseMergesort sorter = new ReverseMergesort();
        Comparable[] array = {5};
        sorter.sort(array);
        Comparable[] expected = {5};
        assert java.util.Arrays.equals(array, expected) : "Test failed: single element array is not sorted correctly.";
    }

    @Test
    public void emptyArray() {
        ReverseMergesort sorter = new ReverseMergesort();
        Comparable[] array = {};
        sorter.sort(array);
        Comparable[] expected = {};
        assert java.util.Arrays.equals(array, expected) : "Test failed: empty array is not sorted correctly.";
    }

    @Test
    public void stringArray() {
        ReverseMergesort sorter = new ReverseMergesort();
        Comparable[] array = {"banana", "apple", "orange", "kiwi"};
        sorter.sort(array);
        Comparable[] expected = {"apple", "banana", "kiwi", "orange"};
        assert java.util.Arrays.equals(array, expected) : "Test failed: string array is not sorted in reverse order.";
    }




}
