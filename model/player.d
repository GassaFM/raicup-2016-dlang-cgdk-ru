module model.player;

import model.faction;

/**
 * Содержит данные о текущем состоянии игрока.
 */
class Player
{
    /**
     * Returns: Возвращает уникальный идентификатор игрока.
     */
    immutable long id;
    /**
     * Returns: Возвращает `true` в том и только в том случае, если этот игрок ваш.
     */
    immutable bool me;
    /**
     * Returns: Возвращает имя игрока.
     */
    immutable string name;
    /**
     * Returns: Возвращает специальный флаг --- показатель того, что стратегия игрока <<упала>>.
     * Более подробную информацию можно найти в документации к игре.
     */
    immutable bool strategyCrashed;
    /**
     * Returns: Возвращает количество баллов, набранное игроком.
     */
    immutable int score;
    /**
     * Returns: Возвращает фракцию, к которой принадлежит данный игрок.
     */
    immutable Faction faction;

    immutable this (
        long id,
        bool me,
        string name,
        bool strategyCrashed,
        int score,
        immutable (Faction) faction)
    {
        this.id = id;
        this.me = me;
        this.name = name;
        this.strategyCrashed = strategyCrashed;
        this.score = score;
        this.faction = faction;
    }
}
