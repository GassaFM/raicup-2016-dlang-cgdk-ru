module model.move;

import model.message;
import model.action_type;
import model.skill_type;

/**
 * Стратегия игрока может управлять волшебником посредством установки свойств объекта данного класса.
 */
class Move
{
    /**
     * Задаёт установку скорости перемещения на один тик.
     * $(BR)
     * Установка скорости перемещения по умолчанию лежит в интервале от `-game.wizardBackwardSpeed` до
     * `game.wizardForwardSpeed`, однако границы интервала могут быть расширены в зависимости от изученных
     * волшебником умений, от действия некоторых аур, а также в случае действия статуса `hastened`.
     * $(BR)
     * Значения, выходящие за интервал, будут приведены к ближайшей его границе.
     * Положительные значения соответствуют движению вперёд.
     * $(BR)
     * Если `hypot (speed / maxSpeed, strafeSpeed / maxStrafeSpeed)` больше `1.0`, то обе установки скорости
     * перемещения (`speed` и `strafeSpeed`) будут поделены игровым симулятором на это значение.
     */
    double speed = 0.0;
    /**
     * Задаёт установку скорости перемещения боком на один тик.
     * $(BR)
     * Установка скорости перемещения по умолчанию лежит в интервале от `-game.wizardStrafeSpeed` до
     * `game.wizardStrafeSpeed`, однако границы интервала могут быть расширены в зависимости от изученных
     * волшебником умений, от действия некоторых аур, а также в случае действия статуса `hastened`.
     * $(BR)
     * Значения, выходящие за интервал, будут приведены к ближайшей его границе.
     * Положительные значения соответствуют движению направо.
     * $(BR)
     * Если `hypot (speed / maxSpeed, strafeSpeed / maxStrafeSpeed)` больше `1.0`, то обе установки скорости
     * перемещения (`speed` и `strafeSpeed`) будут поделены игровым симулятором на это значение.
     */
    double strafeSpeed = 0.0;
    /**
     * Устанавливает угол поворота волшебника.
     * $(BR)
     * Угол поворота задаётся в радианах относительно текущего направления волшебника и обычно ограничен интервалом от
     * `-game.wizardMaxTurnAngle` до `game.wizardMaxTurnAngle`. Если на волшебника действует магический
     * статус `hastened`, то нижнюю и правую границу интервала необходимо умножить на
     * `1.0 + game.hastenedRotationBonusFactor`.
     * $(BR)
     * Значения, выходящие за интервал, будут приведены к ближайшей его границе.
     * Положительные значения соответствуют повороту по часовой стрелке.
     */
    double turn = 0.0;
    /**
     * Устанавливает действие волшебника.
     * $(BR)
     * Действие может быть проигнорировано игровым симулятором, если у волшебника недостаточно магической энергии для
     * его совершения и/или волшебник ещё не успел восстановиться после предыдущего действия.
     */
    ActionType action = ActionType.unknown;
    /**
     * Устанавливает угол полёта магического снаряда.
     * $(BR)
     * Угол полёта задаётся в радианах относительно текущего направления волшебника и ограничен интервалом от
     * `-game.staffSector / 2.0` до `game.staffSector / 2.0`.
     * $(BR)
     * Значения, выходящие за интервал, будут приведены к ближайшей его границе.
     * Положительные значения соответствуют повороту по часовой стрелке.
     * $(BR)
     * Параметр будет проигнорирован игровым симулятором, если действие волшебника не связано с созданием магического
     * снаряда.
     */
    double castAngle = 0.0;
    /**
     * Устанавливает ближнюю границу боевого применения магического снаряда.
     * $(BR)
     * Если расстояние от центра снаряда до точки его появления меньше, чем значение данного параметра, то боевые
     * свойства снаряда игнорируются. Снаряд беспрепятственно проходит сквозь все другие игровые объекты, за исключением
     * деревьев.
     * $(BR)
     * Значение параметра по умолчанию равно `0.0`. Столкновения снаряда и юнита, который его создал,
     * игнорируются.
     * $(BR)
     * Параметр будет проигнорирован игровым симулятором, если действие волшебника не связано с созданием магического
     * снаряда.
     */
    double minCastDistance = 0.0;
    /**
     * Устанавливает дальнюю границу боевого применения магического снаряда.
     * $(BR)
     * Если расстояние от центра снаряда до точки его появления больше, чем значение данного параметра, то снаряд
     * убирается из игрового мира. При этом, снаряд типа `fireball` детонирует.
     * $(BR)
     * Значение параметра по умолчанию заведомо выше максимальной дальности полёта любого типа снарядов в игре.
     * $(BR)
     * Параметр будет проигнорирован игровым симулятором, если действие волшебника не связано с созданием магического
     * снаряда.
     */
    double maxCastDistance = 10000.0;
    /**
     * Устанавливает идентификатор цели для применения магического статуса.
     * $(BR)
     * Допустимыми целями являются только волшебники дружественной фракции. Если волшебник с указанным идентификатором
     * не найден, то статус применяется непосредственно к волшебнику, совершающему действие. Относительный угол до цели
     * должен лежать в интервале от `-game.staffSector / 2.0` до `game.staffSector / 2.0`, а максимальная
     * дистанция ограничена дальностью полёта магического снаряда этого волшебника. Её базовое значение равно
     * `game.wizardCastRange`, однако оно может быть увеличено после изучения некоторых умений.
     * $(BR)
     * Значение параметра по умолчанию равно `-1`.
     * $(BR)
     * Параметр будет проигнорирован игровым симулятором, если действие волшебника не связано с применением магического
     * статуса.
     */
    long statusTargetId = -1L;
    /**
     * Задаёт установку изучить указанное умение до начала следующего игрового тика.
     * $(BR)
     * Установка будет проигнорирована игровым симулятором, если текущий уровень волшебника меньше либо равен количеству
     * уже изученных умений. Некоторые умения также могут требовать предварительного изучения других умений.
     * $(BR)
     * Изучение умений доступно не во всех режимах игры.
     */
    SkillType skillToLearn = SkillType.unknown;
    /**
     * Устанавливает сообщения для волшебников дружественной фракции.
     * $(BR)
     * Доступно для использования только верховному волшебнику (`wizard.master`). Если используется, количество
     * сообщений должно быть строго равно количеству волшебников дружественной фракции (живых или ожидающих возрождения)
     * за исключением самого верховного волшебника. Нарушение данных условий может привести к игнорированию параметра
     * игровым симулятором или даже к обрыву соединения со стратегией участника.
     * $(BR)
     * Сообщения адресуются в порядке возрастания идентификаторов волшебников. Отдельные сообщения могут быть пустыми
     * (равны `null`), если это поддерживается языком программирования, который использует стратегия. В противном
     * случае все элементы должны быть корректными сообщениями.
     * $(BR)
     * Игровой симулятор вправе проигнорировать сообщение конкретному волшебнику, если для него в системе уже
     * зарегистрировано и ещё им не получено другое сообщение. Если в тик получения сообщения волшебник мёртв, то
     * данное сообщение будет удалено из игрового мира и волшебник никогда его не получит.
     * $(BR)
     * Отправка сообщений доступна не во всех режимах игры.
     */
    immutable (Message) [] messages;
}
