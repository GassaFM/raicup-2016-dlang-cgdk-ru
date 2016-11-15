module model.unit;

import model.faction;
import std.math;

/**
 * Базовый класс для определения объектов (<<юнитов>>) на игровом поле.
 */
abstract immutable class Unit
{
    /**
     * Returns: Возвращает уникальный идентификатор объекта.
     */
    long id;
    /**
     * Returns: Возвращает X-координату центра объекта. Ось абсцисс направлена слева направо.
     */
    double x;
    /**
     * Returns: Возвращает Y-координату центра объекта. Ось ординат направлена сверху вниз.
     */
    double y;
    /**
     * Returns: Возвращает X-составляющую скорости объекта. Ось абсцисс направлена слева направо.
     * $(BR)
     * Для юнитов, способных мгновенно менять свою скорость, возвращается значение перемещения за последний тик.
     */
    double speedX;
    /**
     * Returns: Возвращает Y-составляющую скорости объекта. Ось ординат направлена сверху вниз.
     * $(BR)
     * Для юнитов, способных мгновенно менять свою скорость, возвращается значение перемещения за последний тик.
     */
    double speedY;
    /**
     * Returns: Возвращает угол поворота объекта в радианах. Нулевой угол соответствует направлению оси абсцисс.
     * Положительные значения соответствуют повороту по часовой стрелке.
     */
    double angle;
    /**
     * Returns: Возвращает фракцию, к которой принадлежит данный юнит.
     */
    Faction faction;

    protected this (
        long id,
        double x,
        double y,
        double speedX,
        double speedY,
        double angle,
        immutable Faction faction)
    {
        this.id = id;
        this.x = x;
        this.y = y;
        this.speedX = speedX;
        this.speedY = speedY;
        this.angle = angle;
        this.faction = faction;
    }

    /**
     * Params:
     *   x = X-координата точки.
     *   y = Y-координата точки.
     * Returns: Возвращает ориентированный угол [`-PI`, `PI`] между направлением
     * данного объекта и вектором из центра данного объекта к указанной точке.
     */
    double getAngleTo (
        double x,
        double y) const
    {
        double absoluteAngleTo = atan2 (y - this.y, x - this.x);
        double relativeAngleTo = absoluteAngleTo - angle;

        while (relativeAngleTo > PI) {
            relativeAngleTo -= 2.0 * PI;
        }

        while (relativeAngleTo < -PI) {
            relativeAngleTo += 2.0 * PI;
        }

        return relativeAngleTo;
    }

    /**
     * Params:
     *   unit = Объект, к центру которого необходимо определить угол.
     * Returns: Возвращает ориентированный угол [`-PI`, `PI`] между направлением
     * данного объекта и вектором из центра данного объекта к центру указанного объекта.
     */
    double getAngleTo (
        immutable Unit unit) const
    {
        return getAngleTo (unit.x, unit.y);
    }

    /**
     * Params:
     *   x = X-координата точки.
     *   y = Y-координата точки.
     * Returns: Возвращает расстояние до точки от центра данного объекта.
     */
    double getDistanceTo (
        double x,
        double y) const
    {
        return hypot (x - this.x, y - this.y);
    }

    /**
     * Params:
     *   unit = Объект, до центра которого необходимо определить расстояние.
     * Returns: Возвращает расстояние от центра данного объекта до центра указанного объекта.
     */
    double getDistanceTo (
        immutable Unit unit) const
    {
        return getDistanceTo (unit.x, unit.y);
    }
}
