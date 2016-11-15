module my_strategy;

import model;
import strategy;

final class MyStrategy : Strategy
{
    void move (immutable Wizard self, immutable World world,
        immutable Game game, Move move)
    {
        move.speed = game.wizardForwardSpeed;
        move.strafeSpeed = game.wizardStrafeSpeed;
        move.turn = game.wizardMaxTurnAngle;
        move.action = ActionType.magicMissile;
/*
        move.messages ~= new immutable Message
            (LaneType.top, SkillType.rangeBonusPassive1,
            [0, 127, -128]);
*/
    }
}
