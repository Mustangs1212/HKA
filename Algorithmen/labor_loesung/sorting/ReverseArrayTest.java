package sorting;
import org.junit.jupiter.api.Test;

public class ReverseArrayTest {
    @Test
    public void testReverseArray() {
        Integer[] array = {1, 2, 3, 4, 5};
        ReverseArray reverseArray = new ReverseArray();

        reverseArray.reverse(array, 0, array.length - 1);
        Integer[] expected = {5, 4, 3, 2, 1};
        assert java.util.Arrays.equals(array, expected);
    }

    @Test
    public void testReverseSubArray() {
        Integer[] array = {1, 2, 3, 4, 5};
        ReverseArray reverseArray = new ReverseArray();

        reverseArray.reverse(array, 1, 3);
        Integer[] expected = {1, 4, 3, 2, 5};
        assert java.util.Arrays.equals(array, expected);
    }

    @Test
    public void testReverseSingleElement() {
        Integer[] array = {1, 2, 3, 4, 5};
        ReverseArray reverseArray = new ReverseArray();

        reverseArray.reverse(array, 2, 2);
        Integer[] expected = {1, 2, 3, 4, 5};
        assert java.util.Arrays.equals(array, expected);
    }

    @Test
    public void testReverseEmptyArray() {
        Integer[] array = {};
        ReverseArray reverseArray = new ReverseArray();

        reverseArray.reverse(array, 0, -1);
        Integer[] expected = {};
        assert java.util.Arrays.equals(array, expected);
    }

    @Test
    public void testStringArray() {
        String[] array = {"a", "b", "c", "d", "e"};
        ReverseArray reverseArray = new ReverseArray();

        reverseArray.reverse(array, 0, array.length - 1);
        String[] expected = {"e", "d", "c", "b", "a"};
        assert java.util.Arrays.equals(array, expected);
    }
}
