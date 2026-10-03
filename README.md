# github-final-project

[![CI](https://github.com/konethegreat/github-final-project/actions/workflows/ci.yml/badge.svg)](https://github.com/konethegreat/github-final-project/actions/workflows/ci.yml)

A bash script that calculates simple interest from a principal amount, a time period in years and an annual rate of interest.

## About this repository

This is a learning (coursework) project, not a maintained tool. The script's own header says "Do not use this in production. Sample purpose only."

- **Origin.** The script header credits Upkar Lidder (IBM). The first version of this README used a sentence that also appears in the README of an IBM Skills Network lab repository, which is forked here as [mcino-Introduction-to-Git-and-GitHub](https://github.com/konethegreat/mcino-Introduction-to-Git-and-GitHub). This repository does not record which course or assignment it was made for.
- **Difference from the lab script.** The script in that lab repository asks for the rate before the time period and uses integer `expr` arithmetic. This version asks for the time period first and calculates with `bc` to two decimals.
- **Who wrote what.** The first six commits (20 and 21 April 2026) are by Kone Tshivhinda (`konethegreat`): the initial commit, the README, the code of conduct, the contributing notes and the script. The script header keeps the course credit. `.gitattributes`, the test script, the CI workflow and this README were added in October 2026.

## Usage

Requirements: bash and `bc`.

```bash
bash simple-interest.sh
```

The file is not marked executable in the repository, so start it with `bash` (or run `chmod +x simple-interest.sh` first). Example session, with the numbers typed after each prompt:

```text
Enter the principal:
1000
Enter time period in years:
2
Enter rate of interest per year:
5
The simple interest is: 
100.00
```

| Input | Meaning |
| ----- | ------- |
| `p` | principal amount |
| `t` | time period in years |
| `r` | annual rate of interest, in percent |

Output: simple interest = p * t * r / 100.

Things to know:

- The result is cut off at two decimals, not rounded: 2500.50, 1.5 years and 4.25 percent give `159.40` (the exact value is 159.406875).
- A result of zero is printed as `0`, not `0.00`.
- Input is not validated. With GNU bc, `abc` as the principal prints `0`, and a negative time period prints a negative amount (1000, -2 and 5 give `-100.00`).
- Git Bash from Git for Windows does not include `bc`; there the script prints `bc: command not found` and an empty result. Run it from a shell that has `bc`, for example WSL.

## Tests

```bash
bash tests/test-simple-interest.sh
```

The test script feeds fixed, made-up numbers to `simple-interest.sh` and compares the result line. It makes five checks (four calculations and one that the script has LF line endings), prints `All checks passed.` when they all pass and exits with status 1 otherwise. It needs bash and `bc`, like the script.

GitHub Actions runs [ShellCheck](https://www.shellcheck.net/) at warning level on both scripts and then the test script, on every push to `main` and every pull request (`.github/workflows/ci.yml`). ShellCheck's lower-severity notes about the course script (`read` without `-r`, an unquoted variable) are not enforced.

## Line endings

`.gitattributes` keeps `*.sh` files on LF line endings. Without it, Git for Windows (with its default `core.autocrlf=true`) checks the scripts out with CRLF and bash fails with `$'\r': command not found`.

## Files

| Path | Purpose |
| ---- | ------- |
| `simple-interest.sh` | The calculator. |
| `tests/test-simple-interest.sh` | The checks described above. |
| `.github/workflows/ci.yml` | ShellCheck and the test script on GitHub Actions. |
| `.gitattributes` | Keeps shell scripts on LF line endings. |
| `CONTRIBUTING.md` | Short contribution notes. |
| `CODE_OF_CONDUCT.md` | Contributor Covenant, version 2.0, with its attribution. |
| `LICENSE` | Apache License 2.0. |

## License

Licensed under the Apache License 2.0; see [LICENSE](LICENSE).
