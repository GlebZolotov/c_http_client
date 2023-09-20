using BinaryBuilder, Pkg

name = "LibCHTTPClient"
version = v"1.0.0"
sources = [
    GitSource("https://github.com/GlebZolotov/c_http_client.git", "cc69385d977cfe4fc1ad96c0989cea8fb7d4a029"),
]

script = raw"""
cd ${WORKSPACE}/srcdir/c_http_client
make -j${nproc}
"""

platforms = [
    BinaryBuilder.Platform("x86_64", "linux")
]

products = [
    LibraryProduct("http_client.so", :lib_c_http_client),
]

dependencies = [
    Dependency("LibCURL_jll"),
]

build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies, julia_compat="1.6")