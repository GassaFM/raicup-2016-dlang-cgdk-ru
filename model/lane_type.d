module model.lane_type;

/**
 * Тип дорожки.
 */
enum LaneType : byte
{
    /**
     * Значение по умолчанию.
     */
    unknown = -1,

    /**
     * Верхняя. Проходит через левый нижний, левый верхний и правый верхний углы карты.
     */
    top,

    /**
     * Центральная. Напрямую соединяет левый нижний и правый верхний углы карты.
     */
    middle,

    /**
     * Нижняя. Проходит через левый нижний, правый нижний и правый верхний углы карты.
     */
    bottom
}
