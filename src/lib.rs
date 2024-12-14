#[cfg(test)]
mod test {
    #[test]
    fn test_bundled_version() {
        assert_eq!(effective_sqlite_version(), Ok(bundled_sqlite_version()));
    }

    fn effective_sqlite_version() -> rusqlite::Result<String> {
        Ok(rusqlite::Connection::open_in_memory()?.query_row(
            "SELECT sqlite_version();",
            [],
            |row| Ok(row.get(0)?),
        )?)
    }

    fn bundled_sqlite_version() -> String {
        let header_text = include_str!("../sqlite3/sqlite3.h");
        let mut expected_version = None;
        for line in header_text.lines() {
            let words: Vec<&str> = line.trim().split_ascii_whitespace().collect();
            match words.as_slice() {
                ["#define", "SQLITE_VERSION", version_str] => {
                    let Some(version_str) = version_str
                        .strip_prefix('"')
                        .and_then(|s| s.strip_suffix('"'))
                    else {
                        panic!("couldn't unwrap SQLITE_VERSION #define value {version_str:?}");
                    };
                    expected_version = Some(version_str.to_owned());
                    break;
                }
                _ => {}
            }
        }
        expected_version.expect("couldn't find SQLITE_VERSION in the header")
    }
}
