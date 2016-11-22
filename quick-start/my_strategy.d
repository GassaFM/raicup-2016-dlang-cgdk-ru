// Это стратегия из раздела <<Быстрый старт>>: http://russianaicup.ru/p/quick.
// Чтобы использовать её, сделайте резервную копию своего файла
// ../my_strategy.d, а затем скопируйте этот файл на его место.
module my_strategy;

import std.algorithm;
import std.array;
import std.math;
import std.random;
import std.range;
import std.typecons;

import model;
import strategy;

/**
 * Класс, в котором должна быть реализована стратегия.
 */
final class MyStrategy : Strategy
{
    /**
     * Основной метод стратегии, осуществляющий управление волшебником.
     * Вызывается каждый тик для каждого волшебника.
     *
     * Params:
     * self  = Волшебник, которым данный метод будет осуществлять управление.
     * world = Текущее состояние мира.
     * game  = Различные игровые константы.
     * move  = Результатом работы метода является изменение полей
     *         данного объекта.
     */
    void move (immutable Wizard self, immutable World world,
        immutable Game game, Move move)
    {
        initializeStrategy (self, game);
        initializeTick (self, world, game, move);

        // Постоянно двигаемся из стороны в сторону,
        // чтобы по нам было сложнее попасть.
        // Считаете, что сможете придумать более эффективный
        // алгоритм уклонения? Попробуйте! ;)
        move.strafeSpeed = game.wizardStrafeSpeed *
            (uniform (0, 2, random) ? +1 : -1);

        // Если осталось мало жизненной энергии,
        // отступаем к предыдущей ключевой точке на линии.
        if (self.life < self.maxLife * lowHPFactor)
        {
            goTo (getPreviousWaypoint ());
            return;
        }

        auto nearestTarget = getNearestTarget ();

        // Если видим противника ...
        if (nearestTarget !is null)
        {
            auto distance = self.getDistanceTo (nearestTarget);

            // ... и он в пределах досягаемости наших заклинаний, ...
            if (distance <= self.castRange)
            {
                auto angle = self.getAngleTo (nearestTarget);

                // ... то поворачиваемся к цели.
                move.turn = angle;

                // Если цель перед нами, ...
                if (abs (angle) < game.staffSector * 0.5)
                {
                    // ... то атакуем.
                    move.action = ActionType.magicMissile;
                    move.castAngle = angle;
                    move.minCastDistance = distance -
                        nearestTarget.radius + game.magicMissileRadius;
                }

                return;
            }
        }

        // Если нет других действий, просто продвигаемся вперёд.
        goTo (getNextWaypoint ());
    }

private:
    static immutable double waypointRadius = 100.0;
    static immutable double lowHPFactor = 0.25;

    /**
     * Ключевые точки для каждой линии,
     * позволяющие упростить управление перемещением волшебника.
     * $(BR)
     * Если всё хорошо, двигаемся к следующей точке и атакуем противников.
     * Если осталось мало жизненной энергии, отступаем к предыдущей точке.
     */
    Point2D [] [LaneType] waypointsByLane;

    Random random;

    LaneType lane;
    Point2D [] waypoints;

    Rebindable !(immutable Wizard) self;
    Rebindable !(immutable World) world;
    Rebindable !(immutable Game) game;
    Move theMove;

    /**
     * Инциализируем стратегию.
     * $(BR)
     * Для этих целей обычно можно использовать конструктор,
     * однако в данном случае мы хотим инициализировать
     * генератор случайных чисел значением, полученным от симулятора игры.
     */
    private void initializeStrategy (immutable Wizard self,
        immutable Game game)
    {
        if (waypointsByLane is null)
        {
            random.seed (cast (uint) (game.randomSeed));

            auto mapSize = game.mapSize;

            waypointsByLane[LaneType.middle] = [
                Point2D (100.0, mapSize - 100.0),
                uniform (0, 2, random) ? Point2D (600.0, mapSize - 200.0) :
                                         Point2D (200.0, mapSize - 600.0),
                Point2D (800.0, mapSize - 800.0),
                Point2D (mapSize - 600.0, 600.0),
            ];

            waypointsByLane[LaneType.top] = [
                Point2D (100.0, mapSize - 100.0),
                Point2D (100.0, mapSize - 400.0),
                Point2D (200.0, mapSize - 800.0),
                Point2D (200.0, mapSize *  0.75),
                Point2D (200.0, mapSize *  0.50),
                Point2D (200.0, mapSize *  0.25),
                Point2D (200.0, 200.0),
                Point2D (mapSize  * 0.25, 200.0),
                Point2D (mapSize  * 0.50, 200.0),
                Point2D (mapSize  * 0.75, 200.0),
                Point2D (mapSize - 200.0, 200.0),
            ];

            waypointsByLane[LaneType.bottom] = [
                Point2D (100.0, mapSize - 100.0),
                Point2D (400.0, mapSize - 100.0),
                Point2D (800.0, mapSize - 200.0),
                Point2D (mapSize *  0.25, mapSize - 200.0),
                Point2D (mapSize *  0.50, mapSize - 200.0),
                Point2D (mapSize *  0.75, mapSize - 200.0),
                Point2D (mapSize - 200.0, mapSize - 200.0),
                Point2D (mapSize - 200.0, mapSize *  0.75),
                Point2D (mapSize - 200.0, mapSize *  0.50),
                Point2D (mapSize - 200.0, mapSize *  0.25),
                Point2D (mapSize - 200.0, 200.0),
            ];

            switch (self.id)
            {
                case 1:
                case 2:
                case 6:
                case 7:
                    lane = LaneType.top;
                    break;
                case 3:
                case 8:
                    lane = LaneType.middle;
                    break;
                case 4:
                case 5:
                case 9:
                case 10:
                    lane = LaneType.bottom;
                    break;
                default:
                    assert (false);
            }

            waypoints = waypointsByLane[lane];

            // Наша стратегия исходит из предположения, что заданные нами
            // ключевые точки упорядочены по убыванию дальности
            // до последней ключевой точки.
            // Сейчас проверка этого факта отключена, однако вы можете
            // написать свою проверку, если решите изменить координаты
            // ключевых точек.

            /*
            Point2D lastWaypoint = waypoints.back;

            if (!waypoints
                .map !(point => -point.getDistanceTo (lastWaypoint))
                .isSorted)
            {
                assert (false);
            }
            */
        }
    }

    /**
     * Сохраняем все входные данные в полях класса для упрощения доступа к ним.
     */
    private void initializeTick (immutable Wizard self, immutable World world,
        immutable Game game, Move move)
    {
        this.self = self;
        this.world = world;
        this.game = game;
        this.theMove = move;
    }

    /**
     * Данный метод предполагает, что все ключевые точки на линии
     * упорядочены по уменьшению дистанции до последней ключевой точки.
     * Перебирая их по порядку, находим первую попавшуюся точку,
     * которая находится ближе к последней точке на линии, чем волшебник.
     * Это и будет следующей ключевой точкой.
     * $(BR)
     * Дополнительно сначала проверяем, не находится ли волшебник
     * достаточно близко к какой-либо из ключевых точек.
     * Если это так, то мы сразу возвращаем следующую ключевую точку.
     */
    Point2D getNextWaypoint ()
    {
        return getWaypoint (waypoints);
    }

    /**
     * Действие данного метода абсолютно идентично действию метода
     * `getNextWaypoint`, если перевернуть массив `waypoints`.
     */
    Point2D getPreviousWaypoint ()
    {
        return getWaypoint (waypoints.retro);
    }

    Point2D getWaypoint (R) (R waypoints)
        if (is (typeof (waypoints.front) == Point2D))
    {
        auto closeWaypoint = waypoints.find !(waypoint =>
            waypoint.getDistanceTo (self) <= waypointRadius).drop (1);
        if (!closeWaypoint.empty)
        {
            return closeWaypoint.front;
        }

        auto lastWaypoint = waypoints.back;

        auto result = waypoints.dropBack (1).find !(waypoint =>
            lastWaypoint.getDistanceTo (waypoint) <
            lastWaypoint.getDistanceTo (self));
        if (!result.empty)
        {
            return result.front;
        }

        return lastWaypoint;
    }

    /**
     * Простейший способ перемещения волшебника.
     */
    void goTo (Point2D point)
    {
        double angle = self.getAngleTo (point.x, point.y);

        theMove.turn = angle;

        if (abs (angle) < game.staffSector * 0.25)
        {
            theMove.speed = game.wizardForwardSpeed;
        }
    }

    /**
     * Находим ближайшую цель для атаки, независимо от
     * её типа и других характеристик.
     */
    immutable (LivingUnit) getNearestTarget ()
    {
        immutable (LivingUnit) [] targets;
        foreach (unit; world.buildings)
        {
            targets ~= cast (immutable LivingUnit) (unit);
        }
        foreach (unit; world.wizards)
        {
            targets ~= cast (immutable LivingUnit) (unit);
        }
        foreach (unit; world.minions)
        {
            targets ~= cast (immutable LivingUnit) (unit);
        }
        auto result = targets
            .filter !(target => target.faction != Faction.neutral &&
                                target.faction != self.faction)
            .minPos !((a, b) =>
            a.getDistanceTo (self) < b.getDistanceTo (self));
        return (result.empty ? null : result.front);
    }
}

/**
 * Вспомогательная структура для хранения позиций на карте.
 */
struct Point2D
{
    double x;
    double y;

    double getDistanceTo (double x, double y) const
    {
        return hypot (this.x - x, this.y - y);
    }

    double getDistanceTo (T) (T point) const
        if (is (typeof (point.x) : double) &&
            is (typeof (point.y) : double))
    {
        return getDistanceTo (point.x, point.y);
    }
}
