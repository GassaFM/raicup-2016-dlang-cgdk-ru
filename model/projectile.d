module model.projectile;

import model.projectile_type;
import model.circular_unit;
import model.faction;

/**
 * Класс, определяющий снаряд. Содержит также все свойства круглого юнита.
 */
class Projectile : CircularUnit
{
    /**
     * Returns: Возвращает тип снаряда.
     */
    immutable ProjectileType type;
    /**
     * Returns: Возвращает идентификатор юнита, создавшего данный снаряд.
     */
    immutable long ownerUnitId;
    /**
     * Returns: Возвращает идентификатор игрока, юнит которого создал данный снаряд или `-1`.
     */
    immutable long ownerPlayerId;

    immutable this (
        long id,
        double x,
        double y,
        double speedX,
        double speedY,
        double angle,
        immutable (Faction) faction,
        double radius,
        immutable (ProjectileType) type,
        long ownerUnitId,
        long ownerPlayerId)
    {
        super (id, x, y, speedX, speedY, angle, faction, radius);

        this.type = type;
        this.ownerUnitId = ownerUnitId;
        this.ownerPlayerId = ownerPlayerId;
    }
}
