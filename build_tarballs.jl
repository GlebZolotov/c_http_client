using BinaryBuilder, Pkg

name = "LibCHTTPClient"
version = v"1.0.0"
sources = [
    GitSource("https://github.com/GlebZolotov/c_http_client.git", "a0b97c440357efb3efe4eba9b4ac9a87d4e43244"),
]

script = raw"""
cd ${WORKSPACE}/srcdir/c_http_client
make -j${nproc}
"""

platforms = [
    BinaryBuilder.Platform("x86_64", "linux")
]

products = [
    LibraryProduct("http_client", :lib_c_http_client),
]

dependencies = [
    Dependency("LibCURL_jll"),
]

build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies, julia_compat="1.6")