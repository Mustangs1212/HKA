package de.hska.iwi.ads.solution.interfaces;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

/**
 * A few simple tests for Circle.
 * 
 * Use {@link Circle#Circle(double)} to create a Circle instance.
 */
class CircleTest {

  /**
   * Create a Circle with a negative radius -10.0.
   * Check with a try-catch-statement 
   * that the constructor throws an IllegalArgumentException.
   */
  @Test
  void testCircleDouble() {
      try {
          Circle c = new Circle(-10);
          double result = c.getRadius();
          assertEquals(-10, result);
      } catch (IllegalArgumentException e){
          throw new IllegalArgumentException("The radius can not be negative");
      }

  }
  
  /*
   * Create a Circle with radius 1.5.
   * Scale it by a factor of 2.0.
   * Check that afterwards the Circle 
   * has a radius near 3.0.
   */
  @Test
  void testScale1() {
      Circle c = new Circle(1.5);
      c.scale(2);
      double radius = c.getRadius();
      double tolarance = 0.0001;
      assertTrue(Math.abs(radius - Math.PI) <= tolarance);
  }

  /*
   * Create a Circle with radius 1.0.
   * Check that the area is nearly Math.PI.
   */
  @Test
  void testArea1() {
      Circle c = new Circle(1);
      double PI = 3.14;
  }

  /*
   * Create a Circle with radius 2.0.
   * Check that the area is nearly 4.0 * Math.PI.
   */
  @Test
  void testArea2() {
      Circle c = new Circle(2);
      double area = c.area();
      double tolarance = 0.0001;
      assertTrue(Math.abs(area - 4*Math.PI) <= tolarance);
  }


  /*
   * Create a Circle with radius 1.0.
   * Check that the radius is near 1.0.
   */
  @Test
  void testGetRadius1() {
      Circle c = new Circle(1);
      assertEquals(1, c.getRadius());
  }

}
