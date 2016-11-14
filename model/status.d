module model.status;

import model.status_type;

/**
 * Магический статус, влияющий на живого юнита.
 */
class Status
{
    /**
     * Returns: Возвращает уникальный идентификатор статуса.
     */
    immutable long id;
    /**
     * Returns: Возвращает тип магического статуса.
     */
    immutable StatusType type;
    /**
     * Returns: Возвращает идентификатор волшебника, наложившего данный статус, или `-1`.
     */
    immutable long wizardId;
    /**
     * Returns: Возвращает идентификатор игрока, волшебник которого наложил данный статус, или `-1`.
     */
    immutable long playerId;
    /**
     * Returns: Возвращает оставшуюся длительность действия статуса.
     */
    immutable int remainingDurationTicks;

    immutable this (
        long id,
        immutable (StatusType) type,
        long wizardId,
        long playerId,
        int remainingDurationTicks)
    {
        this.id = id;
        this.type = type;
        this.wizardId = wizardId;
        this.playerId = playerId;
        this.remainingDurationTicks = remainingDurationTicks;
    }
}
