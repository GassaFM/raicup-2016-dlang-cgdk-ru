module model.status;

import model.status_type;

/**
 * Магический статус, влияющий на живого юнита.
 */
immutable class Status
{
    /**
     * Returns: Возвращает уникальный идентификатор статуса.
     */
    long id;
    /**
     * Returns: Возвращает тип магического статуса.
     */
    StatusType type;
    /**
     * Returns: Возвращает идентификатор волшебника, наложившего данный статус, или `-1`.
     */
    long wizardId;
    /**
     * Returns: Возвращает идентификатор игрока, волшебник которого наложил данный статус, или `-1`.
     */
    long playerId;
    /**
     * Returns: Возвращает оставшуюся длительность действия статуса.
     */
    int remainingDurationTicks;

    this (
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
