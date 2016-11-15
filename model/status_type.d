module model.status_type;

/**
 * Тип магического статуса, влияющего на живого юнита.
 */
enum StatusType : byte
{
    /**
     * Юнит горит. Каждый тик ему наносится некоторый урон.
     */
    burning,

    /**
     * Юнит наносит больше урона, чем обычно. Не применимо к урону, растянутому во времени.
     */
    empowered,

    /**
     * Юнит заморожен. Он не может перемещаться и выполнять какие-либо действия.
     */
    frozen,

    /**
     * Скорость поворота и перемещения юнита увеличена.
     */
    hastened,

    /**
     * Юнит получает меньше урона, чем обычно. Не применимо к урону, растянутому во времени.
     */
    shielded
}
