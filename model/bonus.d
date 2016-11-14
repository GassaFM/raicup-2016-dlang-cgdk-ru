module model.bonus;

import model.bonus_type;
import model.circular_unit;
import model.faction;

/**
 * Класс, определяющий бонус --- неподвижный полезный объект. Содержит также все свойства круглого юнита.
 */
class Bonus : CircularUnit
{
    /**
     * Returns: Возвращает тип бонуса.
     */
    immutable BonusType type;

    immutable this (
        long id,
        double x,
        double y,
        double speedX,
        double speedY,
        double angle,
        immutable (Faction) faction,
        double radius,
        immutable (BonusType) type)
    {
        super (id, x, y, speedX, speedY, angle, faction, radius);

        this.type = type;
    }
}
