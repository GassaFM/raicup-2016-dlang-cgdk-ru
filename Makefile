DC = dmd
DFLAGS = -O -release -inline -noboundscheck -wi -m32
DDEBUGFLAGS = -g -debug -debug=io -unittest -wi -m32
LOCAL_RUNNER = java -jar local-runner.jar true false 3 result.txt true false

SRC=$(wildcard *.d) $(wildcard model/*.d)

all : MyStrategy

MyStrategy : $(SRC)
	$(DC) $(DFLAGS) $(SRC) -of$@

debug : $(SRC)
	$(DC) $(DDEBUGFLAGS) $(SRC) -of$@

run : MyStrategy
	$(LOCAL_RUNNER)&
	sleep 2
	./MyStrategy

clean :
	$(RM) MyStrategy MyStrategy.exe *.o *.obj compilation.log result.txt
