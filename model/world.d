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
immutable class World
{
    /**
     * Returns: Возвращает номер текущего тика.
     */
    int tickIndex;
    /**
     * Returns: Возвращает базовую длительность игры в тиках. Реальная длительность может отличаться от этого значения в
     * меньшую сторону. Эквивалентно `game.tickCount`.
     */
    int tickCount;
    /**
     * Returns: Возвращает ширину мира.
     */
    double width;
    /**
     * Returns: Возвращает высоту мира.
     */
    double height;
    /**
     * Returns: Возвращает список игроков (в случайном порядке).
     * После каждого тика объекты, задающие игроков, пересоздаются.
     */
    Player [] players;
    /**
     * Returns: Возвращает список видимых волшебников (в случайном порядке).
     * После каждого тика объекты, задающие волшебников, пересоздаются.
     */
    Wizard [] wizards;
    /**
     * Returns: Возвращает список видимых последователей (в случайном порядке).
     * После каждого тика объекты, задающие последователей, пересоздаются.
     */
    Minion [] minions;
    /**
     * Returns: Возвращает список видимых магических снарядов (в случайном порядке).
     * После каждого тика объекты, задающие снаряды, пересоздаются.
     */
    Projectile [] projectiles;
    /**
     * Returns: Возвращает список видимых бонусов (в случайном порядке).
     * После каждого тика объекты, задающие бонусы, пересоздаются.
     */
    Bonus [] bonuses;
    /**
     * Returns: Возвращает список видимых строений (в случайном порядке).
     * После каждого тика объекты, задающие строения, пересоздаются.
     */
    Building [] buildings;
    /**
     * Returns: Возвращает список видимых деревьев (в случайном порядке).
     * После каждого тика объекты, задающие деревья, пересоздаются.
     */
    Tree [] trees;

    this (
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
        this.players = players;
        this.wizards = wizards;
        this.minions = minions;
        this.projectiles = projectiles;
        this.bonuses = bonuses;
        this.buildings = buildings;
        this.trees = trees;
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
