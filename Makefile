# Change the next line to your local runner's working directory
LOCAL_RUNNER_HOME = /some/path/local-runner-ru
DC = dmd
DFLAGS = -O -release -inline -noboundscheck -wi -m32
DDEBUGFLAGS = -g -debug -debug=io -unittest -wi -m32
LOCAL_RUNNER = java -Xms512m -Xmx2G -server -jar "local-runner.jar" local-runner.properties local-runner.default.properties &

SRC=$(wildcard *.d) $(wildcard model/*.d)

all : MyStrategy

MyStrategy : $(SRC)
	$(DC) $(DFLAGS) $(SRC) -of$@

debug : $(SRC)
	$(DC) $(DDEBUGFLAGS) $(SRC) -of$@

run : MyStrategy
	cd $(LOCAL_RUNNER_HOME) && $(LOCAL_RUNNER)
	sleep 2
	./MyStrategy

clean :
	$(RM) MyStrategy MyStrategy.exe *.o *.obj compilation.log result.txt
