module runner;

import std.stdio;

import remote_process_client;
import my_strategy;

import model.game;
import model.move;
import model.player_context;
import model.wizard;

void main (string [] args)
{
    auto host = "127.0.0.1";
    auto port = "31001";
    auto token = "0000000000000000";
    if (args.length == 4)
    {
        host = args[1];
        port = args[2];
        token = args[3];
    }

    auto client = new RemoteProcessClient (host, port);
    scope (exit) {client.close ();}

    client.writeToken (token);
    client.writeProtocolVersion ();
    int teamSize = client.readTeamSize ();
    debug {writefln ("Team size: %d", teamSize);}
    auto game = client.readGameContextMessage ();

    auto strategies = new MyStrategy [teamSize];
    foreach (ref strategy; strategies)
    {
        strategy = new MyStrategy ();
    }

    while (true)
    {
        immutable PlayerContext playerContext =
            client.readPlayerContextMessage ();
        if (playerContext is null)
        {
            break;
        }

        auto playerWizards = playerContext.wizards;
        if (playerWizards is null || playerWizards.length != teamSize)
        {
            break;
        }

        auto moves = new Move [teamSize];
        foreach (wizardIndex, ref curMove; moves)
        {
            curMove = new Move ();
            strategies[wizardIndex]
                .move (playerWizards[wizardIndex],
                playerContext.world, game, curMove);
        }
        client.writeMovesMessage (moves);
    }
}
