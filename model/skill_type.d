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
    rangeBonusPassive1,

    /**
     * Аура. Увеличивает максимально возможную дальность полёта магического снаряда, а также дальность
     * применения магических статусов на `game.rangeBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `rangeBonusPassive1`.
     */
    rangeBonusAura1,

    /**
     * Пассивное умение. Увеличивает максимально возможную дальность полёта магического снаряда, а также дальность
     * применения магических статусов на `2.0 * game.rangeBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `rangeBonusAura1`.
     */
    rangeBonusPassive2,

    /**
     * Аура. Увеличивает максимально возможную дальность полёта магического снаряда, а также дальность
     * применения магических статусов на `2.0 * game.rangeBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `rangeBonusPassive2`.
     */
    rangeBonusAura2,

    /**
     * Пассивное умение. Убирает задержку на примение действия `magicMissile`.
     * Общая задержка на действия волшебника `game.wizardActionCooldownTicks` всё ещё применяется.
     * $(BR)
     * Требуется предварительно изучить умение `rangeBonusAura2`.
     */
    advancedMagicMissile,

    /**
     * Пассивное умение. Увеличивает урон, наносимый при прямом попадании магического снаряда, на
     * `game.magicalDamageBonusPerSkillLevel`.
     */
    magicalDamageBonusPassive1,

    /**
     * Аура. Увеличивает урон, наносимый при прямом попадании магического снаряда, на
     * `game.magicalDamageBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `magicalDamageBonusPassive1`.
     */
    magicalDamageBonusAura1,

    /**
     * Пассивное умение. Увеличивает урон, наносимый при прямом попадании магического снаряда, на
     * `2.0 * game.magicalDamageBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `magicalDamageBonusAura1`.
     */
    magicalDamageBonusPassive2,

    /**
     * Аура. Увеличивает урон, наносимый при прямом попадании магического снаряда, на
     * `2.0 * game.magicalDamageBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `magicalDamageBonusPassive2`.
     */
    magicalDamageBonusAura2,

    /**
     * Активное умение. Позволяет волшебнику использовать действие `frostBolt`.
     * $(BR)
     * Требуется предварительно изучить умение `magicalDamageBonusAura2`.
     */
    frostBolt,

    /**
     * Пассивное умение. Увеличивает урон, наносимый при ударе посохом, на `game.staffDamageBonusPerSkillLevel`.
     */
    staffDamageBonusPassive1,

    /**
     * Аура. Увеличивает урон, наносимый при ударе посохом, на `game.staffDamageBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `staffDamageBonusPassive1`.
     */
    staffDamageBonusAura1,

    /**
     * Пассивное умение. Увеличивает урон, наносимый при ударе посохом, на
     * `2.0 * game.staffDamageBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `staffDamageBonusAura1`.
     */
    staffDamageBonusPassive2,

    /**
     * Аура. Увеличивает урон, наносимый при ударе посохом, на `2.0 * game.staffDamageBonusPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `staffDamageBonusPassive2`.
     */
    staffDamageBonusAura2,

    /**
     * Активное умение. Позволяет волшебнику использовать действие `fireball`.
     * $(BR)
     * Требуется предварительно изучить умение `staffDamageBonusAura2`.
     */
    fireball,

    /**
     * Пассивное умение. Увеличивает скорость перемещения в `1.0 + game.movementBonusFactorPerSkillLevel` раз.
     * $(BR)
     * Увеличение скорости от изучения пассивных умений и увеличение скорости в результате действия аур аддитивны.
     * Таким образом, умения `movementBonusFactorPassive2` и `movementBonusFactorAura2` суммарно
     * увеличат скорость перемещения в `1.0 + 4.0 * game.movementBonusFactorPerSkillLevel` раз.
     */
    movementBonusFactorPassive1,

    /**
     * Аура. Увеличивает скорость перемещения в `1.0 + game.movementBonusFactorPerSkillLevel` раз.
     * $(BR)
     * Требуется предварительно изучить умение `movementBonusFactorPassive1`.
     */
    movementBonusFactorAura1,

    /**
     * Пассивное умение. Увеличивает скорость перемещения в `1.0 + 2.0 * game.movementBonusFactorPerSkillLevel`
     * раз.
     * $(BR)
     * Требуется предварительно изучить умение `movementBonusFactorAura1`.
     */
    movementBonusFactorPassive2,

    /**
     * Аура. Увеличивает скорость перемещения в `1.0 + 2.0 * game.movementBonusFactorPerSkillLevel` раз.
     * $(BR)
     * Требуется предварительно изучить умение `movementBonusFactorPassive2`.
     */
    movementBonusFactorAura2,

    /**
     * Активное умение. Позволяет волшебнику использовать действие `haste`.
     * $(BR)
     * Требуется предварительно изучить умение `movementBonusFactorAura2`.
     */
    haste,

    /**
     * Пассивное умение. Уменьшает урон, получаемый при прямом попадании магического снаряда, на
     * `game.magicalDamageAbsorptionPerSkillLevel`.
     */
    magicalDamageAbsorptionPassive1,

    /**
     * Аура. Уменьшает урон, получаемый при прямом попадании магического снаряда, на
     * `game.magicalDamageAbsorptionPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `magicalDamageAbsorptionPassive1`.
     */
    magicalDamageAbsorptionAura1,

    /**
     * Пассивное умение. Уменьшает урон, получаемый при прямом попадании магического снаряда, на
     * `2.0 * game.magicalDamageAbsorptionPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `magicalDamageAbsorptionAura1`.
     */
    magicalDamageAbsorptionPassive2,

    /**
     * Аура. Уменьшает урон, получаемый при прямом попадании магического снаряда, на
     * `2.0 * game.magicalDamageAbsorptionPerSkillLevel`.
     * $(BR)
     * Требуется предварительно изучить умение `magicalDamageAbsorptionPassive2`.
     */
    magicalDamageAbsorptionAura2,

    /**
     * Активное умение. Позволяет волшебнику использовать действие `shield`.
     * $(BR)
     * Требуется предварительно изучить умение `magicalDamageAbsorptionAura2`.
     */
    shield
}
