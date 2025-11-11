package sorting;

public class ReverseMergesort extends de.hska.iwi.ads.sorting.AbstractMergesort{
    @Override
    protected void mergesort(Comparable[] a, int left, int right) {
        if (left < right) {
            int mid = (left + right) / 2;
            mergesort(a, left, mid);
            mergesort(a, mid + 1, right);
            verschmelzen(a, left, mid, right);
        }
    }

    ReverseArray umdrehen = new ReverseArray();

    private void verschmelzen(Comparable[] a, int left, int mid, int right) {
        int l = left;
        int r = right;

        umdrehen.reverse(a, mid + 1, right); // Macht unstabil, weil gleiche Elemente ihre Reihenfolge ändern können
        for (int i = left; i <= right; i++) {
            if (a[l].compareTo(a[r]) <= 0) {
                b[i] = a[l];
                l++;
            } else {
                b[i] = a[r];
                r--;
            }
        }

        // Zurückkopieren in a
        for (int i = left; i <= right; i++) {
            a[i] = b[i];
        }
    }
}
