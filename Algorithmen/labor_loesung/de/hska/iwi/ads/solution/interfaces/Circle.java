package de.hska.iwi.ads.solution.interfaces;


import de.hska.iwi.ads.interfaces.AbstractCircle;
import de.hska.iwi.ads.interfaces.Vector;

public class Circle extends de.hska.iwi.ads.interfaces.AbstractCircle {

    public Circle(Vector middlePoint, double radius) {
        super(middlePoint, radius);
    }

    public Circle(double radius){
        super(radius);
    }

    public void scale(double factor){
        radius = radius * factor;
    }

    public double area(){
        return Math.PI * Math.pow(getRadius(),2);
    }
    public double getDimension(){
        return getRadius();
    }
}
