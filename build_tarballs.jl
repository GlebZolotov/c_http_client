using BinaryBuilder, Pkg

name = "LibCHTTPClient"
version = v"1.0.0"
sources = [
    GitSource("https://github.com/GlebZolotov/c_http_client.git", "b869684102c6c19316bd85109b31dce82c40a5e9"),
]

script = raw"""
cd ${WORKSPACE}/srcdir/c_http_client
make LDFLAGS="-L${libdir} -I{$includedir}" -j${nproc}
make PREFIX=${WORKSPACE}/destdir install
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