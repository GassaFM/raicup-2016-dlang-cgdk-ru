module model.tree;

import model.living_unit;
import model.faction;
import model.status;

/**
 * Класс, определяющий дерево. Содержит также все свойства живого юнита.
 */
immutable class Tree : LivingUnit
{
nothrow pure @safe @nogc:


    this (
        long id,
        double x,
        double y,
        double speedX,
        double speedY,
        double angle,
        immutable Faction faction,
        double radius,
        int life,
        int maxLife,
        immutable Status [] statuses)
    {
        super (id, x, y, speedX, speedY, angle, faction, radius, life, maxLife, statuses);
    }
}
