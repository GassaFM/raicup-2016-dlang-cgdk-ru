module model.minion_type;

/**
 * Тип приспешника.
 */
enum MinionType : byte
{
    /**
     * Значение по умолчанию.
     */
    unknown = -1,

    /**
     * Боец ближнего боя и, по совместительству, мастер на все руки. Помогает волшебнику в хозяйстве.
     * $(BR)
     * Не так силён, как воин орков, но для потерявшего бдительность противника может быть весьма опасен.
     */
    orcWoodcutter,

    /**
     * Магическое создание, поражающее противников хозяина острыми дротиками. В мирное время занимается охотой.
     */
    fetishBlowdart
}
