# MiniOS Translations Repository Structure

## Overview

This repository centralizes all translation files from the MiniOS project and its submodules, making it easy for translators to contribute without navigating multiple repositories.

## Directory Structure

```
minios-translations/
│
├── po/                              # Gettext .po translation files
│   ├── minios-live/                # Main MiniOS build system
│   │   ├── *.po                    # Translation files for each language
│   │   └── messages.pot            # Template file
│   │
│   ├── grub/                       # GRUB bootloader menu
│   │   ├── *.po                    # Translation files
│   │   └── messages.pot            # Template file
│   │
│   ├── minios-kernel-manager/     # Kernel management tool
│   ├── minios-installer/          # System installer
│   ├── minios-session-manager/    # Session management
│   ├── minios-tools/              # CLI tools (sb2iso, etc.)
│   ├── minios-configurator/       # System configurator
│   ├── flux-tools/                # Flux desktop tools
│   ├── driveutility/              # USB drive utility
│   └── minios-live-config/        # Live system config
│       (each component contains *.po files and messages.pot)
│
├── manpages/                       # Manual page translations (po4a)
│   ├── minios-live/po/
│   │   ├── LANG/                  # Language directories (de, es, fr, etc.)
│   │   │   ├── minios-live.1.po
│   │   │   ├── minios-cmd.1.po
│   │   │   ├── condinapt.1.po
│   │   │   └── condinapt-minios.7.po
│   │   └── ...
│   │
│   └── minios-live-config/po/
│       ├── LANG/                  # Language directories
│       │   └── live-config.7.po
│       └── ...
│
├── web/                            # Web-based translations
│   ├── minios-welcome/            # Welcome screen
│   │   ├── *.js                   # Language files (de.js, es.js, etc.)
│   │   └── en.js                  # Reference (base language)
│   │
│   └── minios-linux.github.io/    # Project website
│       ├── *.json                 # Language files (de.json, es.json, etc.)
│       └── en.json                # Reference (base language)
│
├── docs/                           # Translator documentation
│   ├── TRANSLATOR_GUIDE.md        # Comprehensive guide
│   ├── QUICK_REFERENCE.md         # Quick commands reference
│   └── COMPONENTS.md              # Component descriptions
│
├── sync.sh                         # Bidirectional sync script
├── copy_translations.sh            # Initial copy script
├── README.md                       # Repository overview
├── STRUCTURE.md                    # This file
└── .gitignore                      # Git ignore rules
```

## Component Mapping

| Centralized Location | Source Project Location | Type |
|---------------------|------------------------|------|
| `po/minios-live/` | `minios-live/po/` | .po |
| `po/grub/` | `minios-live/linux-live/bootfiles/boot/grub/po/` | .po |
| `po/minios-kernel-manager/` | `submodules/minios-kernel-manager/po/` | .po |
| `po/minios-installer/` | `submodules/minios-installer/po/` | .po |
| `po/minios-session-manager/` | `submodules/minios-session-manager/po/` | .po |
| `po/minios-tools/` | `submodules/minios-tools/po/` | .po |
| `po/minios-configurator/` | `submodules/minios-configurator/po/` | .po |
| `po/flux-tools/` | `submodules/flux-tools/po/` | .po |
| `po/driveutility/` | `submodules/driveutility/po/` | .po |
| `po/minios-live-config/` | `submodules/minios-live-config/po/` | .po |
| `manpages/minios-live/po/` | `minios-live/manpages/po/` | po4a |
| `manpages/minios-live-config/po/` | `submodules/minios-live-config/manpages/po/` | po4a |
| `web/minios-welcome/` | `submodules/minios-welcome/html/js/translations/` | .js |
| `web/minios-linux.github.io/` | `submodules/minios-linux.github.io/translations/` | .json |

## Supported Languages

The repository currently supports 8 languages plus English as the base language:
- Most components support: de, es, fr, id, it, pt, pt_BR, ru
- Some components may have additional language support (e.g., ja for live-config manpages)
- Base language: en_US (English)

For the current list of supported languages in each component, check the .po files in the respective component directories.

## File Formats

### 1. Gettext .po Files
- **Location:** `po/*/`
- **Format:** Standard gettext
- **Tools:** Poedit, Lokalize, Gtranslator
- **Template:** `messages.pot`

### 2. Manpage Translations (po4a)
- **Location:** `manpages/*/po/`
- **Format:** po4a (directory per language)
- **Tools:** Same as .po files
- **Output:** Localized man pages

### 3. Web Translations
- **JavaScript (.js):** `web/minios-welcome/`
- **JSON (.json):** `web/minios-linux.github.io/`
- **Tools:** Any text editor

## Workflow

### For Translators

1. **Fork and clone:**
   ```bash
   # Fork on GitHub/GitLab first
   git clone <your-fork-url>
   cd minios-translations
   git checkout -b my-translations
   ```

2. **Translate:**
   ```bash
   cd po/component-name
   poedit language.po
   ```

3. **Commit and push:**
   ```bash
   git add .
   git commit -m "Update translation"
   git push origin my-translations
   ```

4. **Create Pull Request** on GitHub/GitLab

### For Maintainers

1. **After modifying source strings:**
   ```bash
   # In source project
   make update-po  # or equivalent

   # In minios-translations
   ./sync.sh pull
   git add .
   git commit -m "Update translations from source"
   git push
   ```

2. **After merging translator PRs:**
   ```bash
   ./sync.sh push
   # Commit changes in source projects
   ```

3. **Before release:**
   ```bash
   ./sync.sh pull  # Get latest from source
   # Merge translator PRs
   ./sync.sh push  # Push to source projects
   # Test in source projects
   ```

## Statistics

Translation files are organized across multiple components and languages. For current statistics, use:
```bash
find po -name "*.po" | wc -l     # Count .po files
find web -type f | wc -l         # Count web translations
```

## Maintenance

### Adding a New Language

1. Create .po files from templates:
   ```bash
   for dir in po/*/; do
       cd "$dir"
       msginit -i messages.pot -l NEW_LANG -o NEW_LANG.po
       cd ../..
   done
   ```

2. Copy and translate web files

3. Update documentation with new language

### Adding a New Component

1. Add directory in `po/` or appropriate location
2. Update `sync.sh` with new mapping
3. Run `./sync.sh pull`
4. Update this documentation

## Notes

- Always use UTF-8 encoding
- Preserve placeholders (%s, %d, etc.)
- Test translations in actual applications
- Ask if context is unclear
- Maintain at least 80% translation completeness
- Languages below 80% completeness may be excluded from supported languages

## Support

- **Issues:** Open an issue in this repository
- **Questions:** Check TRANSLATOR_GUIDE.md
- **Discussion:** MiniOS project forums
