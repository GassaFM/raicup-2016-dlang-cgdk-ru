module model.building;

import model.status;
import model.living_unit;
import model.faction;
import model.building_type;

/**
 * Класс, определяющий строение. Фракционные строения самостоятельно атакуют противников в определённом радиусе.
 * $(BR)
 * Строения не могут быть заморожены (`frozen`).
 */
immutable class Building : LivingUnit
{
nothrow pure @safe @nogc:

    /**
     * Returns: Возвращает тип строения.
     */
    BuildingType type;
    /**
     * Returns: Возвращает максимальное расстояние (от центра до центра),
     * на котором данное строение обнаруживает другие объекты.
     */
    double visionRange;
    /**
     * Returns: Возвращает максимальное расстояние (от центра до центра),
     * на котором данное строение может атаковать другие объекты.
     */
    double attackRange;
    /**
     * Returns: Возвращает урон одной атаки.
     */
    int damage;
    /**
     * Returns: Возвращает интервал между атаками.
     */
    int cooldownTicks;
    /**
     * Returns: Возвращает количество тиков, оставшееся до следующей атаки.
     */
    int remainingActionCooldownTicks;

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
        immutable Status [] statuses,
        immutable BuildingType type,
        double visionRange,
        double attackRange,
        int damage,
        int cooldownTicks,
        int remainingActionCooldownTicks)
    {
        super (id, x, y, speedX, speedY, angle, faction, radius, life, maxLife, statuses);

        this.type = type;
        this.visionRange = visionRange;
        this.attackRange = attackRange;
        this.damage = damage;
        this.cooldownTicks = cooldownTicks;
        this.remainingActionCooldownTicks = remainingActionCooldownTicks;
    }
}
