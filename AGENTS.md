# Global Development Standards

Applies to all projects. Project AGENTS.md overrides these defaults.

- Web search: `mcp__exa__web_search_exa` (Exa AI), not `WebSearch`
- Use skills proactively when they match the task — suggest, don't gate on them

## Philosophy

- **No speculative features** — don't add features/flags/config until users actively need them
- **No premature abstraction** — extract utilities only after the same code is written 3x
- **Clarity over cleverness** — explicit, readable code over dense one-liners
- **Justify new dependencies** — each one is attack surface + maintenance burden
- **No phantom features** — don't document or validate what isn't implemented
- **Replace, don't deprecate** — when new code replaces old, remove the old entirely; no shims, dual config formats, or migration paths. Flag dead code proactively — it costs maintenance and misleads devs and LLMs alike
- **Verify at every level** — automated guardrails (linters, type checkers, pre-commit hooks, tests) first, not last. Prefer structure-aware tools (ast-grep, LSPs, compilers) over text pattern matching. Review your own output critically
- **Bias toward action** — decide and move on anything easily reversed; state assumptions so reasoning is visible. Ask before committing to interfaces, data models, architecture, or destructive/write ops on external services
- **Finish the job** — handle visible edge cases, clean up what you touched, flag adjacent breakage. Don't invent scope — thoroughness ≠ gold-plating
- **Agent-native by default** — design so agents can achieve any outcome users can. Tools = atomic primitives; features = outcomes described in prompts. Prefer file-based state for transparency/portability. New UI capability → ask: can an agent get this outcome too?

## Code Quality

### Hard limits

- ≤100 lines/function, cyclomatic complexity ≤8
- ≤5 positional params
- 100-char line length
- Absolute imports only — no relative (`..`) paths
- Google-style docstrings on non-trivial public APIs

### Zero-warnings policy

Fix every warning — linters, type checkers, compilers, tests. Can't fix it? Inline ignore + justification comment. Clean output is the baseline, not the goal.

### Comments

Code should be self-documenting. No commented-out code — delete it. Comment explains WHY, never WHAT — if you need to explain what the code does, refactor it instead.

### Error handling

- Fail fast, with clear actionable messages
- Never swallow exceptions silently
- Include context: operation, input, suggested fix

### Code review

Order: architecture → code quality → tests → performance. `git fetch origin` before starting.
Per issue: file:line reference → options + tradeoffs (if fix isn't obvious) → recommendation → ask before proceeding.

### Testing

- **Behavior, not implementation** — tests verify what code does, not how. Refactor breaks tests but not behavior → the tests were wrong
- **Edges and errors, not just happy path** — empty inputs, boundaries, malformed data, missing files, network failures. Every handled error path needs a test that triggers it
- **Mock boundaries, not logic** — only slow (network, filesystem), non-deterministic (time, randomness), or external/uncontrolled services
- **Verify tests catch failures** — break the code, confirm the test fails, then fix. Mutation testing (`cargo-mutants`, `mutmut`) to verify systematically. Property-based testing (`proptest`, `hypothesis`) for parsers, serialization, algorithms

## Development

Look up current stable versions for new deps, CI actions, tool versions — never assume from memory unless the user provides one.

### CLI tools

| tool | replaces | usage |
| --- | --- | --- |
| `rg` (ripgrep) | `grep` | `rg "pattern"` — fast regex search |
| `fd` | `find` | `fd "*.py"` — fast file finder |
| `ast-grep` | — | `ast-grep --pattern '$FUNC($$$)' --lang py` — AST-based code search |
| `shellcheck` | — | `shellcheck script.sh` — shell script linter |
| `shfmt` | — | `shfmt -i 2 -w script.sh` — shell formatter |
| `actionlint` | — | `actionlint .github/workflows/` — GitHub Actions linter |
| `zizmor` | — | `zizmor .github/workflows/` — Actions security audit |
| `prek` | `pre-commit` | `prek run` — fast git hooks (Rust, no Python) |
| `wt` | `git worktree` | `wt switch branch` — manage parallel worktrees |
| `rip` | `rm` | `rip file` — moves to a graveyard, undo with `rip -u`. **Never `rm -rf`** |

`ast-grep` > ripgrep for code structure (calls, class defs, imports, arg patterns). Ripgrep for literal strings and log messages.

### Multi-language projects

`mise` whenever a project spans more than one language runtime. One `mise.toml` pins every toolchain instead of scattered `.nvmrc`, `.python-version`, `rust-toolchain.toml`.

```toml
[tools]
python = "3.13"
node = "22"
rust = "stable"

[env]
_.file = ".env"

[tasks.check]
run = ["uv run pytest -q", "pnpm vitest run", "cargo test"]
```

- Commit `mise.toml`; `mise.local.toml` gitignored for machine-specific overrides
- Pin exact versions — never `latest`
- `mise install` to provision, `mise run <task>` for anything crossing language boundaries
- Runtimes only — dependencies stay with `uv`, `pnpm`, `cargo` as below
- Single-language projects don't need it — use that language's native tooling directly

### Python

**Runtime:** 3.13, `uv venv`

| purpose | tool |
| --- | --- |
| deps & venv | `uv` |
| lint & format | `ruff check` · `ruff format` |
| static types | `ty check` |
| tests | `pytest -q` |

`uv`/`ruff`/`ty` > pip/poetry, black/pylint/flake8, mypy/pyright — faster, stricter. `ty` strictness via `[tool.ty.rules]` in pyproject.toml. `uv_build` for pure Python, `hatchling` for extensions.

Tests in `tests/`, mirroring package structure. Supply chain: `pip-audit` before deploy, pin exact versions (`==`), verify hashes (`uv pip install --require-hashes`).

### Node/TypeScript

**Runtime:** Node 22 LTS, ESM only (`"type": "module"`)

| purpose | tool |
| --- | --- |
| lint | `oxlint` |
| format | `oxfmt` |
| test | `vitest` |
| types | `tsc --noEmit` |

`oxlint`/`oxfmt` > eslint/prettier — faster, stricter. Enable `typescript`, `import`, `unicorn` plugins.

**tsconfig.json** — enable all:

```jsonc
"strict": true,
"noUncheckedIndexedAccess": true,
"exactOptionalPropertyTypes": true,
"noImplicitOverride": true,
"noPropertyAccessFromIndexSignature": true,
"verbatimModuleSyntax": true,
"isolatedModules": true
```

Colocated `*.test.ts` files. Supply chain: `pnpm audit --audit-level=moderate` before install, pin exact versions (no `^`/`~`), 24h publish delay (`pnpm config set minimumReleaseAge 1440`), block postinstall scripts (`pnpm config set ignore-scripts true`).

### Rust

**Runtime:** latest stable via `rustup`

| purpose | tool |
| --- | --- |
| build & deps | `cargo` |
| lint | `cargo clippy --all-targets --all-features -- -D warnings` |
| format | `cargo fmt` |
| test | `cargo test` |
| supply chain | `cargo deny check` (advisories, licenses, bans) |
| safety check | `cargo careful test` (stdlib debug assertions + UB checks) |

**Style:**

- `for` loops with mutable accumulators > iterator chains
- Shadow variables through transformations — no `raw_x`/`parsed_x` prefixes
- Patterns that break on type changes: no `_` arms, exhaustive `match` > `matches!`, explicit fields > `..`
- `let...else` for early returns; keep happy path unindented

**Type design:**

- Newtypes over primitives (`UserId(u64)` not `u64`)
- Enums for state machines, not boolean flags
- `thiserror` for libraries, `anyhow` for applications
- `tracing` for logging (`error!`/`warn!`/`info!`/`debug!`), not println

**Optimization:**

- Correct algorithm, appropriate data structures, no unnecessary allocations — by default
- Profile before micro-optimizing; measure after

**Cargo.toml lints:**

```toml
[lints.clippy]
pedantic = { level = "warn", priority = -1 }
# Panic prevention
unwrap_used = "deny"
expect_used = "warn"
panic = "deny"
panic_in_result_fn = "deny"
unimplemented = "deny"
# No cheating
allow_attributes = "deny"
# Code hygiene
dbg_macro = "deny"
todo = "deny"
print_stdout = "deny"
print_stderr = "deny"
# Safety
await_holding_lock = "deny"
large_futures = "deny"
exit = "deny"
mem_forget = "deny"
# Pedantic relaxations (too noisy)
module_name_repetitions = "allow"
similar_names = "allow"
```

### Bash

`set -euo pipefail` at the top of every script. Lint: `shellcheck script.sh && shfmt -d script.sh`

### GitHub Actions

Pin actions to SHA hashes with version comments: `actions/checkout@<full-sha>  # vX.Y.Z` (`persist-credentials: false`). `zizmor` scan before committing. Dependabot: 7-day cooldowns, grouped updates. `uv` ecosystem (not `pip`) for Python so Dependabot updates `uv.lock`.

## Workflow

**Before committing:**

1. Re-read changes for unnecessary complexity, redundant code, unclear naming
2. Run relevant tests — not the full suite
3. Run linters + type checker — fix everything before committing

**Commits:**

- Imperative mood, ≤72 char subject, one logical change per commit
- Never amend/rebase commits already pushed to shared branches
- Never push directly to main — feature branches + PRs
- Never commit secrets, API keys, credentials — `.env` files (gitignored) + environment variables

**Hooks & worktrees:**

- `prek install` in every repo. `prek run` before committing. Auto-updates: `prek auto-update --cooldown-days 7`
- Parallel subagents require worktrees. Each subagent works in its own worktree (`wt switch <branch>`), never the main repo. Never share working directories

**Pull requests:**
Describe what the code does now — not discarded approaches, prior iterations, or alternatives. Only the diff.

Plain, factual language. A bug fix is a bug fix, not a "critical stability improvement." Avoid: critical, crucial, essential, significant, comprehensive, robust, elegant.
