module model.game;

/**
 * Предоставляет доступ к различным игровым константам.
 */
class Game
{
    /**
     * Returns: Возвращает некоторое число, которое ваша стратегия может использовать для инициализации генератора
     * случайных чисел. Данное значение имеет рекомендательный характер, однако позволит более точно воспроизводить
     * прошедшие игры.
     */
    immutable long randomSeed;
    /**
     * Returns: Возвращает базовую длительность игры в тиках. Реальная длительность может отличаться от этого значения в
     * меньшую сторону. Эквивалентно `world.tickCount`.
     */
    immutable int tickCount;
    /**
     * Returns: Возвращает размер (ширину и высоту) карты.
     */
    immutable double mapSize;
    /**
     * Returns: Возвращает `true`, если и только если в данной игре волшебники могут повышать свой уровень
     * (накапливая опыт) и изучать новые умения.
     */
    immutable bool skillsEnabled;
    /**
     * Returns: Возвращает `true`, если и только если верховные волшебники в данной игре могут передавать
     * низкоуровневые сообщения другим волшебникам своей фракции.
     */
    immutable bool rawMessagesEnabled;
    /**
     * Returns: Возвращает коэффициент урона, наносимого волшебниками одной фракции друг другу в результате
     * дружественного огня.
     * $(BR)
     * Значение зависит от режима игры, но не может выходить за границы интервала от `0.0` до `1.0`.
     * $(BR)
     * Вне зависимости от режима игры, волшебники не могут наносить урон союзным миньонам и структурам.
     */
    immutable double friendlyFireDamageFactor;
    /**
     * Returns: Возвращает коэффициент опыта, получаемого волшебником при нанесении урона строениям противоположной
     * фракции.
     */
    immutable double buildingDamageScoreFactor;
    /**
     * Returns: Возвращает коэффициент опыта, получаемого волшебником за разрушение строения противоположной фракции.
     * $(BR)
     * Применяется к максимальному количеству жизненной энергии строения.
     */
    immutable double buildingEliminationScoreFactor;
    /**
     * Returns: Возвращает коэффициент опыта, получаемого волшебником при нанесении урона миньонам другой фракции.
     */
    immutable double minionDamageScoreFactor;
    /**
     * Returns: Возвращает коэффициент опыта, получаемого волшебником за уничтожение миньона другой фракции.
     * $(BR)
     * Применяется к максимальному количеству жизненной энергии миньона.
     */
    immutable double minionEliminationScoreFactor;
    /**
     * Returns: Возвращает коэффициент опыта, получаемого волшебником при нанесении урона волшебникам противоположной
     * фракции.
     */
    immutable double wizardDamageScoreFactor;
    /**
     * Returns: Возвращает коэффициент опыта, получаемого волшебником за разрушение телесной оболочки волшебника
     * противоположной фракции.
     * $(BR)
     * Применяется к максимальному количеству жизненной энергии волшебника.
     */
    immutable double wizardEliminationScoreFactor;
    /**
     * Returns: Возвращает мультипликатор опыта, применяемый в случае уничтожения юнита противника при участии двух или
     * более волшебников.
     * $(BR)
     * После применения мультипликатора количество опыта округляется вниз до ближайшего целого значения.
     */
    immutable double teamWorkingScoreFactor;
    /**
     * Returns: Возвращает количество баллов, получаемых всеми игроками фракции в случае победы --- разрушения базы
     * противоположной фракции.
     */
    immutable int victoryScore;
    /**
     * Returns: Возвращает максимальное расстояние, на котором волшебник получает опыт при уничтожении союзником юнита
     * другой фракции.
     * $(BR)
     * При уничтожении противника опыт равномерно распределяется между всеми волшебниками, находящимися на расстоянии от
     * цели, на превышающем `scoreGainRange`, а также юнитом, нанёсшим урон, если это тоже волшебник.
     * $(BR)
     * При нанесении противнику урона, не приводящему к уничтожению юнита, данный параметр не применяется, а опыт
     * полностью достаётся атакующему волшебнику. В случае атаки миньона или строения опыт не достаётся никому.
     * $(BR)
     * Учитывается расстояние между центрами юнитов.
     */
    immutable double scoreGainRange;
    /**
     * Returns: Возвращает максимально возможную длину низкоуровневого сообщения.
     * $(BR)
     * Сообщения, длина которых превышает указанное значение, будут проигнорированы.
     */
    immutable int rawMessageMaxLength;
    /**
     * Returns: Возвращает скорость отправки сообщения.
     * $(BR)
     * Если текстовая часть сообщения пуста, то адресат получит его уже в следующий игровой тик. В противном случае,
     * момент получения сообщения будет отложен на `ceil (message.rawMessage.length / rawMessageTransmissionSpeed)`
     * игровых тиков.
     */
    immutable double rawMessageTransmissionSpeed;
    /**
     * Returns: Возвращает радиус волшебника.
     */
    immutable double wizardRadius;
    /**
     * Returns: Возвращает базовую дальность заклинаний волшебника.
     * $(BR)
     * Эффективная дальность (`wizard.castRange`) может быть выше в результате действия некоторых аур и/или
     * изучения волшебником некоторых умений.
     */
    immutable double wizardCastRange;
    /**
     * Returns: Возвращает максимальное расстояние (от центра до центра), на котором волшебник обнаруживает другие
     * объекты.
     */
    immutable double wizardVisionRange;
    /**
     * Returns: Возвращает базовое ограничение скорости волшебника при движении вперёд.
     * $(BR)
     * Эффективное ограничение может быть выше в результате действия некоторых аур и/или изучения волшебником некоторых
     * умений, а также в результате действия статуса `Hastened`.
     */
    immutable double wizardForwardSpeed;
    /**
     * Returns: Возвращает базовое ограничение скорости волшебника при движении назад.
     * $(BR)
     * Эффективное ограничение может быть выше в результате действия некоторых аур и/или изучения волшебником некоторых
     * умений, а также в результате действия статуса `Hastened`.
     */
    immutable double wizardBackwardSpeed;
    /**
     * Returns: Возвращает базовое ограничение скорости волшебника при движении боком.
     * $(BR)
     * Эффективное ограничение может быть выше в результате действия некоторых аур и/или изучения волшебником некоторых
     * умений, а также в результате действия статуса `Hastened`.
     */
    immutable double wizardStrafeSpeed;
    /**
     * Returns: Возвращает максимальное значение жизненной энергии волшебника на уровне `0`.
     */
    immutable int wizardBaseLife;
    /**
     * Returns: Возвращает прирост жизненной энергии волшебника за уровень.
     */
    immutable int wizardLifeGrowthPerLevel;
    /**
     * Returns: Возвращает максимальное значение магической энергии волшебника на уровне `0`.
     */
    immutable int wizardBaseMana;
    /**
     * Returns: Возвращает прирост магической энергии волшебника за уровень.
     */
    immutable int wizardManaGrowthPerLevel;
    /**
     * Returns: Возвращает количество жизненной энергии, которое волшебник уровня `0` восстанавливает за один тик.
     */
    immutable double wizardBaseLifeRegeneration;
    /**
     * Returns: Возвращает прирост скорости регенерации жизненной энергии волшебника за один уровень.
     */
    immutable double wizardLifeRegenerationGrowthPerLevel;
    /**
     * Returns: Возвращает количество магической энергии, которое волшебник уровня `0` восстанавливает за один тик.
     */
    immutable double wizardBaseManaRegeneration;
    /**
     * Returns: Возвращает прирост скорости регенерации магической энергии волшебника за один уровень.
     */
    immutable double wizardManaRegenerationGrowthPerLevel;
    /**
     * Returns: Возвращает базовое ограничение на изменение угла поворота волшебника за один тик.
     * $(BR)
     * Эффективное ограничение может быть выше в `1.0 + hastenedRotationBonusFactor` раз в результате действия
     * статуса `Hastened`.
     */
    immutable double wizardMaxTurnAngle;
    /**
     * Returns: Возвращает максимально возможную задержку возрождения волшебника после смерти его телесной оболочки.
     * $(BR)
     * Если волшебник погибает сразу после своего возрождения, то он будет автоматически воскрешён на своей начальной
     * позиции (или недалеко от неё, если это невозможно) через `wizardMaxResurrectionDelayTicks` тиков. Каждый
     * игровой тик жизни волшебника уменьшшает эту задержку на единицу. Задержка возрождения не может стать меньше, чем
     * `wizardMinResurrectionDelayTicks`.
     */
    immutable int wizardMaxResurrectionDelayTicks;
    /**
     * Returns: Возвращает минимально возможную задержку возрождения волшебника после смерти его телесной оболочки.
     * $(BR)
     * Если волшебник погибает сразу после своего возрождения, то он будет автоматически воскрешён на своей начальной
     * позиции (или недалеко от неё, если это невозможно) через `wizardMaxResurrectionDelayTicks` тиков. Каждый
     * игровой тик жизни волшебника уменьшшает эту задержку на единицу. Задержка возрождения не может стать меньше, чем
     * `wizardMinResurrectionDelayTicks`.
     */
    immutable int wizardMinResurrectionDelayTicks;
    /**
     * Returns: Возвращает минимально возможную задержку между любыми двумя последовательными действиями волшебника.
     */
    immutable int wizardActionCooldownTicks;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными ударами посохом.
     */
    immutable int staffCooldownTicks;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными заклинаниями <<Магическая
     * ракета>>.
     */
    immutable int magicMissileCooldownTicks;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными заклинаниями <<Ледяная стрела>>.
     */
    immutable int frostBoltCooldownTicks;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными заклинаниями <<Огненный шар>>.
     */
    immutable int fireballCooldownTicks;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными заклинаниями <<Ускорение>>.
     */
    immutable int hasteCooldownTicks;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными заклинаниями <<Щит>>.
     */
    immutable int shieldCooldownTicks;
    /**
     * Returns: Возвращает количество магической энергии, требуемой для заклинания <<Магическая ракета>>.
     */
    immutable int magicMissileManacost;
    /**
     * Returns: Возвращает количество магической энергии, требуемой для заклинания <<Ледяная стрела>>.
     */
    immutable int frostBoltManacost;
    /**
     * Returns: Возвращает количество магической энергии, требуемой для заклинания <<Огненный шар>>.
     */
    immutable int fireballManacost;
    /**
     * Returns: Возвращает количество магической энергии, требуемой для заклинания <<Ускорение>>.
     */
    immutable int hasteManacost;
    /**
     * Returns: Возвращает количество магической энергии, требуемой для заклинания <<Щит>>.
     */
    immutable int shieldManacost;
    /**
     * Returns: Возвращает базовый урон удара посохом.
     * $(BR)
     * Эффективный урон может быть выше в результате действия некоторых аур и/или изучения волшебником некоторых
     * умений.
     */
    immutable int staffDamage;
    /**
     * Returns: Возвращает сектор действия посоха волшебника.
     * $(BR)
     * Атака посохом поражает все живые объекты в секторе от `-staffSector / 2.0` до `staffSector / 2.0`.
     * Этим же интервалом ограничены относительный угол снаряда, а также зона применения магического статуса.
     */
    immutable double staffSector;
    /**
     * Returns: Возвращает дальность действия посоха волшебника.
     * $(BR)
     * Атака посохом поражает все живые объекты, для каждого из которых верно, что расстояние от его центра до центра
     * волшебника не превышает значение `staffRange + livingUnit.radius`.
     */
    immutable double staffRange;
    /**
     * Returns: Возвращает последовательность неотрицательных целых чисел.
     * $(BR)
     * Количество чисел равно количеству уровней, которые волшебник может получить в данном режиме игры. Значение с
     * индексом `N` определяет количество опыта, которое необходимо набрать волшебнику уровня `N` для
     * получения следующего уровня. Таким образом, количество опыта, необходимое волшебнику начального уровня для
     * получения уровня `N`, равно сумме первых `N` элементов.
     */
    immutable int [] levelUpXpValues;
    /**
     * Returns: Возвращает радиус миньона.
     */
    immutable double minionRadius;
    /**
     * Returns: Возвращает максимальное расстояние (от центра до центра), на котором миньон обнаруживает другие
     * объекты.
     */
    immutable double minionVisionRange;
    /**
     * Returns: Возвращает скорость миньона при движении вперёд.
     * $(BR)
     * Миньонам недоступно использование других видов движения, а также перемещение со скоростью, отличной от указанной.
     */
    immutable double minionSpeed;
    /**
     * Returns: Возвращает ограничение на изменение угла поворота миньона за один тик.
     */
    immutable double minionMaxTurnAngle;
    /**
     * Returns: Возвращает максимальное значение жизненной энергии миньона.
     */
    immutable int minionLife;
    /**
     * Returns: Возвращает интервал, с которым появляются миньоны двух противостоящих фракций (`Academy` и
     * `Renegades`).
     * $(BR)
     * Миньоны каждой из этих фракций появляются тремя группами (по одной на дорожку) недалеко от своей базы. Группа
     * состоит и трёх орков и одного фетиша. Сразу после появления миньоны начинают продвижение по своей дорожке в
     * сторону базы противоположной фракции, при этом атакуя всех противников на своём пути.
     */
    immutable int factionMinionAppearanceIntervalTicks;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными атаками орка-дровосека.
     */
    immutable int orcWoodcutterActionCooldownTicks;
    /**
     * Returns: Возвращает урон одной атаки орка-дровосека.
     */
    immutable int orcWoodcutterDamage;
    /**
     * Returns: Возвращает сектор действия топора орка.
     * $(BR)
     * Атака топором поражает все живые объекты в секторе от `-orcWoodcutterAttackSector / 2.0` до
     * `orcWoodcutterAttackSector / 2.0`.
     */
    immutable double orcWoodcutterAttackSector;
    /**
     * Returns: Возвращает дальность действия топора орка.
     * $(BR)
     * Атака топором поражает все живые объекты, для каждого из которых верно, что расстояние от его центра до центра
     * орка-дровосека не превышает значение `orcWoodcutterAttackRange + livingUnit.radius`.
     */
    immutable double orcWoodcutterAttackRange;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными атаками фетиша.
     */
    immutable int fetishBlowdartActionCooldownTicks;
    /**
     * Returns: Возвращает дальность полёта дротика, выпущенного фетишем.
     */
    immutable double fetishBlowdartAttackRange;
    /**
     * Returns: Возвращает сектор метания дротика фетишем.
     * $(BR)
     * Угол полёта дротика относительно направления фетиша ограничен интервалом от
     * `-fetishBlowdartAttackSector / 2.0` до `fetishBlowdartAttackSector / 2.0`.
     */
    immutable double fetishBlowdartAttackSector;
    /**
     * Returns: Возвращает радиус бонуса.
     */
    immutable double bonusRadius;
    /**
     * Returns: Возвращает интервал появления бонусов.
     * $(BR)
     * Каждый раз по прошествии указанного интервала симулятор игры создаёт до двух бонусов в точках
     * (`mapSize * 0.3`, `mapSize * 0.3`) и (`mapSize * 0.7`, `mapSize * 0.7`). Если любая часть
     * области появления бонуса уже занята волшебником или другим бонусом, то создание бонуса будет отложено до
     * окончания очередного интервала.
     */
    immutable int bonusAppearanceIntervalTicks;
    /**
     * Returns: Возвращает количество баллов, начисляемых игроку, волшебник которого подробрал бонус.
     * $(BR)
     * Сам волшебник получает такое же количество опыта.
     */
    immutable int bonusScoreAmount;
    /**
     * Returns: Возвращает радиус дротика.
     */
    immutable double dartRadius;
    /**
     * Returns: Возвращает скорость полёта дротика.
     */
    immutable double dartSpeed;
    /**
     * Returns: Возвращает урон дротика.
     */
    immutable int dartDirectDamage;
    /**
     * Returns: Возвращает радиус <<Магической ракеты>>.
     */
    immutable double magicMissileRadius;
    /**
     * Returns: Возвращает скорость полёта <<Магической ракеты>>.
     */
    immutable double magicMissileSpeed;
    /**
     * Returns: Возвращает урон <<Магической ракеты>>.
     */
    immutable int magicMissileDirectDamage;
    /**
     * Returns: Возвращает радиус <<Ледяной стрелы>>.
     */
    immutable double frostBoltRadius;
    /**
     * Returns: Возвращает скорость полёта <<Ледяной стрелы>>.
     */
    immutable double frostBoltSpeed;
    /**
     * Returns: Возвращает урон <<Ледяной стрелы>>.
     */
    immutable int frostBoltDirectDamage;
    /**
     * Returns: Возвращает радиус <<Огненного шара>>.
     */
    immutable double fireballRadius;
    /**
     * Returns: Возвращает скорость полёта <<Огненного шара>>.
     */
    immutable double fireballSpeed;
    /**
     * Returns: Возвращает радиус области, в которой живые юниты получают максимальный урон от взрыва <<Огненного шара>>.
     * See_Also: #getFireballExplosionMaxDamage ()
     */
    immutable double fireballExplosionMaxDamageRange;
    /**
     * Returns: Возвращает радиус области, в которой живые юниты получают какой-либо урон от взрыва <<Огненного шара>>.
     * See_Also: #getFireballExplosionMaxDamage ()
     */
    immutable double fireballExplosionMinDamageRange;
    /**
     * Returns: Возвращает урон <<Огненного шара>> в эпицентре взрыва.
     * $(BR)
     * Живой юнит получает `fireballExplosionMaxDamage` единиц урона, если расстояние от центра взрыва до
     * ближайшей точки этого юнита не превышает `fireballExplosionMaxDamageRange`. По мере увеличения расстояния
     * до `fireballExplosionMinDamageRange`, урон <<Огненного шара>> равномерно снижается и достигает
     * `fireballExplosionMinDamage`. Если расстояние от центра взрыва до ближайшей точки живого юнита превышает
     * `fireballExplosionMinDamageRange`, то урон ему не наносится.
     * $(BR)
     * Если живой юнит получил какой-либо урон от взрыва <<Огненного шара>>, то он загорается (`Burning`).
     */
    immutable int fireballExplosionMaxDamage;
    /**
     * Returns: Возвращает урон <<Огненного шара>> на периферии взрыва.
     * See_Also: #getFireballExplosionMaxDamage ()
     */
    immutable int fireballExplosionMinDamage;
    /**
     * Returns: Возвращает радиус охранной башни.
     */
    immutable double guardianTowerRadius;
    /**
     * Returns: Возвращает максимальное расстояние (от центра до центра), на котором охранная башня обнаруживает другие
     * объекты.
     */
    immutable double guardianTowerVisionRange;
    /**
     * Returns: Возвращает начальное значение жизненной энергии охранной башни.
     */
    immutable double guardianTowerLife;
    /**
     * Returns: Возвращает максимальное расстояние (от центра до центра), на котором охранная башня может атаковать
     * другие объекты.
     */
    immutable double guardianTowerAttackRange;
    /**
     * Returns: Возвращает урон одной атаки охранной башни.
     */
    immutable int guardianTowerDamage;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными атаками охранной башни.
     */
    immutable int guardianTowerCooldownTicks;
    /**
     * Returns: Возвращает радиус базы фракции.
     */
    immutable double factionBaseRadius;
    /**
     * Returns: Возвращает максимальное расстояние (от центра до центра), на котором база фракции обнаруживает другие
     * объекты.
     */
    immutable double factionBaseVisionRange;
    /**
     * Returns: Возвращает начальное значение жизненной энергии базы фракции.
     */
    immutable double factionBaseLife;
    /**
     * Returns: Возвращает максимальное расстояние (от центра до центра), на котором база фракции может атаковать
     * другие объекты.
     */
    immutable double factionBaseAttackRange;
    /**
     * Returns: Возвращает урон одной атаки базы фракции.
     */
    immutable int factionBaseDamage;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными атаками базы фракции.
     */
    immutable int factionBaseCooldownTicks;
    /**
     * Returns: Возвращает длительность действия статуса `Burning`.
     */
    immutable int burningDurationTicks;
    /**
     * Returns: Возвращает суммарный урон, получаемый живым юнитом за время действия статуса `Burning`.
     */
    immutable int burningSummaryDamage;
    /**
     * Returns: Возвращает длительность действия статуса `Empowered`.
     */
    immutable int empoweredDurationTicks;
    /**
     * Returns: Возвращает мультипликатор урона, наносимого живым юнитом под действием статуса `Empowered`.
     * $(BR)
     * Мультипликатор применяется к ударам в ближнем бою, прямым попаданиям снарядов, а также взрыву <<Огненного шара>>,
     * но не применяется к урону, получаемому от статусов.
     */
    immutable double empoweredDamageFactor;
    /**
     * Returns: Возвращает длительность действия статуса `Frozen`.
     */
    immutable int frozenDurationTicks;
    /**
     * Returns: Возвращает длительность действия статуса `Hastened`.
     */
    immutable int hastenedDurationTicks;
    /**
     * Returns: Возвращает мультилпикатор длительности действия статуса `Hastened` в случае подбора бонуса.
     */
    immutable double hastenedBonusDurationFactor;
    /**
     * Returns: Возвращает относительное увеличение скорости перемещения в результате дествия статуса `Hastened`.
     * $(BR)
     * Увеличение скорости от действия статуса `Hastened` и увеличение скорости в результате изучения умений,
     * являющихся пререквизитами умения `Haste`, являются аддитивными. Таким образом, максимальное значение
     * скорости волшебника составляет
     * `1.0 + 4.0 * movementBonusFactorPerSkillLevel + hastenedMovementBonusFactor` от базовой.
     */
    immutable double hastenedMovementBonusFactor;
    /**
     * Returns: Возвращает относительное увеличение скорости поворота в результате дествия статуса `Hastened`.
     */
    immutable double hastenedRotationBonusFactor;
    /**
     * Returns: Возвращает длительность действия статуса `Shielded`.
     */
    immutable int shieldedDurationTicks;
    /**
     * Returns: Возвращает мультилпикатор длительности действия статуса `Shielded` в случае подбора бонуса.
     */
    immutable double shieldedBonusDurationFactor;
    /**
     * Returns: Возвращает часть урона, поглощаемую щитом.
     * $(BR)
     * Снижение урона применяется к ударам в ближнем бою, прямым попаданиям снарядов, а также взрыву <<Огненного шара>>,
     * но не применяется к урону, получаемому от статусов.
     */
    immutable double shieldedDirectDamageAbsorptionFactor;
    /**
     * Returns: Возвращает дальность действия аур.
     */
    immutable double auraSkillRange;
    /**
     * Returns: Возвращает абсолютное увеличение дальности заклинаний волшебника за каждое последовательное изучение
     * умения, являющегося одним из пререквизитов умения `AdvancedMagicMissile`.
     */
    immutable double rangeBonusPerSkillLevel;
    /**
     * Returns: Возвращает абсолютное увеличение урона, наносимого волшебником в результате прямых попаданий магических
     * снарядов и взрыва <<Огненного шара>>, за каждое последовательное изучение умения, являющегося одним из
     * пререквизитов умения `FrostBolt`.
     */
    immutable int magicalDamageBonusPerSkillLevel;
    /**
     * Returns: Возвращает абсолютное увеличение урона, наносимого волшебником в ближнем бою, за каждое последовательное
     * изучение умения, являющегося одним из пререквизитов умения `Fireball`.
     */
    immutable int staffDamageBonusPerSkillLevel;
    /**
     * Returns: Возвращает относительное увеличение скорости перемещения за каждое последовательное изучение умения,
     * являющегося одним из пререквизитов умения `Haste`.
     * $(BR)
     * Увеличение скорости от действия статуса `Hastened` и увеличение скорости в результате изучения умений,
     * являющихся пререквизитами умения `Haste`, являются аддитивными. Таким образом, максимальное значение
     * скорости волшебника составляет
     * `1.0 + 4.0 * movementBonusFactorPerSkillLevel + hastenedMovementBonusFactor` от базовой.
     */
    immutable double movementBonusFactorPerSkillLevel;
    /**
     * Returns: Возвращает абсолютное уменьшение урона, получаемого волшебником в результате прямых попаданий магических
     * снарядов, взрыва <<Огненного шара>> и атак строений, за каждое последовательное изучение умения, являющегося
     * одним из пререквизитов умения `Shield`.
     */
    immutable int magicalDamageAbsorptionPerSkillLevel;

    immutable this (
        long randomSeed,
        int tickCount,
        double mapSize,
        bool skillsEnabled,
        bool rawMessagesEnabled,
        double friendlyFireDamageFactor,
        double buildingDamageScoreFactor,
        double buildingEliminationScoreFactor,
        double minionDamageScoreFactor,
        double minionEliminationScoreFactor,
        double wizardDamageScoreFactor,
        double wizardEliminationScoreFactor,
        double teamWorkingScoreFactor,
        int victoryScore,
        double scoreGainRange,
        int rawMessageMaxLength,
        double rawMessageTransmissionSpeed,
        double wizardRadius,
        double wizardCastRange,
        double wizardVisionRange,
        double wizardForwardSpeed,
        double wizardBackwardSpeed,
        double wizardStrafeSpeed,
        int wizardBaseLife,
        int wizardLifeGrowthPerLevel,
        int wizardBaseMana,
        int wizardManaGrowthPerLevel,
        double wizardBaseLifeRegeneration,
        double wizardLifeRegenerationGrowthPerLevel,
        double wizardBaseManaRegeneration,
        double wizardManaRegenerationGrowthPerLevel,
        double wizardMaxTurnAngle,
        int wizardMaxResurrectionDelayTicks,
        int wizardMinResurrectionDelayTicks,
        int wizardActionCooldownTicks,
        int staffCooldownTicks,
        int magicMissileCooldownTicks,
        int frostBoltCooldownTicks,
        int fireballCooldownTicks,
        int hasteCooldownTicks,
        int shieldCooldownTicks,
        int magicMissileManacost,
        int frostBoltManacost,
        int fireballManacost,
        int hasteManacost,
        int shieldManacost,
        int staffDamage,
        double staffSector,
        double staffRange,
        int [] levelUpXpValues,
        double minionRadius,
        double minionVisionRange,
        double minionSpeed,
        double minionMaxTurnAngle,
        int minionLife,
        int factionMinionAppearanceIntervalTicks,
        int orcWoodcutterActionCooldownTicks,
        int orcWoodcutterDamage,
        double orcWoodcutterAttackSector,
        double orcWoodcutterAttackRange,
        int fetishBlowdartActionCooldownTicks,
        double fetishBlowdartAttackRange,
        double fetishBlowdartAttackSector,
        double bonusRadius,
        int bonusAppearanceIntervalTicks,
        int bonusScoreAmount,
        double dartRadius,
        double dartSpeed,
        int dartDirectDamage,
        double magicMissileRadius,
        double magicMissileSpeed,
        int magicMissileDirectDamage,
        double frostBoltRadius,
        double frostBoltSpeed,
        int frostBoltDirectDamage,
        double fireballRadius,
        double fireballSpeed,
        double fireballExplosionMaxDamageRange,
        double fireballExplosionMinDamageRange,
        int fireballExplosionMaxDamage,
        int fireballExplosionMinDamage,
        double guardianTowerRadius,
        double guardianTowerVisionRange,
        double guardianTowerLife,
        double guardianTowerAttackRange,
        int guardianTowerDamage,
        int guardianTowerCooldownTicks,
        double factionBaseRadius,
        double factionBaseVisionRange,
        double factionBaseLife,
        double factionBaseAttackRange,
        int factionBaseDamage,
        int factionBaseCooldownTicks,
        int burningDurationTicks,
        int burningSummaryDamage,
        int empoweredDurationTicks,
        double empoweredDamageFactor,
        int frozenDurationTicks,
        int hastenedDurationTicks,
        double hastenedBonusDurationFactor,
        double hastenedMovementBonusFactor,
        double hastenedRotationBonusFactor,
        int shieldedDurationTicks,
        double shieldedBonusDurationFactor,
        double shieldedDirectDamageAbsorptionFactor,
        double auraSkillRange,
        double rangeBonusPerSkillLevel,
        int magicalDamageBonusPerSkillLevel,
        int staffDamageBonusPerSkillLevel,
        double movementBonusFactorPerSkillLevel,
        int magicalDamageAbsorptionPerSkillLevel)
    {
        this.randomSeed = randomSeed;
        this.tickCount = tickCount;
        this.mapSize = mapSize;
        this.skillsEnabled = skillsEnabled;
        this.rawMessagesEnabled = rawMessagesEnabled;
        this.friendlyFireDamageFactor = friendlyFireDamageFactor;
        this.buildingDamageScoreFactor = buildingDamageScoreFactor;
        this.buildingEliminationScoreFactor = buildingEliminationScoreFactor;
        this.minionDamageScoreFactor = minionDamageScoreFactor;
        this.minionEliminationScoreFactor = minionEliminationScoreFactor;
        this.wizardDamageScoreFactor = wizardDamageScoreFactor;
        this.wizardEliminationScoreFactor = wizardEliminationScoreFactor;
        this.teamWorkingScoreFactor = teamWorkingScoreFactor;
        this.victoryScore = victoryScore;
        this.scoreGainRange = scoreGainRange;
        this.rawMessageMaxLength = rawMessageMaxLength;
        this.rawMessageTransmissionSpeed = rawMessageTransmissionSpeed;
        this.wizardRadius = wizardRadius;
        this.wizardCastRange = wizardCastRange;
        this.wizardVisionRange = wizardVisionRange;
        this.wizardForwardSpeed = wizardForwardSpeed;
        this.wizardBackwardSpeed = wizardBackwardSpeed;
        this.wizardStrafeSpeed = wizardStrafeSpeed;
        this.wizardBaseLife = wizardBaseLife;
        this.wizardLifeGrowthPerLevel = wizardLifeGrowthPerLevel;
        this.wizardBaseMana = wizardBaseMana;
        this.wizardManaGrowthPerLevel = wizardManaGrowthPerLevel;
        this.wizardBaseLifeRegeneration = wizardBaseLifeRegeneration;
        this.wizardLifeRegenerationGrowthPerLevel = wizardLifeRegenerationGrowthPerLevel;
        this.wizardBaseManaRegeneration = wizardBaseManaRegeneration;
        this.wizardManaRegenerationGrowthPerLevel = wizardManaRegenerationGrowthPerLevel;
        this.wizardMaxTurnAngle = wizardMaxTurnAngle;
        this.wizardMaxResurrectionDelayTicks = wizardMaxResurrectionDelayTicks;
        this.wizardMinResurrectionDelayTicks = wizardMinResurrectionDelayTicks;
        this.wizardActionCooldownTicks = wizardActionCooldownTicks;
        this.staffCooldownTicks = staffCooldownTicks;
        this.magicMissileCooldownTicks = magicMissileCooldownTicks;
        this.frostBoltCooldownTicks = frostBoltCooldownTicks;
        this.fireballCooldownTicks = fireballCooldownTicks;
        this.hasteCooldownTicks = hasteCooldownTicks;
        this.shieldCooldownTicks = shieldCooldownTicks;
        this.magicMissileManacost = magicMissileManacost;
        this.frostBoltManacost = frostBoltManacost;
        this.fireballManacost = fireballManacost;
        this.hasteManacost = hasteManacost;
        this.shieldManacost = shieldManacost;
        this.staffDamage = staffDamage;
        this.staffSector = staffSector;
        this.staffRange = staffRange;
        this.levelUpXpValues = levelUpXpValues.idup;
        this.minionRadius = minionRadius;
        this.minionVisionRange = minionVisionRange;
        this.minionSpeed = minionSpeed;
        this.minionMaxTurnAngle = minionMaxTurnAngle;
        this.minionLife = minionLife;
        this.factionMinionAppearanceIntervalTicks = factionMinionAppearanceIntervalTicks;
        this.orcWoodcutterActionCooldownTicks = orcWoodcutterActionCooldownTicks;
        this.orcWoodcutterDamage = orcWoodcutterDamage;
        this.orcWoodcutterAttackSector = orcWoodcutterAttackSector;
        this.orcWoodcutterAttackRange = orcWoodcutterAttackRange;
        this.fetishBlowdartActionCooldownTicks = fetishBlowdartActionCooldownTicks;
        this.fetishBlowdartAttackRange = fetishBlowdartAttackRange;
        this.fetishBlowdartAttackSector = fetishBlowdartAttackSector;
        this.bonusRadius = bonusRadius;
        this.bonusAppearanceIntervalTicks = bonusAppearanceIntervalTicks;
        this.bonusScoreAmount = bonusScoreAmount;
        this.dartRadius = dartRadius;
        this.dartSpeed = dartSpeed;
        this.dartDirectDamage = dartDirectDamage;
        this.magicMissileRadius = magicMissileRadius;
        this.magicMissileSpeed = magicMissileSpeed;
        this.magicMissileDirectDamage = magicMissileDirectDamage;
        this.frostBoltRadius = frostBoltRadius;
        this.frostBoltSpeed = frostBoltSpeed;
        this.frostBoltDirectDamage = frostBoltDirectDamage;
        this.fireballRadius = fireballRadius;
        this.fireballSpeed = fireballSpeed;
        this.fireballExplosionMaxDamageRange = fireballExplosionMaxDamageRange;
        this.fireballExplosionMinDamageRange = fireballExplosionMinDamageRange;
        this.fireballExplosionMaxDamage = fireballExplosionMaxDamage;
        this.fireballExplosionMinDamage = fireballExplosionMinDamage;
        this.guardianTowerRadius = guardianTowerRadius;
        this.guardianTowerVisionRange = guardianTowerVisionRange;
        this.guardianTowerLife = guardianTowerLife;
        this.guardianTowerAttackRange = guardianTowerAttackRange;
        this.guardianTowerDamage = guardianTowerDamage;
        this.guardianTowerCooldownTicks = guardianTowerCooldownTicks;
        this.factionBaseRadius = factionBaseRadius;
        this.factionBaseVisionRange = factionBaseVisionRange;
        this.factionBaseLife = factionBaseLife;
        this.factionBaseAttackRange = factionBaseAttackRange;
        this.factionBaseDamage = factionBaseDamage;
        this.factionBaseCooldownTicks = factionBaseCooldownTicks;
        this.burningDurationTicks = burningDurationTicks;
        this.burningSummaryDamage = burningSummaryDamage;
        this.empoweredDurationTicks = empoweredDurationTicks;
        this.empoweredDamageFactor = empoweredDamageFactor;
        this.frozenDurationTicks = frozenDurationTicks;
        this.hastenedDurationTicks = hastenedDurationTicks;
        this.hastenedBonusDurationFactor = hastenedBonusDurationFactor;
        this.hastenedMovementBonusFactor = hastenedMovementBonusFactor;
        this.hastenedRotationBonusFactor = hastenedRotationBonusFactor;
        this.shieldedDurationTicks = shieldedDurationTicks;
        this.shieldedBonusDurationFactor = shieldedBonusDurationFactor;
        this.shieldedDirectDamageAbsorptionFactor = shieldedDirectDamageAbsorptionFactor;
        this.auraSkillRange = auraSkillRange;
        this.rangeBonusPerSkillLevel = rangeBonusPerSkillLevel;
        this.magicalDamageBonusPerSkillLevel = magicalDamageBonusPerSkillLevel;
        this.staffDamageBonusPerSkillLevel = staffDamageBonusPerSkillLevel;
        this.movementBonusFactorPerSkillLevel = movementBonusFactorPerSkillLevel;
        this.magicalDamageAbsorptionPerSkillLevel = magicalDamageAbsorptionPerSkillLevel;
    }
}
