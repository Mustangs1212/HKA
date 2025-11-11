package search;

public class BinarySearch implements de.hska.iwi.ads.search.Search{
    @Override
    public int search(Comparable[] a, Comparable key, int left, int right) {

        if (a.length == 0) {
            return left - 1; // Sonderfall: leeres Array
        } else if(right < left) {
            throw new ArrayIndexOutOfBoundsException("Left oder Right Index außerhalb der Array-Grenzen");
        }
        int mid = 0;
        while (left<=right) { // Iteratives Verfahren
            // Sonderfälle: key außerhalb der Ränder
            if (key.compareTo(a[left]) < 0) {

                // Sonderfall 3
                if(mid != left && mid != 0) {
                    return left; // kleinste Index
                }
                return left - 1;
            } else if (key.compareTo(a[right]) > 0) {
                return right + 1;
            }

            mid = (left + right) / 2;
            if (a[mid].compareTo(key) > 0) {
                right = mid - 1;
            } else if(a[mid].compareTo(key) < 0) {
                left = mid + 1;
            } else {
                // Gibt es weitere gleiche Elemente links von mid?
                if(mid > 0 && a[mid - 1].compareTo(key) == 0) {
                    right = mid - 1;
                    continue;
                }
                break; // key gefunden
            }
        }
        return mid;
    }
}
