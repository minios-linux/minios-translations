# Quick Reference for Translators

## Common Commands

### Working with .po Files

```bash
# Validate .po file
msgfmt -c filename.po

# Get translation statistics
msgfmt --statistics filename.po

# Find untranslated strings
msgattrib --untranslated filename.po > todo.po

# Find fuzzy strings
msgattrib --only-fuzzy filename.po > fuzzy.po

# Update .po from .pot template
msgmerge -U filename.po messages.pot
```

### Starting New Language

```bash
# Create .po from template
msginit -i messages.pot -l LANG_CODE -o LANG_CODE.po

# Example for Swedish
msginit -i messages.pot -l sv_SE -o sv.po
```

## File Locations

| Component | Location | Format |
|-----------|----------|--------|
| Main project | `po/minios-live/` | .po |
| GRUB menu | `po/grub/` | .po |
| Session Manager | `po/minios-session-manager/` | .po |
| Installer | `po/minios-installer/` | .po |
| Kernel Manager | `po/minios-kernel-manager/` | .po |
| Tools (sb2iso, etc) | `po/minios-tools/` | .po |
| Configurator | `po/minios-configurator/` | .po |
| Flux tools | `po/flux-tools/` | .po |
| Drive Utility | `po/driveutility/` | .po |
| Live Config | `po/minios-live-config/` | .po |
| Manpages | `manpages/*/po/` | .po |
| Welcome screen | `web/minios-welcome/` | .js |
| Website | `web/minios-linux.github.io/` | .json |

## Language Codes

Use ISO 639-1 language codes (e.g., de, es, fr, it, ru) with optional region codes (e.g., pt_BR, pt_PT).

Common codes:
- **de** - German
- **es** - Spanish
- **fr** - French
- **it** - Italian
- **pt** - Portuguese
- **ru** - Russian
- **en** - English

For a complete list of currently supported languages, check the .po files in component directories.

## Plural Forms

### German (de)
```po
"Plural-Forms: nplurals=2; plural=(n != 1);\n"
```

### Spanish (es), French (fr), Italian (it), Portuguese (pt, pt_BR)
```po
"Plural-Forms: nplurals=2; plural=(n > 1);\n"
```

### Russian (ru)
```po
"Plural-Forms: nplurals=3; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2);\n"
```

### Indonesian (id)
```po
"Plural-Forms: nplurals=1; plural=0;\n"
```

## Special Placeholders

**Don't translate these:**

| Placeholder | Meaning | Example |
|-------------|---------|---------|
| `%s` | String | `"File: %s"` |
| `%d` | Number | `"%d files"` |
| `%1`, `%2` | Positional | `"From %1 to %2"` |
| `{0}`, `{1}` | Positional | `"{0} of {1}"` |
| `$variable` | Variable | `"User: $username"` |
| `\n` | New line | Keep as is |
| `\\` | Backslash | Keep as is |

## Testing Checklist

- [ ] All strings translated (no empty msgstr)
- [ ] No fuzzy entries (unless intentional)
- [ ] File validates: `msgfmt -c file.po`
- [ ] Placeholders preserved
- [ ] Plural forms correct
- [ ] Encoding is UTF-8
- [ ] Translation completeness at least 80%
- [ ] Tested in actual application

**Warning:** Languages with less than 80% translation completeness may be excluded from supported languages.

## Useful Tools

### GUI Tools
- **Poedit** - https://poedit.net/ (recommended)
- **Lokalize** - KDE translation tool
- **Gtranslator** - GNOME tool

### Command-line
- `msgfmt` - Validate/compile
- `msgmerge` - Update from template
- `msgattrib` - Filter entries
- `msginit` - Create new language

### Text Editors
- **VS Code** + gettext extension
- **Vim** + po.vim
- **Emacs** + po-mode

## Git Workflow

```bash
# 1. Fork the repository on GitHub/GitLab

# 2. Clone your fork
git clone <your-fork-url>
cd minios-translations

# 3. Add upstream remote
git remote add upstream <main-repo-url>

# 4. Create a branch
git checkout -b update-german-component

# 5. Make your changes
poedit po/component/lang.po

# 6. Commit
git add po/component/lang.po
git commit -m "Update German translation for Component"

# 7. Push to your fork
git push origin update-german-component

# 8. Create Pull Request on GitHub/GitLab
```

### Keeping Your Fork Updated

```bash
# Fetch from upstream
git fetch upstream

# Merge upstream changes
git checkout main
git merge upstream/main
git push origin main
```

## Common Mistakes to Avoid

**Don't:**
- Translate command names (`minios-session`, `sb2iso`)
- Translate file paths (`/minios/changes/`)
- Remove placeholders (`%s`, `%d`)
- Change HTML tags in web translations
- Use wrong encoding (must be UTF-8)

**Do:**
- Translate UI text, messages, descriptions
- Keep formatting consistent
- Test in the actual application
- Ask if unsure about context
- Check existing translations for consistency

## Questions?

- Open an issue in this repository
- Check [TRANSLATOR_GUIDE.md](TRANSLATOR_GUIDE.md) for details
- Review existing translations for examples
