module model.player_context;

import model.world;
import model.wizard;

immutable class PlayerContext
{
nothrow pure @safe @nogc:

    Wizard [] wizards;
    World world;

    this (
        immutable Wizard [] wizards,
        immutable World world)
    {
        this.wizards = wizards;
        this.world = world;
    }
}
