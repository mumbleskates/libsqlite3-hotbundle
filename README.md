# libsqlite3-hotbundle

A fork of `libsqlite3-sys` that bundles a more recent version of sqlite3.

## Usage

In your `Cargo.toml`, include `libsqlite3-hotbundle` as a dependency alongside
an application that otherwise uses `libsqlite3-sys` in *non-bundled* mode. The
"hotbundle" will include a bundled version of the sqlite3 library that should
then be chosen instead of the system's sqlite3 library or the version of the
sqlite3 library that `libsqlite3-sys` would have bundled.

```toml
libsqlite3-hotbundle = "1.470200"
```
