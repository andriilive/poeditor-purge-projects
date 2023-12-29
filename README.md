# Bulk purge Poeditor projects script

[![StandWithUkraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

This script will delete all projects from your Poeditor account.

Create `.env` file with your Poeditor API token and run the script:

```shell
cp .env.example .env
sh poeditor-purge-projects.sh
```

Alternative way to run the script:

```shell
POEDITOR_TOKEN=xxx sh poeditor-purge-projects.sh
```

---

[Get API token](https://poeditor.com/account/api) | [API docs](https://poeditor.com/docs/api) | [More Poeditor API shell scripts](https://github.com/andriilive/poeditor-exports-placement)
