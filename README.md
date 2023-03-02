# EqualsOverhead

Exploring overhead cost of using `==` in `== true` or ` == false`.

[hborla](https://forums.swift.org/t/swift-equality-operator-takes-long-time-to-type-check/41226/9)

> With operators, the compiler has to consider every overload of == regardless of what type or protocol it's declared on, because operators are always called like global functions.
