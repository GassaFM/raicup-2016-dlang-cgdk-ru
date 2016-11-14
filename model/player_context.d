module model.player_context;

import model.world;
import model.wizard;

immutable class PlayerContext
{
    immutable Wizard [] wizards;
    immutable World world;

    immutable this (
        immutable (Wizard) [] wizards,
        immutable (World) world)
    {
        this.wizards = wizards == null ? null : wizards.idup;
        this.world = world;
    }
}
