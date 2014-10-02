#LuaJVM


A continuation of JVML which JITs Java bytecode to Lua bytecode rather than interpreting.

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
