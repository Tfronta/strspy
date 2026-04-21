## Important: This fork fixes 5 bugs found in STRspy v2.0

During forensic STR benchmarking on ONT data (17 samples, 52 loci, GRCh38),
five bugs were identified in the original STRspy v2.0 that cause systematic
NA results. All bugs are fixed in this fork.

See full bug report: [Issue #14](https://github.com/unique379r/strspy/issues/14)

### Bugs fixed
- **Bug 1** — Wrapper script checks for v1.1 filenames instead of v2.0
- **Bug 2** — BuildDB generates negative BED coordinates for some loci
- **Bug 3** — vWA.bed gets corrupt chromosome name → vWA always NA
- **Bug 4** — BuildDB outputs `_finalDB.fa` but STRspy expects `.fa`
- **Bug 5** — BuildDB generates FASTAs with `mod` suffix not recognized by STRspy

### Quickstart with pre-built fixed database

Instead of running BuildDB, use the pre-built fixed database included in this fork:

```bash
git clone --branch STRspy2.0 https://github.com/Tfronta/strspy.git
cd strspy
bash setup/STRspy_2.0.setup.sh
conda activate strspy_env
```

Set `STR_FASTA` and `STR_BED` in `config/InputConfig.txt` to:
db-v2/STRspy2.0-DB-fixed

### If you regenerate the database with BuildDB

Run the included utility to fix FASTA naming:
```bash
bash db-v2/optional-create-custom-db/fix_db_names.sh <path_to_DB_dir>
```

---
