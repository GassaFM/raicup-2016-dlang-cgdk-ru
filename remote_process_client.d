module remote_process_client;

import std.bitmanip;
import std.conv;
import std.exception;
import std.range;
import std.socket;
import std.stdio;
import std.string;
import std.traits;
import std.typecons;

import model;

alias I (alias T) = T;

template WriteContents (T)
{
    string Impl ()
    {
        string res;
        alias member = I !(__traits (getMember, T, "__ctor"));
        alias types = ParameterTypeTuple !(member);
        alias names = ParameterIdentifierTuple !(member);
        foreach (i, type; types)
        {
            immutable string line = "write !(const " ~
                type.stringof ~ ") (t." ~ names[i] ~ ");\n";
            res ~= line;
        }
        return res;
    }

    immutable string WriteContents = Impl ();
}

template ReadContents (T)
{
    string Impl ()
    {
        string res;
        alias member = I !(__traits (getMember, T, "__ctor"));
        alias types = ParameterTypeTuple !(member);
        alias names = ParameterIdentifierTuple !(member);
        foreach (i, type; types)
        {
            immutable string line = "auto " ~ names[i] ~
                " = read !(" ~ type.stringof ~ ") ();\n";
            res ~= line;
        }
        return res;
    }

    immutable string ReadContents = Impl ();
}

template CallConstructor (T)
{
    string Impl ()
    {
        alias member = I !(__traits (getMember, T, "__ctor"));
        alias names = ParameterIdentifierTuple !(member);
        return "return new immutable T (" ~ [names].join (", ") ~ ");\n";
    }

    immutable string CallConstructor = Impl ();
}

enum MessageType : byte
{
    unknownMessage,
    gameOver,
    authenticationToken,
    teamSize,
    protocolVersion,
    gameContext,
    playerContext,
    moveMessage,
}

class RemoteProcessClient
{
public:
    this (string host, string port)
    {
        Address addr = getAddress (host, port)[0];
        socket = new Socket (addr.addressFamily, SocketType.STREAM);
        socket.setOption (SocketOptionLevel.TCP,
            SocketOption.TCP_NODELAY, true);
        socket.setOption (SocketOptionLevel.SOCKET,
            SocketOption.RCVBUF, 1 << 12);
        socket.connect (addr);
    }

    void writeToken (string token)
    {
        write (MessageType.authenticationToken);
        write (token);
    }

    int readTeamSize ()
    {
        enforce (read !(MessageType) == MessageType.teamSize);
        return read !(int);
    }

    void writeProtocolVersion ()
    {
        write (MessageType.protocolVersion);
        write !(int) (2);
    }

    auto readGameContextMessage ()
    {
        auto messageType = read !(MessageType) ();
        enforce (messageType == MessageType.gameContext);

        return read !(immutable Game) ();
    }

    auto readPlayerContextMessage ()
    {
        auto messageType = read !(MessageType) ();
        if (messageType == MessageType.gameOver)
        {
            return null;
        }
        enforce (messageType == MessageType.playerContext);

        return read !(immutable PlayerContext) ();
    }

    void writeMovesMessage (Move [] moves)
    {
        write (MessageType.moveMessage);

        write !(Move []) (moves);
    }

    void close ()
    {
        socket.close;
    }

private:
    Socket socket;

    Rebindable !(immutable Building []) buildingsCache;
    Rebindable !(immutable Player []) playersCache;
    Rebindable !(immutable Tree []) treesCache;

    auto read (T) ()
        if (is (T == class))
    {
        debug (io) {writeln (">read " ~ T.stringof);}
        debug (io) {scope (success) {writeln ("<read " ~ T.stringof);}}
        enforce (read !(bool));

//        pragma (msg, ReadContents !(T));
        mixin (ReadContents !(T));

        static if (is (Unqual !(T) == World))
        { // custom read: World has caching for some members
            if (buildings !is null)
            {
                buildingsCache = rebindable (buildings);
            }
            if (players !is null)
            {
                playersCache = rebindable (players);
            }
            if (trees !is null)
            {
                treesCache = rebindable (trees);
            }

/*
            pragma (msg, CallConstructor !(T)
                .replace ("buildings", "buildingsCache")
                .replace ("players", "playersCache")
                .replace ("trees", "treesCache"));
*/
            mixin (CallConstructor !(T)
                .replace ("buildings", "buildingsCache")
                .replace ("players", "playersCache")
                .replace ("trees", "treesCache"));
        }
        else
        { // general read for Model classes
//            pragma (msg, CallConstructor !(T));
            mixin (CallConstructor !(T));
        }
    }

    void write (T) (T t)
        if (is (T == class))
    {
        debug (io) {writeln (">write " ~ T.stringof);}
        debug (io) {scope (success) {writeln ("<write " ~ T.stringof);}}
        write !(bool) (true);

        static if (is (Unqual !(T) == Move))
        { // custom write: Move does not have an all-fields constructor
            write !(double) (t.speed);
            write !(double) (t.strafeSpeed);
            write !(double) (t.turn);
            write !(ActionType) (t.action);
            write !(double) (t.castAngle);
            write !(double) (t.minCastDistance);
            write !(double) (t.maxCastDistance);
            write !(long) (t.statusTargetId);
            write !(SkillType) (t.skillToLearn);
            write !(immutable Message []) (t.messages);
        }
        else
        { // generic write for model classes
//            pragma (msg, WriteContents !(T));
            mixin (WriteContents !(T));
        }
    }

    auto read (T : T [num], ulong num) ()
    {
        int len = read !(int) ();
        enforce (len == num);

        T [num] ret = void;
        foreach (ref val; ret)
        {
            val = read !(T) ();
        }
        return ret;
    }

    auto read (T : string) ()
    {
        int len = read !(int) ();
        enforce (len >= 0);
        return cast (string) (readBytesRuntime (len).idup);
    }

    void write (T : string) (T value)
    {
        write !(int) (cast (int) (value.length));
        writeBytes (cast (ubyte []) value);
    }

    auto read (T : T []) ()
    {
        debug (io) {writeln ("array read");}
        int len = read !(int) ();
        if (len < 0)
        {
            return null;
        }
        else
        {
            T [] ret;
            ret.reserve (len);
            foreach (i; 0..len)
            {
                ret ~= read !(T) ();
            }
            return ret;
        }
    }

    void write (T : T []) (T [] value)
    {
        if (value is null)
        {
            write !(int) (-1);
        }
        else
        {
            write !(int) (cast (int) (value.length));
            foreach (elem; value)
            {
                write !(T) (elem);
            }
        }
    }

    auto read (T) ()
        if (!is (T == class))
    {
        return littleEndianToNative !(T) (readBytes !(T.sizeof));
    }

    void write (T) (T value)
        if (!is (T == class))
    {
        writeBytes (nativeToLittleEndian (value));
    }

    auto readBytes (size_t byteCount) ()
    {
        ubyte [byteCount] bytes = readBytesRuntime (byteCount);
        return bytes;
    }

    auto readBytesRuntime (size_t byteCount)
    {
        auto bytes = new ubyte [byteCount];
        size_t offset = 0;
        while (offset < byteCount)
        {
            debug (io) {writeln ("in ", offset, " ", byteCount);}
            offset += socket.receive (bytes[offset..bytes.length]);
        }
        debug (io) {writeln ("read: ", bytes);}
        return bytes;
    }

    void writeBytes (const ubyte [] bytes)
    {
        size_t offset = 0;
        while (offset < bytes.length)
        {
            auto sent = socket.send (bytes[offset..bytes.length]);
            enforce (sent > 0);
            offset += sent;
        }
        debug (io) {writeln ("write: ", bytes);}
    }
}
