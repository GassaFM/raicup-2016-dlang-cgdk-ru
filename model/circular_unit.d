module model.circular_unit;

import model.unit;
import model.faction;

/**
 * Базовый класс для определения круглых объектов. Содержит также все свойства юнита.
 */
abstract immutable class CircularUnit : Unit
{
    /**
     * Returns: Возвращает радиус объекта.
     */
    double radius;

    protected this (
        long id,
        double x,
        double y,
        double speedX,
        double speedY,
        double angle,
        immutable (Faction) faction,
        double radius)
    {
        super (id, x, y, speedX, speedY, angle, faction);

        this.radius = radius;
    }
}
