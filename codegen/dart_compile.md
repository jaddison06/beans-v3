# `dart compile` modes comparison

JIT snapshot didn't load libraries correctly, per https://github.com/dart-lang/sdk/issues/48122

Mode|Average fps
-|-
vm|27.8
Kernel (dill)|28.0
JIT snapshot|?
AOT snapshot|35.2
Executable|35.0

Clearly native code is faster, however AOT and executable builds had some weird scaling issues that need investigation. Sticking with dill for now.