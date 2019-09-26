repo for [thirdparty](git@github.com:westfly/thirdparty.git)
--
## HeadOnlyRepo
header only repo only make softlink in dir thirdparty
### concurrentqueue

[concurrentqueue](https://github.com/cameron314/concurrentqueue)

A fast multi-producer, multi-consumer lock-free concurrent queue for C++11

Simple Usage
```cpp
#include "concurrentqueue.h"
moodycamel::ConcurrentQueue<int> q;
q.enqueue(25);
int item;
bool found = q.try_dequeue(item);
assert(found && item == 25);
```
### trompeloeil

[trompeloeil](https://github.com/rollbear/trompeloeil)

### cista

[cista](https://github.com/felixguendling/cista)


### doctest

[doctest](https://github.com/onqtam/doctest)

### Catch2

[Catch2](https://github.com/catchorg/Catch2)

## CompileNeeded

[spdlog](https://github.com/gabime/spdlog)

[flatbuffers](https://github.com/google/flatbuffers)
