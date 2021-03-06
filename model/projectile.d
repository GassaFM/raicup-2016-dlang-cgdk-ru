module model.projectile;

import model.projectile_type;
import model.circular_unit;
import model.faction;

/**
 * Класс, определяющий снаряд. Содержит также все свойства круглого юнита.
 */
immutable class Projectile : CircularUnit
{
nothrow pure @safe @nogc:

    /**
     * Returns: Возвращает тип снаряда.
     */
    ProjectileType type;
    /**
     * Returns: Возвращает идентификатор юнита, создавшего данный снаряд.
     */
    long ownerUnitId;
    /**
     * Returns: Возвращает идентификатор игрока, юнит которого создал данный снаряд или `-1`.
     */
    long ownerPlayerId;

    this (
        long id,
        double x,
        double y,
        double speedX,
        double speedY,
        double angle,
        immutable Faction faction,
        double radius,
        immutable ProjectileType type,
        long ownerUnitId,
        long ownerPlayerId)
    {
        super (id, x, y, speedX, speedY, angle, faction, radius);

        this.type = type;
        this.ownerUnitId = ownerUnitId;
        this.ownerPlayerId = ownerPlayerId;
    }
}
