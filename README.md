# Build Blender or dependency libraries

Usage:

Build the Docker image with

```
# docker build . -t blender-build
```

First run the library building:

```
# docker run --rm -ti --mount type=bind,source=/your/blender/source,target=/data/blender --mount type=bind,source=/your/blender/dependency/lib,target=/data/lib --mount type=bind,source=/your/blender/builddir,target=/data/build blender-build buildlibs
```

Then you can just build the Blender itself:

```

# docker run --rm -ti --mount type=bind,source=/your/blender/source,target=/data/blender --mount type=bind,source=/your/blender/dependency/lib,target=/data/lib --mount type=bind,source=/your/blender/builddir,target=/data/build blender-build build
```
