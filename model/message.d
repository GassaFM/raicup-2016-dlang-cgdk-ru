module model.message;

import model.skill_type;
import model.lane_type;

/**
 * Класс определяет сообщение, которое верховный волшебник (`wizard.master`) может отправлять другим членам
 * фракции, используя телепатическую связь.
 * $(BR)
 * Сообщение отправляется персонально каждому волшебнику. Другие волшебники не могут его перехватить.
 * $(BR)
 * Адресат получает сообщение в следующий игровой тик или позднее, в зависимости от размера сообщения.
 * $(BR)
 * Волшебник волен проигнорировать как любую отдельную часть сообщения, так и всё сообщение целиком, однако это может
 * привести к поражению дружественной фракции.
 */
immutable class Message
{
    /**
     * Returns: Возвращает указание контролировать определённую дорожку.
     */
    LaneType lane;
    /**
     * Returns: Возвращает указание изучить какое-либо умение.
     * $(BR)
     * Умение может требовать предварительного изучения других умений или быть недоступно для изучения в данный момент в
     * связи с низким уровнем волшебника. Волшебнику рекомендуется запомнить указание и двигаться в направлении его
     * реализации. При этом, более позднее указание должно считаться более приоритетным.
     * $(BR)
     * Значение поля может быть доступно не во всех режимах игры.
     */
    SkillType skillToLearn;
    /**
     * Returns: Возвращает текстовое сообщение на забытом древнем языке.
     * $(BR)
     * Максимальная длина сообщения составляет `game.rawMessageMaxLength`. При этом, скорость отправки сообщения
     * зависит от его длины. Если текстовая часть сообщения пуста, то адресат получит его уже в следующий игровой тик.
     * В противном случае, момент получения сообщения будет отложен на
     * `ceil (rawMessage.length / game.rawMessageTransmissionSpeed)` игровых тиков.
     * $(BR)
     * Значение поля может быть доступно не во всех режимах игры.
     */
    byte [] rawMessage;

    this (
        immutable (LaneType) lane,
        immutable (SkillType) skillToLearn,
        const (byte) [] rawMessage)
    {
        this.lane = lane;
        this.skillToLearn = skillToLearn;
        this.rawMessage = rawMessage.idup;
    }
}
