package sorting;

public class Mergesort extends de.hska.iwi.ads.sorting.AbstractMergesort{


    @Override
    protected void mergesort(Comparable[] a, int left, int right) {
        if (left < right) {
            int mid = (left + right) / 2;
            mergesort(a, left, mid);
            mergesort(a, mid + 1, right);
            verschmelzen(a, left, mid, right);
        }
    }

    private void verschmelzen(Comparable[] a, int left, int mid, int right) {
        int l = left;
        int r = mid + 1;

        for (int i = left; i <= right; i++) {
            if (r > right || (l <= mid && a[l].compareTo(a[r]) <= 0)) {
                b[i] = a[l];
                l++;
            } else {
                b[i] = a[r];
                r++;
            }
        }

        // Zurückkopieren in a
        for (int i = left; i <= right; i++) {
            a[i] = b[i];
        }
    }
}
