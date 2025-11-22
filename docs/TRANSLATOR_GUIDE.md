# Translator Guide for MiniOS

Welcome to the MiniOS translation project! This guide will help you contribute translations to make MiniOS available in your language.

## Table of Contents

1. [Getting Started](#getting-started)
2. [File Formats](#file-formats)
3. [Translation Workflow](#translation-workflow)
4. [Best Practices](#best-practices)
5. [Component-Specific Guidelines](#component-specific-guidelines)
6. [Testing Translations](#testing-translations)
7. [Common Issues](#common-issues)

## Getting Started

**Important Notice:** Languages with translation completeness below 80% may be excluded from the list of supported languages. Please keep your translations up to date.

### Prerequisites

- **Git** - for version control
- **Text editor** or translation tool:
  - **Poedit** (recommended for beginners) - https://poedit.net/
  - **Lokalize** - for KDE users
  - **Gtranslator** - for GNOME users
  - **VS Code** with gettext extension

### Setup

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd minios-translations
   ```

2. **Choose your language:**
   Check the component directories for existing .po files to see currently supported languages.

3. **Or add a new language:**
   See section "Adding a New Language" below.

## File Formats

### 1. Gettext .po Files

Most common format in MiniOS. Located in `po/` directories.

**Structure:**
```po
# Comment
msgid "Original English string"
msgstr "Translated string"

# With context
msgctxt "context"
msgid "String"
msgstr "Translation"

# Plural forms
msgid "One file"
msgid_plural "%d files"
msgstr[0] "%d файл"
msgstr[1] "%d файла"
msgstr[2] "%d файлов"
```

**Tools:**
- Poedit (GUI)
- `msgfmt -c file.po` (validate)
- `msgmerge` (update from .pot)

### 2. Manpages (po4a format)

Located in `manpages/` directories. Each language has its own directory.

**Files:**
```
manpages/minios-live/po/ru/
├── minios-live.1.po
├── minios-cmd.1.po
└── ...
```

**Tools:**
- Poedit or any .po editor
- `po4a` for generating manpages

### 3. Web Translations

#### JavaScript (.js files)

Located in `web/minios-welcome/`

**Format:**
```javascript
translations.ru = {
    "Welcome": "Добро пожаловать",
    "Start": "Начать",
    // ...
};
```

#### JSON (.json files)

Located in `web/minios-linux.github.io/`

**Format:**
```json
{
    "welcome": "Добро пожаловать",
    "download": "Скачать",
    "documentation": "Документация"
}
```

## Translation Workflow

### Basic Workflow

1. **Fork the repository** on GitHub/GitLab

2. **Clone your fork:**
   ```bash
   git clone <your-fork-url>
   cd minios-translations
   ```

3. **Create a branch:**
   ```bash
   git checkout -b update-de-session-manager
   ```

4. **Translate a component:**
   ```bash
   cd po/minios-session-manager
   poedit de.po  # or your language
   ```

5. **Save and validate:**
   ```bash
   msgfmt -c de.po  # Check for errors
   ```

6. **Commit your changes:**
   ```bash
   git add po/minios-session-manager/de.po
   git commit -m "Update German translation for Session Manager"
   ```

7. **Push to your fork:**
   ```bash
   git push origin update-de-session-manager
   ```

8. **Create a Pull Request** from your fork to the main repository

### Adding a New Language

1. **Check language code:**
   - Use ISO 639-1 code (e.g., sv for Swedish)
   - For regional variants: sv_SE, fr_CA, etc.

2. **Create .po files from templates:**
   ```bash
   cd po/minios-session-manager
   msginit -i messages.pot -l sv_SE -o sv.po
   ```

3. **Repeat for all components:**
   ```bash
   for dir in po/*/; do
       cd "$dir"
       if [ -f messages.pot ]; then
           msginit -i messages.pot -l sv_SE -o sv.po
       fi
       cd ../..
   done
   ```

4. **Add to sync script:**
   Edit `sync.sh` if needed for special handling.

5. **Translate web files:**
   - Copy `web/minios-welcome/en.js` to `sv.js`
   - Copy `web/minios-linux.github.io/en.json` to `sv.json`
   - Translate the strings

## Best Practices

### General Guidelines

1. **Stay consistent:**
   - Use the same translation for the same term across all components
   - Keep a glossary of technical terms

2. **Preserve formatting:**
   - Keep placeholders: `%s`, `%d`, `{0}`, `$variable`
   - Preserve line breaks `\n`
   - Keep HTML tags unchanged

3. **Context matters:**
   - "File" (noun) vs "File" (verb) may need different translations
   - Read surrounding strings for context

4. **Length considerations:**
   - Translations can be longer/shorter than English
   - Test in UI to ensure proper display
   - Use abbreviations if needed for buttons

5. **Formal vs informal:**
   - Most MiniOS text uses informal "you" (in languages that distinguish)
   - Be consistent throughout

6. **Translation completeness:**
   - Maintain at least 80% translation completeness
   - Languages below 80% may be excluded from supported languages
   - Check completeness: `msgfmt --statistics file.po`

### Technical Terms

**Don't translate:**
- Command names: `sb2iso`, `minios-session`, etc.
- File paths: `/minios/changes/`
- Technical abbreviations: RAM, CPU, USB
- Format names: ext4, NTFS, FAT32

**Translate:**
- UI elements: buttons, menus, labels
- Help text and descriptions
- Error messages
- Documentation

### Plural Forms

Different languages have different plural rules. Example for Russian:

```po
msgid "One file"
msgid_plural "%d files"
msgstr[0] "%d файл"      # 1, 21, 31...
msgstr[1] "%d файла"     # 2-4, 22-24...
msgstr[2] "%d файлов"    # 0, 5-20, 25-30...
```

Plural forms header in .po file:
```po
"Plural-Forms: nplurals=3; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2);\n"
```

## Component-Specific Guidelines

### GRUB Bootloader (`po/grub/`)

- **Very short strings** - screen space limited
- **No special characters** that might not display
- **Critical** - boot menu must be clear
- Test: Boot from ISO to verify display

### Session Manager (`po/minios-session-manager/`)

- Technical terms: session, mode (native/dynfilefs/raw)
- File sizes in MB/GB
- Actions: create, delete, activate, export, import

### Installer (`po/minios-installer/`)

- **Critical** - installation process
- Partition names, filesystems
- Warning messages must be clear
- Test: Run installer in VM

### Kernel Manager (`po/minios-kernel-manager/`)

- Kernel versions and types
- Installation status messages
- Technical accuracy important

### Tools (`po/minios-tools/`)

- Command-line tool messages
- Options and parameters
- Help text formatting

### Website (`web/minios-linux.github.io/`)

- Marketing-oriented language
- SEO-friendly descriptions
- Links and navigation must work

## Testing Translations

### In Development Environment

**For maintainers:** After source code changes that affect translatable strings:

1. **Update POT files in source projects:**
   ```bash
   cd source-project
   make update-po  # or similar command
   ```

2. **Sync to translation repository:**
   ```bash
   cd minios-translations
   ./sync.sh pull
   git add .
   git commit -m "Update translation templates from source"
   git push
   ```

**For translators:** After templates are updated:

1. **Update your fork:**
   ```bash
   git checkout main
   git pull upstream main
   git push origin main
   ```

2. **Create branch and translate:**
   ```bash
   git checkout -b update-translations
   cd po/component-name
   poedit language.po
   ```

3. **Commit and create PR:**
   ```bash
   git add .
   git commit -m "Update translations"
   git push origin update-translations
   # Then create Pull Request on GitHub/GitLab
   ```

### In Live System

1. **Build MiniOS ISO** with your language
2. **Boot in VM** (VirtualBox, QEMU)
3. **Check all components:**
   - Boot menu (GRUB/SYSLINUX)
   - Desktop environment
   - Applications (Session Manager, Installer, etc.)
   - Help text and tooltips

### Validation Tools

```bash
# Check .po file syntax
msgfmt -c file.po

# Get statistics
msgfmt --statistics file.po

# Find fuzzy and untranslated
msgattrib --untranslated file.po
msgattrib --only-fuzzy file.po
```

## Common Issues

### Encoding Problems

**Always use UTF-8:**
```bash
# Check encoding
file -i file.po

# Convert if needed
iconv -f ISO-8859-1 -t UTF-8 file.po > file_utf8.po
```

### Plural Forms

**Problem:** Missing plural forms

**Solution:** Add plural forms header to .po file

```po
"Plural-Forms: nplurals=2; plural=(n != 1);\n"
```

Find your language's plural form at:
https://localization-guide.readthedocs.io/en/latest/l10n/pluralforms.html

### Fuzzy Translations

**Problem:** Strings marked as "fuzzy" after update

**Solution:** Review and either:
- Update translation and remove fuzzy flag
- Confirm translation is correct (remove flag)

```bash
# List fuzzy strings
msgattrib --only-fuzzy file.po

# In Poedit: Edit → Preferences → Show fuzzy translations
```

### Missing Context

**Problem:** Same English string needs different translations

**Solution:** Use `msgctxt` for context:

```po
msgctxt "verb"
msgid "Close"
msgstr "Закрыть"

msgctxt "adjective"
msgid "Close"
msgstr "Близкий"
```

### Sync Conflicts

**Problem:** Changes in both centralized repo and source

**Solution:**
1. Always pull before pushing
2. Review conflicts carefully
3. Source project wins for technical strings
4. Translation improvements win for quality

## Getting Help

- **Questions:** Open an issue in this repository
- **Discussion:** MiniOS forums or chat
- **Style questions:** Check existing translations
- **Technical issues:** Ask in source project repository

## Resources

- **Gettext Manual:** https://www.gnu.org/software/gettext/manual/
- **Translation Memory Tools:** https://www.poedit.net/
- **Plural Forms:** https://localization-guide.readthedocs.io/
- **Style Guides:** Microsoft/Apple translation style guides for your language

## Recognition

Contributors will be credited in:
- MiniOS release notes
- About dialogs (where applicable)
- Project website
- This repository's contributors list

Thank you for helping make MiniOS accessible to users worldwide!
