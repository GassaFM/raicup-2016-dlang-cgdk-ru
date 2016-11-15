module model.game;

/**
 * Предоставляет доступ к различным игровым константам.
 */
immutable class Game
{
    /**
     * Returns: Возвращает некоторое число, которое ваша стратегия может использовать для инициализации генератора
     * случайных чисел. Данное значение имеет рекомендательный характер, однако позволит более точно воспроизводить
     * прошедшие игры.
     */
    long randomSeed;
    /**
     * Returns: Возвращает базовую длительность игры в тиках. Реальная длительность может отличаться от этого значения в
     * меньшую сторону. Эквивалентно `world.tickCount`.
     */
    int tickCount;
    /**
     * Returns: Возвращает размер (ширину и высоту) карты.
     */
    double mapSize;
    /**
     * Returns: Возвращает `true`, если и только если в данной игре волшебники могут повышать свой уровень
     * (накапливая опыт) и изучать новые умения.
     */
    bool skillsEnabled;
    /**
     * Returns: Возвращает `true`, если и только если верховные волшебники в данной игре могут передавать
     * низкоуровневые сообщения другим волшебникам своей фракции.
     */
    bool rawMessagesEnabled;
    /**
     * Returns: Возвращает коэффициент урона, наносимого волшебниками одной фракции друг другу в результате
     * дружественного огня.
     * $(BR)
     * Значение зависит от режима игры, но не может выходить за границы интервала от `0.0` до `1.0`.
     * $(BR)
     * Вне зависимости от режима игры, волшебники не могут наносить урон союзным миньонам и структурам.
     */
    double friendlyFireDamageFactor;
    /**
     * Returns: Возвращает коэффициент опыта, получаемого волшебником при нанесении урона строениям противоположной
     * фракции.
     */
    double buildingDamageScoreFactor;
    /**
     * Returns: Возвращает коэффициент опыта, получаемого волшебником за разрушение строения противоположной фракции.
     * $(BR)
     * Применяется к максимальному количеству жизненной энергии строения.
     */
    double buildingEliminationScoreFactor;
    /**
     * Returns: Возвращает коэффициент опыта, получаемого волшебником при нанесении урона миньонам другой фракции.
     */
    double minionDamageScoreFactor;
    /**
     * Returns: Возвращает коэффициент опыта, получаемого волшебником за уничтожение миньона другой фракции.
     * $(BR)
     * Применяется к максимальному количеству жизненной энергии миньона.
     */
    double minionEliminationScoreFactor;
    /**
     * Returns: Возвращает коэффициент опыта, получаемого волшебником при нанесении урона волшебникам противоположной
     * фракции.
     */
    double wizardDamageScoreFactor;
    /**
     * Returns: Возвращает коэффициент опыта, получаемого волшебником за разрушение телесной оболочки волшебника
     * противоположной фракции.
     * $(BR)
     * Применяется к максимальному количеству жизненной энергии волшебника.
     */
    double wizardEliminationScoreFactor;
    /**
     * Returns: Возвращает мультипликатор опыта, применяемый в случае уничтожения юнита противника при участии двух или
     * более волшебников.
     * $(BR)
     * После применения мультипликатора количество опыта округляется вниз до ближайшего целого значения.
     */
    double teamWorkingScoreFactor;
    /**
     * Returns: Возвращает количество баллов, получаемых всеми игроками фракции в случае победы --- разрушения базы
     * противоположной фракции.
     */
    int victoryScore;
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
    double scoreGainRange;
    /**
     * Returns: Возвращает максимально возможную длину низкоуровневого сообщения.
     * $(BR)
     * Сообщения, длина которых превышает указанное значение, будут проигнорированы.
     */
    int rawMessageMaxLength;
    /**
     * Returns: Возвращает скорость отправки сообщения.
     * $(BR)
     * Если текстовая часть сообщения пуста, то адресат получит его уже в следующий игровой тик. В противном случае,
     * момент получения сообщения будет отложен на `ceil (message.rawMessage.length / rawMessageTransmissionSpeed)`
     * игровых тиков.
     */
    double rawMessageTransmissionSpeed;
    /**
     * Returns: Возвращает радиус волшебника.
     */
    double wizardRadius;
    /**
     * Returns: Возвращает базовую дальность заклинаний волшебника.
     * $(BR)
     * Эффективная дальность (`wizard.castRange`) может быть выше в результате действия некоторых аур и/или
     * изучения волшебником некоторых умений.
     */
    double wizardCastRange;
    /**
     * Returns: Возвращает максимальное расстояние (от центра до центра), на котором волшебник обнаруживает другие
     * объекты.
     */
    double wizardVisionRange;
    /**
     * Returns: Возвращает базовое ограничение скорости волшебника при движении вперёд.
     * $(BR)
     * Эффективное ограничение может быть выше в результате действия некоторых аур и/или изучения волшебником некоторых
     * умений, а также в результате действия статуса `hastened`.
     */
    double wizardForwardSpeed;
    /**
     * Returns: Возвращает базовое ограничение скорости волшебника при движении назад.
     * $(BR)
     * Эффективное ограничение может быть выше в результате действия некоторых аур и/или изучения волшебником некоторых
     * умений, а также в результате действия статуса `hastened`.
     */
    double wizardBackwardSpeed;
    /**
     * Returns: Возвращает базовое ограничение скорости волшебника при движении боком.
     * $(BR)
     * Эффективное ограничение может быть выше в результате действия некоторых аур и/или изучения волшебником некоторых
     * умений, а также в результате действия статуса `hastened`.
     */
    double wizardStrafeSpeed;
    /**
     * Returns: Возвращает максимальное значение жизненной энергии волшебника на уровне `0`.
     */
    int wizardBaseLife;
    /**
     * Returns: Возвращает прирост жизненной энергии волшебника за уровень.
     */
    int wizardLifeGrowthPerLevel;
    /**
     * Returns: Возвращает максимальное значение магической энергии волшебника на уровне `0`.
     */
    int wizardBaseMana;
    /**
     * Returns: Возвращает прирост магической энергии волшебника за уровень.
     */
    int wizardManaGrowthPerLevel;
    /**
     * Returns: Возвращает количество жизненной энергии, которое волшебник уровня `0` восстанавливает за один тик.
     */
    double wizardBaseLifeRegeneration;
    /**
     * Returns: Возвращает прирост скорости регенерации жизненной энергии волшебника за один уровень.
     */
    double wizardLifeRegenerationGrowthPerLevel;
    /**
     * Returns: Возвращает количество магической энергии, которое волшебник уровня `0` восстанавливает за один тик.
     */
    double wizardBaseManaRegeneration;
    /**
     * Returns: Возвращает прирост скорости регенерации магической энергии волшебника за один уровень.
     */
    double wizardManaRegenerationGrowthPerLevel;
    /**
     * Returns: Возвращает базовое ограничение на изменение угла поворота волшебника за один тик.
     * $(BR)
     * Эффективное ограничение может быть выше в `1.0 + hastenedRotationBonusFactor` раз в результате действия
     * статуса `hastened`.
     */
    double wizardMaxTurnAngle;
    /**
     * Returns: Возвращает максимально возможную задержку возрождения волшебника после смерти его телесной оболочки.
     * $(BR)
     * Если волшебник погибает сразу после своего возрождения, то он будет автоматически воскрешён на своей начальной
     * позиции (или недалеко от неё, если это невозможно) через `wizardMaxResurrectionDelayTicks` тиков. Каждый
     * игровой тик жизни волшебника уменьшшает эту задержку на единицу. Задержка возрождения не может стать меньше, чем
     * `wizardMinResurrectionDelayTicks`.
     */
    int wizardMaxResurrectionDelayTicks;
    /**
     * Returns: Возвращает минимально возможную задержку возрождения волшебника после смерти его телесной оболочки.
     * $(BR)
     * Если волшебник погибает сразу после своего возрождения, то он будет автоматически воскрешён на своей начальной
     * позиции (или недалеко от неё, если это невозможно) через `wizardMaxResurrectionDelayTicks` тиков. Каждый
     * игровой тик жизни волшебника уменьшшает эту задержку на единицу. Задержка возрождения не может стать меньше, чем
     * `wizardMinResurrectionDelayTicks`.
     */
    int wizardMinResurrectionDelayTicks;
    /**
     * Returns: Возвращает минимально возможную задержку между любыми двумя последовательными действиями волшебника.
     */
    int wizardActionCooldownTicks;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными ударами посохом.
     */
    int staffCooldownTicks;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными заклинаниями <<Магическая
     * ракета>>.
     */
    int magicMissileCooldownTicks;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными заклинаниями <<Ледяная стрела>>.
     */
    int frostBoltCooldownTicks;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными заклинаниями <<Огненный шар>>.
     */
    int fireballCooldownTicks;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными заклинаниями <<Ускорение>>.
     */
    int hasteCooldownTicks;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными заклинаниями <<Щит>>.
     */
    int shieldCooldownTicks;
    /**
     * Returns: Возвращает количество магической энергии, требуемой для заклинания <<Магическая ракета>>.
     */
    int magicMissileManacost;
    /**
     * Returns: Возвращает количество магической энергии, требуемой для заклинания <<Ледяная стрела>>.
     */
    int frostBoltManacost;
    /**
     * Returns: Возвращает количество магической энергии, требуемой для заклинания <<Огненный шар>>.
     */
    int fireballManacost;
    /**
     * Returns: Возвращает количество магической энергии, требуемой для заклинания <<Ускорение>>.
     */
    int hasteManacost;
    /**
     * Returns: Возвращает количество магической энергии, требуемой для заклинания <<Щит>>.
     */
    int shieldManacost;
    /**
     * Returns: Возвращает базовый урон удара посохом.
     * $(BR)
     * Эффективный урон может быть выше в результате действия некоторых аур и/или изучения волшебником некоторых
     * умений.
     */
    int staffDamage;
    /**
     * Returns: Возвращает сектор действия посоха волшебника.
     * $(BR)
     * Атака посохом поражает все живые объекты в секторе от `-staffSector / 2.0` до `staffSector / 2.0`.
     * Этим же интервалом ограничены относительный угол снаряда, а также зона применения магического статуса.
     */
    double staffSector;
    /**
     * Returns: Возвращает дальность действия посоха волшебника.
     * $(BR)
     * Атака посохом поражает все живые объекты, для каждого из которых верно, что расстояние от его центра до центра
     * волшебника не превышает значение `staffRange + livingUnit.radius`.
     */
    double staffRange;
    /**
     * Returns: Возвращает последовательность неотрицательных целых чисел.
     * $(BR)
     * Количество чисел равно количеству уровней, которые волшебник может получить в данном режиме игры. Значение с
     * индексом `N` определяет количество опыта, которое необходимо набрать волшебнику уровня `N` для
     * получения следующего уровня. Таким образом, количество опыта, необходимое волшебнику начального уровня для
     * получения уровня `N`, равно сумме первых `N` элементов.
     */
    int [] levelUpXpValues;
    /**
     * Returns: Возвращает радиус миньона.
     */
    double minionRadius;
    /**
     * Returns: Возвращает максимальное расстояние (от центра до центра), на котором миньон обнаруживает другие
     * объекты.
     */
    double minionVisionRange;
    /**
     * Returns: Возвращает скорость миньона при движении вперёд.
     * $(BR)
     * Миньонам недоступно использование других видов движения, а также перемещение со скоростью, отличной от указанной.
     */
    double minionSpeed;
    /**
     * Returns: Возвращает ограничение на изменение угла поворота миньона за один тик.
     */
    double minionMaxTurnAngle;
    /**
     * Returns: Возвращает максимальное значение жизненной энергии миньона.
     */
    int minionLife;
    /**
     * Returns: Возвращает интервал, с которым появляются миньоны двух противостоящих фракций (`academy` и
     * `renegades`).
     * $(BR)
     * Миньоны каждой из этих фракций появляются тремя группами (по одной на дорожку) недалеко от своей базы. Группа
     * состоит и трёх орков и одного фетиша. Сразу после появления миньоны начинают продвижение по своей дорожке в
     * сторону базы противоположной фракции, при этом атакуя всех противников на своём пути.
     */
    int factionMinionAppearanceIntervalTicks;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными атаками орка-дровосека.
     */
    int orcWoodcutterActionCooldownTicks;
    /**
     * Returns: Возвращает урон одной атаки орка-дровосека.
     */
    int orcWoodcutterDamage;
    /**
     * Returns: Возвращает сектор действия топора орка.
     * $(BR)
     * Атака топором поражает все живые объекты в секторе от `-orcWoodcutterAttackSector / 2.0` до
     * `orcWoodcutterAttackSector / 2.0`.
     */
    double orcWoodcutterAttackSector;
    /**
     * Returns: Возвращает дальность действия топора орка.
     * $(BR)
     * Атака топором поражает все живые объекты, для каждого из которых верно, что расстояние от его центра до центра
     * орка-дровосека не превышает значение `orcWoodcutterAttackRange + livingUnit.radius`.
     */
    double orcWoodcutterAttackRange;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными атаками фетиша.
     */
    int fetishBlowdartActionCooldownTicks;
    /**
     * Returns: Возвращает дальность полёта дротика, выпущенного фетишем.
     */
    double fetishBlowdartAttackRange;
    /**
     * Returns: Возвращает сектор метания дротика фетишем.
     * $(BR)
     * Угол полёта дротика относительно направления фетиша ограничен интервалом от
     * `-fetishBlowdartAttackSector / 2.0` до `fetishBlowdartAttackSector / 2.0`.
     */
    double fetishBlowdartAttackSector;
    /**
     * Returns: Возвращает радиус бонуса.
     */
    double bonusRadius;
    /**
     * Returns: Возвращает интервал появления бонусов.
     * $(BR)
     * Каждый раз по прошествии указанного интервала симулятор игры создаёт до двух бонусов в точках
     * (`mapSize * 0.3`, `mapSize * 0.3`) и (`mapSize * 0.7`, `mapSize * 0.7`). Если любая часть
     * области появления бонуса уже занята волшебником или другим бонусом, то создание бонуса будет отложено до
     * окончания очередного интервала.
     */
    int bonusAppearanceIntervalTicks;
    /**
     * Returns: Возвращает количество баллов, начисляемых игроку, волшебник которого подробрал бонус.
     * $(BR)
     * Сам волшебник получает такое же количество опыта.
     */
    int bonusScoreAmount;
    /**
     * Returns: Возвращает радиус дротика.
     */
    double dartRadius;
    /**
     * Returns: Возвращает скорость полёта дротика.
     */
    double dartSpeed;
    /**
     * Returns: Возвращает урон дротика.
     */
    int dartDirectDamage;
    /**
     * Returns: Возвращает радиус <<Магической ракеты>>.
     */
    double magicMissileRadius;
    /**
     * Returns: Возвращает скорость полёта <<Магической ракеты>>.
     */
    double magicMissileSpeed;
    /**
     * Returns: Возвращает урон <<Магической ракеты>>.
     */
    int magicMissileDirectDamage;
    /**
     * Returns: Возвращает радиус <<Ледяной стрелы>>.
     */
    double frostBoltRadius;
    /**
     * Returns: Возвращает скорость полёта <<Ледяной стрелы>>.
     */
    double frostBoltSpeed;
    /**
     * Returns: Возвращает урон <<Ледяной стрелы>>.
     */
    int frostBoltDirectDamage;
    /**
     * Returns: Возвращает радиус <<Огненного шара>>.
     */
    double fireballRadius;
    /**
     * Returns: Возвращает скорость полёта <<Огненного шара>>.
     */
    double fireballSpeed;
    /**
     * Returns: Возвращает радиус области, в которой живые юниты получают максимальный урон от взрыва <<Огненного шара>>.
     * See_Also: #getFireballExplosionMaxDamage ()
     */
    double fireballExplosionMaxDamageRange;
    /**
     * Returns: Возвращает радиус области, в которой живые юниты получают какой-либо урон от взрыва <<Огненного шара>>.
     * See_Also: #getFireballExplosionMaxDamage ()
     */
    double fireballExplosionMinDamageRange;
    /**
     * Returns: Возвращает урон <<Огненного шара>> в эпицентре взрыва.
     * $(BR)
     * Живой юнит получает `fireballExplosionMaxDamage` единиц урона, если расстояние от центра взрыва до
     * ближайшей точки этого юнита не превышает `fireballExplosionMaxDamageRange`. По мере увеличения расстояния
     * до `fireballExplosionMinDamageRange`, урон <<Огненного шара>> равномерно снижается и достигает
     * `fireballExplosionMinDamage`. Если расстояние от центра взрыва до ближайшей точки живого юнита превышает
     * `fireballExplosionMinDamageRange`, то урон ему не наносится.
     * $(BR)
     * Если живой юнит получил какой-либо урон от взрыва <<Огненного шара>>, то он загорается (`burning`).
     */
    int fireballExplosionMaxDamage;
    /**
     * Returns: Возвращает урон <<Огненного шара>> на периферии взрыва.
     * See_Also: #getFireballExplosionMaxDamage ()
     */
    int fireballExplosionMinDamage;
    /**
     * Returns: Возвращает радиус охранной башни.
     */
    double guardianTowerRadius;
    /**
     * Returns: Возвращает максимальное расстояние (от центра до центра), на котором охранная башня обнаруживает другие
     * объекты.
     */
    double guardianTowerVisionRange;
    /**
     * Returns: Возвращает начальное значение жизненной энергии охранной башни.
     */
    double guardianTowerLife;
    /**
     * Returns: Возвращает максимальное расстояние (от центра до центра), на котором охранная башня может атаковать
     * другие объекты.
     */
    double guardianTowerAttackRange;
    /**
     * Returns: Возвращает урон одной атаки охранной башни.
     */
    int guardianTowerDamage;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными атаками охранной башни.
     */
    int guardianTowerCooldownTicks;
    /**
     * Returns: Возвращает радиус базы фракции.
     */
    double factionBaseRadius;
    /**
     * Returns: Возвращает максимальное расстояние (от центра до центра), на котором база фракции обнаруживает другие
     * объекты.
     */
    double factionBaseVisionRange;
    /**
     * Returns: Возвращает начальное значение жизненной энергии базы фракции.
     */
    double factionBaseLife;
    /**
     * Returns: Возвращает максимальное расстояние (от центра до центра), на котором база фракции может атаковать
     * другие объекты.
     */
    double factionBaseAttackRange;
    /**
     * Returns: Возвращает урон одной атаки базы фракции.
     */
    int factionBaseDamage;
    /**
     * Returns: Возвращает минимально возможную задержку между двумя последовательными атаками базы фракции.
     */
    int factionBaseCooldownTicks;
    /**
     * Returns: Возвращает длительность действия статуса `burning`.
     */
    int burningDurationTicks;
    /**
     * Returns: Возвращает суммарный урон, получаемый живым юнитом за время действия статуса `burning`.
     */
    int burningSummaryDamage;
    /**
     * Returns: Возвращает длительность действия статуса `empowered`.
     */
    int empoweredDurationTicks;
    /**
     * Returns: Возвращает мультипликатор урона, наносимого живым юнитом под действием статуса `empowered`.
     * $(BR)
     * Мультипликатор применяется к ударам в ближнем бою, прямым попаданиям снарядов, а также взрыву <<Огненного шара>>,
     * но не применяется к урону, получаемому от статусов.
     */
    double empoweredDamageFactor;
    /**
     * Returns: Возвращает длительность действия статуса `frozen`.
     */
    int frozenDurationTicks;
    /**
     * Returns: Возвращает длительность действия статуса `hastened`.
     */
    int hastenedDurationTicks;
    /**
     * Returns: Возвращает мультилпикатор длительности действия статуса `hastened` в случае подбора бонуса.
     */
    double hastenedBonusDurationFactor;
    /**
     * Returns: Возвращает относительное увеличение скорости перемещения в результате дествия статуса `hastened`.
     * $(BR)
     * Увеличение скорости от действия статуса `hastened` и увеличение скорости в результате изучения умений,
     * являющихся пререквизитами умения `haste`, являются аддитивными. Таким образом, максимальное значение
     * скорости волшебника составляет
     * `1.0 + 4.0 * movementBonusFactorPerSkillLevel + hastenedMovementBonusFactor` от базовой.
     */
    double hastenedMovementBonusFactor;
    /**
     * Returns: Возвращает относительное увеличение скорости поворота в результате дествия статуса `hastened`.
     */
    double hastenedRotationBonusFactor;
    /**
     * Returns: Возвращает длительность действия статуса `shielded`.
     */
    int shieldedDurationTicks;
    /**
     * Returns: Возвращает мультилпикатор длительности действия статуса `shielded` в случае подбора бонуса.
     */
    double shieldedBonusDurationFactor;
    /**
     * Returns: Возвращает часть урона, поглощаемую щитом.
     * $(BR)
     * Снижение урона применяется к ударам в ближнем бою, прямым попаданиям снарядов, а также взрыву <<Огненного шара>>,
     * но не применяется к урону, получаемому от статусов.
     */
    double shieldedDirectDamageAbsorptionFactor;
    /**
     * Returns: Возвращает дальность действия аур.
     */
    double auraSkillRange;
    /**
     * Returns: Возвращает абсолютное увеличение дальности заклинаний волшебника за каждое последовательное изучение
     * умения, являющегося одним из пререквизитов умения `advancedMagicMissile`.
     */
    double rangeBonusPerSkillLevel;
    /**
     * Returns: Возвращает абсолютное увеличение урона, наносимого волшебником в результате прямых попаданий магических
     * снарядов и взрыва <<Огненного шара>>, за каждое последовательное изучение умения, являющегося одним из
     * пререквизитов умения `frostBolt`.
     */
    int magicalDamageBonusPerSkillLevel;
    /**
     * Returns: Возвращает абсолютное увеличение урона, наносимого волшебником в ближнем бою, за каждое последовательное
     * изучение умения, являющегося одним из пререквизитов умения `fireball`.
     */
    int staffDamageBonusPerSkillLevel;
    /**
     * Returns: Возвращает относительное увеличение скорости перемещения за каждое последовательное изучение умения,
     * являющегося одним из пререквизитов умения `haste`.
     * $(BR)
     * Увеличение скорости от действия статуса `hastened` и увеличение скорости в результате изучения умений,
     * являющихся пререквизитами умения `haste`, являются аддитивными. Таким образом, максимальное значение
     * скорости волшебника составляет
     * `1.0 + 4.0 * movementBonusFactorPerSkillLevel + hastenedMovementBonusFactor` от базовой.
     */
    double movementBonusFactorPerSkillLevel;
    /**
     * Returns: Возвращает абсолютное уменьшение урона, получаемого волшебником в результате прямых попаданий магических
     * снарядов, взрыва <<Огненного шара>> и атак строений, за каждое последовательное изучение умения, являющегося
     * одним из пререквизитов умения `shield`.
     */
    int magicalDamageAbsorptionPerSkillLevel;

    this (
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
        immutable int [] levelUpXpValues,
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
        this.levelUpXpValues = levelUpXpValues;
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
