#LuaJVM


A JVM in Lua which JITs Java bytecode to Lua bytecode (Lua 5.1/5.2) rather than interpreting. It doesn't work with LuaJIT2 which doesn't support the bytecode format of vanilla Lua. 

Original code: [JVML](https://github.com/ds84182/JVML), [JVML-JIT](https://github.com/Yevano/JVML-JIT )

##Howto
### Compile Java code

    cd CCLib
    ant
    cd ../tests
    ant

### Start the JVM

    cd bin
    lua jvml -cp ../tests/build SimpleTest
