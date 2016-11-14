module model.world;

import model.tree;
import model.wizard;
import model.player;
import model.building;
import model.bonus;
import model.minion;
import model.projectile;

/**
 * Этот класс описывает игровой мир. Содержит также описания всех игроков и игровых объектов (<<юнитов>>).
 */
class World
{
    /**
     * Returns: Возвращает номер текущего тика.
     */
    immutable int tickIndex;
    /**
     * Returns: Возвращает базовую длительность игры в тиках. Реальная длительность может отличаться от этого значения в
     * меньшую сторону. Эквивалентно `game.tickCount`.
     */
    immutable int tickCount;
    /**
     * Returns: Возвращает ширину мира.
     */
    immutable double width;
    /**
     * Returns: Возвращает высоту мира.
     */
    immutable double height;
    /**
     * Returns: Возвращает список игроков (в случайном порядке).
     * После каждого тика объекты, задающие игроков, пересоздаются.
     */
    immutable Player [] players;
    /**
     * Returns: Возвращает список видимых волшебников (в случайном порядке).
     * После каждого тика объекты, задающие волшебников, пересоздаются.
     */
    immutable Wizard [] wizards;
    /**
     * Returns: Возвращает список видимых последователей (в случайном порядке).
     * После каждого тика объекты, задающие последователей, пересоздаются.
     */
    immutable Minion [] minions;
    /**
     * Returns: Возвращает список видимых магических снарядов (в случайном порядке).
     * После каждого тика объекты, задающие снаряды, пересоздаются.
     */
    immutable Projectile [] projectiles;
    /**
     * Returns: Возвращает список видимых бонусов (в случайном порядке).
     * После каждого тика объекты, задающие бонусы, пересоздаются.
     */
    immutable Bonus [] bonuses;
    /**
     * Returns: Возвращает список видимых строений (в случайном порядке).
     * После каждого тика объекты, задающие строения, пересоздаются.
     */
    immutable Building [] buildings;
    /**
     * Returns: Возвращает список видимых деревьев (в случайном порядке).
     * После каждого тика объекты, задающие деревья, пересоздаются.
     */
    immutable Tree [] trees;

    immutable this (
        int tickIndex,
        int tickCount,
        double width,
        double height,
        immutable (Player) [] players,
        immutable (Wizard) [] wizards,
        immutable (Minion) [] minions,
        immutable (Projectile) [] projectiles,
        immutable (Bonus) [] bonuses,
        immutable (Building) [] buildings,
        immutable (Tree) [] trees)
    {
        this.tickIndex = tickIndex;
        this.tickCount = tickCount;
        this.width = width;
        this.height = height;
        this.players = players.idup;
        this.wizards = wizards.idup;
        this.minions = minions.idup;
        this.projectiles = projectiles.idup;
        this.bonuses = bonuses.idup;
        this.buildings = buildings.idup;
        this.trees = trees.idup;
    }

    /**
     * Returns: Возвращает вашего игрока.
     */
    immutable (Player) getMyPlayer () const
    {
        foreach (immutable player; players)
        {
            if (player.me)
            {
                return player;
            }
        }

        return null;
    }
}
