package generics;

public class CardBox extends de.hska.iwi.ads.generics.Box{
    /**
     * Creates a box with the given <code>volume</code>
     * and <code>content</code>.
     *
     * @param volume
     * @param content
     */
    public CardBox(int volume, Object content) {
        super(volume, content);
    }

    @Override
    public int compareTo(Object o) {
        return super.getVolume() - ((de.hska.iwi.ads.generics.Box) o).getVolume();
    }
}
