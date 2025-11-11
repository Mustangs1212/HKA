package sorting;

public class ReverseArray implements de.hska.iwi.ads.sorting.Reverse{
    @Override
    public void reverse(Comparable[] a, int from, int to) {
        if (a == null) return;
        while (from < to) {
            Comparable tmp = a[from];
            a[from] = a[to];
            a[to] = tmp;
            from++;
            to--;
        }
    }
}
