package generics;

import org.junit.jupiter.api.Test;

public class CardBoxTest {
    @Test
    public void testCardBox() {
        CardBox box1 = new CardBox(10, "Cards");
        CardBox box2 = new CardBox(20, "More Cards");

        assert box1.getVolume() == 10;
        assert box2.getVolume() == 20;
        assert !box1.isEmpty();
        assert !box2.isEmpty();
        assert box1.compareTo(box2) < 0;
        assert box2.compareTo(box1) > 0;
    }
}
