module model.living_unit;

import model.faction;
import model.circular_unit;
import model.status;

/**
 * Класс, определяющий живого юнита круглой формы.
 */
abstract immutable class LivingUnit : CircularUnit
{
    /**
     * Returns: Возвращает текущее количество жизненной энергии.
     */
    int life;
    /**
     * Returns: Возвращает максимальное количество жизненной энергии.
     */
    int maxLife;
    /**
     * Returns: Возвращает магические статусы, влияющие на живого юнита.
     */
    Status [] statuses;

    protected this (
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
        super (id, x, y, speedX, speedY, angle, faction, radius);

        this.life = life;
        this.maxLife = maxLife;
        this.statuses = statuses;
    }
}
