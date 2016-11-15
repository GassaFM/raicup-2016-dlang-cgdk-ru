module strategy;

import model.game;
import model.move;
import model.wizard;
import model.world;

public interface Strategy
{
    void move (immutable Wizard self, immutable World world,
        immutable Game game, Move move);
}
