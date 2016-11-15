module model.minion;

import model.living_unit;
import model.minion_type;
import model.status;
import model.faction;

/**
 * Класс, определяющий приспешника волшебника одной из фракций. Содержит также все свойства живого юнита.
 * $(BR)
 * Миньоны, оставшиеся по той или иной причине без хозяина, часто объединяются в небольшие группы и селятся в лесах.
 * Они крайне настороженно относятся ко всем другим волшебникам и их миньонам.
 */
immutable class Minion : LivingUnit
{
    /**
     * Returns: Возвращает тип миньона.
     */
    MinionType type;
    /**
     * Returns: Возвращает максимальное расстояние (от центра до центра),
     * на котором данный миньон обнаруживает другие объекты.
     */
    double visionRange;
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
        immutable MinionType type,
        double visionRange,
        int damage,
        int cooldownTicks,
        int remainingActionCooldownTicks)
    {
        super (id, x, y, speedX, speedY, angle, faction, radius, life, maxLife, statuses);

        this.type = type;
        this.visionRange = visionRange;
        this.damage = damage;
        this.cooldownTicks = cooldownTicks;
        this.remainingActionCooldownTicks = remainingActionCooldownTicks;
    }
}
