module model.building_type;

/**
 * Тип строения.
 */
enum BuildingType : byte
{
    /**
     * Значение по умолчанию.
     */
    unknown = -1,

    /**
     * Охранная башня.
     */
    guardianTower,

    /**
     * База фракции.
     */
    factionBase
}
