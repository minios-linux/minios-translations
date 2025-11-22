# MiniOS Translations

Centralized repository for all MiniOS translation files. This repository consolidates translations from multiple MiniOS components into a single, translator-friendly location.

## Structure

```
minios-translations/
├── po/                          # Gettext .po files
│   ├── minios-live/            # Main project translations
│   ├── grub/                   # GRUB bootloader menu
│   ├── minios-kernel-manager/  # Kernel Manager tool
│   ├── minios-installer/       # System Installer
│   ├── minios-session-manager/ # Session Manager
│   ├── minios-tools/           # Command-line tools (sb2iso, etc.)
│   ├── minios-configurator/    # System Configurator
│   ├── flux-tools/             # Flux desktop tools
│   ├── driveutility/           # Drive Utility (USB creator)
│   └── minios-live-config/     # Live system configuration
├── manpages/                    # Man page translations (po4a)
│   ├── minios-live/po/
│   └── minios-live-config/po/
├── web/                         # Web-based translations
│   ├── minios-welcome/         # Welcome screen (.js files)
│   └── minios-linux.github.io/ # MiniOS website (.json files)
├── docs/                        # Documentation for translators
└── sync.sh                      # Synchronization script (for maintainers)
```

## Supported Languages

Currently supporting 8 languages plus English as the base language. See language-specific .po files in each component directory for the complete list of supported languages.

## Quick Start

### For Translators

1. **Fork the repository** on GitHub/GitLab

2. **Clone your fork:**
   ```bash
   git clone <your-fork-url>
   cd minios-translations
   ```

3. **Create a branch for your work:**
   ```bash
   git checkout -b update-german-translations
   ```

4. **Choose a component to translate:**
   ```bash
   # Example: translate Session Manager to German
   cd po/minios-session-manager
   poedit de.po
   ```

5. **Commit and push to your fork:**
   ```bash
   git add .
   git commit -m "Update German translation for Session Manager"
   git push origin update-german-translations
   ```

6. **Create a Pull Request** to the main repository

**Important:** Languages with translation completeness below 80% may be excluded from supported languages.

See [docs/TRANSLATOR_GUIDE.md](docs/TRANSLATOR_GUIDE.md) for detailed instructions.

### For Maintainers

The `sync.sh` script synchronizes translations between this centralized repository and source projects:

1. **Pull latest translations from source projects:**
   ```bash
   ./sync.sh pull
   git add .
   git commit -m "Update translations from source projects"
   git push
   ```

2. **Push updated translations to source projects:**
   ```bash
   ./sync.sh push
   # Commit changes in source projects
   ```

## Translation Statistics

Translation files are organized by component and language. To check current statistics:
```bash
find po -name "*.po" | wc -l              # Count .po files
find web -name "*.js" -o -name "*.json" | wc -l  # Count web translations
ls po/minios-live/*.po | wc -l            # Count languages in a component
```

## Synchronization

**For maintainers only:** The `sync.sh` script provides bidirectional synchronization between this centralized repository and source projects.

- **`sync.sh pull`** - Copy translations FROM source projects TO this repo
- **`sync.sh push`** - Copy translations FROM this repo TO source projects

**Workflow:**
1. Translators fork the repo and submit pull requests
2. Maintainers review and merge pull requests
3. Maintainers run `sync.sh push` to update source projects
4. Maintainers run `sync.sh pull` after source code updates
5. Build system uses translations from source projects

## Tools

Recommended tools for translation:

- **Poedit** - https://poedit.net/ (GUI for .po files)
- **Lokalize** - KDE translation tool
- **Gtranslator** - GNOME translation tool
- **Virtaal** - Lightweight translation tool
- **VS Code** with gettext extension

For web translations (.js, .json):
- Any text editor
- VS Code with JSON/JavaScript support

## File Formats

### .po files (Gettext)
Standard gettext format for application translations.

### .pot files (Template)
Template files containing all translatable strings (no translations).

### Manpages (po4a)
Directory-based structure with separate files for each man page.

### Web (.js, .json)
JavaScript/JSON format for web-based interfaces.

## Contributing

1. Fork this repository
2. Create a feature branch (`git checkout -b add-swedish-translation`)
3. Make your translations
4. Commit your changes (`git commit -am 'Add Swedish translation for Session Manager'`)
5. Push to the branch (`git push origin add-swedish-translation`)
6. Create a Pull Request

## Documentation

- [Translator Guide](docs/TRANSLATOR_GUIDE.md) - Comprehensive guide for translators
- [Component Overview](docs/COMPONENTS.md) - Detailed description of each component
- [Style Guide](docs/STYLE_GUIDE.md) - Translation style guidelines

## Issues

Report translation issues:
- **Typos/mistakes** - Create an issue or PR
- **Missing strings** - Report in the source project
- **Encoding problems** - Check file encoding (UTF-8)

## License

Same as MiniOS project - GPL v3

## Related Projects

- [minios-live](https://github.com/minios-linux/minios-live) - Main build system
- [minios-tools](https://github.com/minios-linux/minios-tools) - Command-line tools
- [minios-session-manager](https://github.com/minios-linux/minios-session-manager) - Session management
- [minios-kernel-manager](https://github.com/minios-linux/minios-kernel-manager) - Kernel management
