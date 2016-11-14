module model.wizard;

import model.status;
import model.living_unit;
import model.skill_type;
import model.faction;
import model.message;

/**
 * Класс, определяющий волшебника. Содержит также все свойства живого юнита.
 */
class Wizard : LivingUnit
{
    /**
     * Returns: Возвращает идентификатор игрока, которому принадлежит волшебник.
     */
    immutable long ownerPlayerId;
    /**
     * Returns: Возвращает `true` в том и только том случае, если этот волшебник ваш.
     */
    immutable bool me;
    /**
     * Returns: Возвращает текущее количество магической энергии волшебника.
     */
    immutable int mana;
    /**
     * Returns: Возвращает максимальное количество магической энергии волшебника.
     */
    immutable int maxMana;
    /**
     * Returns: Возвращает максимальное расстояние (от центра до центра),
     * на котором данный волшебник обнаруживает другие объекты.
     */
    immutable double visionRange;
    /**
     * Returns: Возвращает максимальное расстояние (от центра волшебника),
     * которое может преодолеть выпущенный им магический снаряд.
     * $(BR)
     * Также является максимально возможной дальностью применения заклинаний, накладывающих на цель магический статус
     * (`Haste` и `Shield`).
     */
    immutable double castRange;
    /**
     * Returns: Возвращает количество очков опыта, полученное волшебником в процессе игры.
     */
    immutable int xp;
    /**
     * Returns: Возвращает текущий уровень волшебника.
     * $(BR)
     * Начальный уровень каждого волшебника равен `0`, а максимальный --- `game.levelUpXpValues.length`.
     * $(BR)
     * В некоторых режимах игры рост уровня волшебника может быть заблокирован.
     */
    immutable int level;
    /**
     * Returns: Возвращает умения, изученные волшебником.
     */
    immutable SkillType [] skills;
    /**
     * Returns: Возвращает количество тиков, оставшееся до любого следующего действия.
     * $(BR)
     * Для совершения произвольного действия `actionType` необходимо, чтобы оба значения
     * `remainingActionCooldownTicks` и `remainingCooldownTicksByAction[actionType.ordinal ()]` были равны
     * нулю.
     */
    immutable int remainingActionCooldownTicks;
    /**
     * Returns: Возвращает массив целых неотрицательных чисел. Каждая ячейка массива содержит значение количества тиков,
     * оставшегося до совершения следующего действия с соответствующим индексом.
     * $(BR)
     * Например, `remainingCooldownTicksByAction[0]` соответствует действию `None` и всегда равно нулю.
     * `remainingCooldownTicksByAction[1]` соответствует действию `Staff` и равно количеству тиков,
     * оставшемуся до совершения данного действия. `remainingCooldownTicksByAction[2]` соответствует действию
     * `MagicMissile` и так далее.
     * $(BR)
     * Для совершения произвольного действия `actionType` необходимо, чтобы оба значения
     * `remainingActionCooldownTicks` и `remainingCooldownTicksByAction[actionType.ordinal ()]` были равны
     * нулю.
     */
    immutable int [] remainingCooldownTicksByAction;
    /**
     * Returns: Возвращает `true` в том и только том случае, если этот волшебник является верховным.
     * $(BR)
     * Количество верховных волшебников в каждой фракции строго равно одному.
     */
    immutable bool master;
    /**
     * Returns: Возвращает сообщения, предназначенные данному волшебнику, если есть право на их просмотр.
     * $(BR)
     * Стратегия может просматривать только сообщения, адресатом которых является управляемый ею волшебник.
     */
    immutable Message [] messages;

    immutable this (
        long id,
        double x,
        double y,
        double speedX,
        double speedY,
        double angle,
        immutable (Faction) faction,
        double radius,
        int life,
        int maxLife,
        immutable (Status) [] statuses,
        long ownerPlayerId,
        bool me,
        int mana,
        int maxMana,
        double visionRange,
        double castRange,
        int xp,
        int level,
        immutable (SkillType) [] skills,
        int remainingActionCooldownTicks,
        int [] remainingCooldownTicksByAction,
        bool master,
        immutable (Message) [] messages)
    {
        super (id, x, y, speedX, speedY, angle, faction, radius, life, maxLife, statuses);

        this.ownerPlayerId = ownerPlayerId;
        this.me = me;
        this.mana = mana;
        this.maxMana = maxMana;
        this.visionRange = visionRange;
        this.castRange = castRange;
        this.xp = xp;
        this.level = level;
        this.skills = skills.idup;
        this.remainingActionCooldownTicks = remainingActionCooldownTicks;
        this.remainingCooldownTicksByAction = remainingCooldownTicksByAction.idup;
        this.master = master;
        this.messages = messages.idup;
    }
}
