module model.skill_type;

/**
 * Тип умения. Изучение умений может быть доступно не во всех режимах игры (смотрите документацию к
 * `game.skillsEnabled`).
 * $(BR)
 * Умения делятся на три категории: активные, пассивные и ауры.
 * $(UL
 * $(LI
 * Активные умения наделяют волшебника способностью использовать определённое действие, недоступное ранее.
 * )
 * $(LI
 * Пассивные умения действуют постоянно, улучшая одну из характеристик волшебника на некоторое значение. При наличии
 * нескольких пассивных умений, влияющих на одну характеристику, учитывается только то, которое даёт максимальный
 * эффект.
 * )
 * $(LI
 * Ауры действуют постоянно, улучшая на некоторое значение одну из характеристик самого волшебника, а также всех союзных
 * волшебников на расстоянии, не превышающем `game.auraSkillRange`. При наличии нескольких аур, влияющих на одну
 * характеристику, учитывается только та, которая даёт максимальный эффект.
 * )
 * )
 */
enum SkillType : byte
{
    /**
     * Пассивное умение. Увеличивает максимально возможную дальность полёта магического снаряда, а также дальность
     * применения магических статусов на `game.rangeBonusPerSkillLevel`.
     */
    RangeBonusPassive1,

    /**
     * Аура. Увеличивает максимально возможную дальность полёта магического снаряда, а также дальность
     * применения магических статусов на `game.rangeBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `RangeBonusPassive1`.
     */
    RangeBonusAura1,

    /**
     * Пассивное умение. Увеличивает максимально возможную дальность полёта магического снаряда, а также дальность
     * применения магических статусов на `2.0 * game.rangeBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `RangeBonusAura1`.
     */
    RangeBonusPassive2,

    /**
     * Аура. Увеличивает максимально возможную дальность полёта магического снаряда, а также дальность
     * применения магических статусов на `2.0 * game.rangeBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `RangeBonusPassive2`.
     */
    RangeBonusAura2,

    /**
     * Пассивное умение. Убирает задержку на примение действия `MagicMissile`.
     * Общая задержка на действия волшебника `game.wizardActionCooldownTicks` всё ещё применяется.
     * $(BR)
     * Требуется предварительно изучить умение `RangeBonusAura2`.
     */
    AdvancedMagicMissile,

    /**
     * Пассивное умение. Увеличивает урон, наносимый при прямом попадании магического снаряда, на
     * `game.magicalDamageBonusPerSkillLevel`.
     */
    MagicalDamageBonusPassive1,

    /**
     * Аура. Увеличивает урон, наносимый при прямом попадании магического снаряда, на
     * `game.magicalDamageBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `MagicalDamageBonusPassive1`.
     */
    MagicalDamageBonusAura1,

    /**
     * Пассивное умение. Увеличивает урон, наносимый при прямом попадании магического снаряда, на
     * `2.0 * game.magicalDamageBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `MagicalDamageBonusAura1`.
     */
    MagicalDamageBonusPassive2,

    /**
     * Аура. Увеличивает урон, наносимый при прямом попадании магического снаряда, на
     * `2.0 * game.magicalDamageBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `MagicalDamageBonusPassive2`.
     */
    MagicalDamageBonusAura2,

    /**
     * Активное умение. Позволяет волшебнику использовать действие `FrostBolt`.
     * $(BR)
     * Требуется предварительно изучить умение `MagicalDamageBonusAura2`.
     */
    FrostBolt,

    /**
     * Пассивное умение. Увеличивает урон, наносимый при ударе посохом, на `game.staffDamageBonusPerSkillLevel`.
     */
    StaffDamageBonusPassive1,

    /**
     * Аура. Увеличивает урон, наносимый при ударе посохом, на `game.staffDamageBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `StaffDamageBonusPassive1`.
     */
    StaffDamageBonusAura1,

    /**
     * Пассивное умение. Увеличивает урон, наносимый при ударе посохом, на
     * `2.0 * game.staffDamageBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `StaffDamageBonusAura1`.
     */
    StaffDamageBonusPassive2,

    /**
     * Аура. Увеличивает урон, наносимый при ударе посохом, на `2.0 * game.staffDamageBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `StaffDamageBonusPassive2`.
     */
    StaffDamageBonusAura2,

    /**
     * Активное умение. Позволяет волшебнику использовать действие `Fireball`.
     * $(BR)
     * Требуется предварительно изучить умение `StaffDamageBonusAura2`.
     */
    Fireball,

    /**
     * Пассивное умение. Увеличивает скорость перемещения в `1.0 + game.movementBonusFactorPerSkillLevel` раз.
     * $(BR)
     * Увеличение скорости от изучения пассивных умений и увеличение скорости в результате действия аур аддитивны.
     * Таким образом, умения `MovementBonusFactorPassive2` и `MovementBonusFactorAura2` суммарно
     * увеличат скорость перемещения в `1.0 + 4.0 * game.movementBonusFactorPerSkillLevel` раз.
     */
    MovementBonusFactorPassive1,

    /**
     * Аура. Увеличивает скорость перемещения в `1.0 + game.movementBonusFactorPerSkillLevel` раз.
     * $(BR)
     * Требуется предварительно изучить умение `MovementBonusFactorPassive1`.
     */
    MovementBonusFactorAura1,

    /**
     * Пассивное умение. Увеличивает скорость перемещения в `1.0 + 2.0 * game.movementBonusFactorPerSkillLevel`
     * раз.
     * $(BR)
     * Требуется предварительно изучить умение `MovementBonusFactorAura1`.
     */
    MovementBonusFactorPassive2,

    /**
     * Аура. Увеличивает скорость перемещения в `1.0 + 2.0 * game.movementBonusFactorPerSkillLevel` раз.
     * $(BR)
     * Требуется предварительно изучить умение `MovementBonusFactorPassive2`.
     */
    MovementBonusFactorAura2,

    /**
     * Активное умение. Позволяет волшебнику использовать действие `Haste`.
     * $(BR)
     * Требуется предварительно изучить умение `MovementBonusFactorAura2`.
     */
    Haste,

    /**
     * Пассивное умение. Уменьшает урон, получаемый при прямом попадании магического снаряда, на
     * `game.magicalDamageAbsorptionPerSkillLevel`.
     */
    MagicalDamageAbsorptionPassive1,

    /**
     * Аура. Уменьшает урон, получаемый при прямом попадании магического снаряда, на
     * `game.magicalDamageAbsorptionPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `MagicalDamageAbsorptionPassive1`.
     */
    MagicalDamageAbsorptionAura1,

    /**
     * Пассивное умение. Уменьшает урон, получаемый при прямом попадании магического снаряда, на
     * `2.0 * game.magicalDamageAbsorptionPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `MagicalDamageAbsorptionAura1`.
     */
    MagicalDamageAbsorptionPassive2,

    /**
     * Аура. Уменьшает урон, получаемый при прямом попадании магического снаряда, на
     * `2.0 * game.magicalDamageAbsorptionPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `MagicalDamageAbsorptionPassive2`.
     */
    MagicalDamageAbsorptionAura2,

    /**
     * Активное умение. Позволяет волшебнику использовать действие `Shield`.
     * $(BR)
     * Требуется предварительно изучить умение `MagicalDamageAbsorptionAura2`.
     */
    Shield
}
