#!/bin/bash
# Bidirectional synchronization script for MiniOS translations
# Usage: ./sync.sh [push|pull]
#   push - copy translations FROM centralized repo TO source projects
#   pull - copy translations FROM source projects TO centralized repo

set -e

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_ROOT="$(cd "$BASE_DIR/../.." && pwd)"

MODE="${1:-pull}"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Mapping of centralized locations to source locations
declare -A PO_MAPPINGS=(
    ["po/minios-live"]="$SOURCE_ROOT/po"
    ["po/grub"]="$SOURCE_ROOT/linux-live/bootfiles/boot/grub/po"
    ["po/minios-kernel-manager"]="$SOURCE_ROOT/submodules/minios-kernel-manager/po"
    ["po/minios-installer"]="$SOURCE_ROOT/submodules/minios-installer/po"
    ["po/minios-session-manager"]="$SOURCE_ROOT/submodules/minios-session-manager/po"
    ["po/minios-tools"]="$SOURCE_ROOT/submodules/minios-tools/po"
    ["po/minios-configurator"]="$SOURCE_ROOT/submodules/minios-configurator/po"
    ["po/flux-tools"]="$SOURCE_ROOT/submodules/flux-tools/po"
    ["po/driveutility"]="$SOURCE_ROOT/submodules/driveutility/po"
    ["po/minios-live-config"]="$SOURCE_ROOT/submodules/minios-live-config/po"
)

declare -A MANPAGE_MAPPINGS=(
    ["manpages/minios-live/po"]="$SOURCE_ROOT/manpages/po"
    ["manpages/minios-live-config/po"]="$SOURCE_ROOT/submodules/minios-live-config/manpages/po"
)

declare -A WEB_MAPPINGS=(
    ["web/minios-welcome"]="$SOURCE_ROOT/submodules/minios-welcome/html/js/translations"
    ["web/minios-linux.github.io"]="$SOURCE_ROOT/submodules/minios-linux.github.io/translations"
)

# Function to sync files
sync_files() {
    local source="$1"
    local dest="$2"
    local pattern="$3"
    local desc="$4"

    if [ ! -d "$source" ]; then
        echo -e "${YELLOW}  Warning: Source not found: $source${NC}"
        return
    fi

    mkdir -p "$dest"

    # Count files to be synced
    local count=$(find "$source" -maxdepth 1 -name "$pattern" 2>/dev/null | wc -l)

    if [ "$count" -gt 0 ]; then
        echo -e "${BLUE}  Syncing $count file(s): $desc${NC}"
        cp -a "$source"/$pattern "$dest/" 2>/dev/null || true
    fi
}

if [ "$MODE" == "pull" ]; then
    echo -e "${GREEN}=== Pulling translations FROM source projects TO centralized repo ===${NC}"
    echo ""

    echo "Syncing .po files..."
    for central_path in "${!PO_MAPPINGS[@]}"; do
        source_path="${PO_MAPPINGS[$central_path]}"
        sync_files "$source_path" "$BASE_DIR/$central_path" "*.po" "$central_path"
        sync_files "$source_path" "$BASE_DIR/$central_path" "*.pot" "$central_path"
    done

    echo ""
    echo "Syncing manpage translations..."
    for central_path in "${!MANPAGE_MAPPINGS[@]}"; do
        source_path="${MANPAGE_MAPPINGS[$central_path]}"
        if [ -d "$source_path" ]; then
            echo -e "${BLUE}  Syncing: $central_path${NC}"
            mkdir -p "$BASE_DIR/$central_path"
            cp -a "$source_path"/* "$BASE_DIR/$central_path/" 2>/dev/null || true
        fi
    done

    echo ""
    echo "Syncing web translations..."
    sync_files "${WEB_MAPPINGS["web/minios-welcome"]}" "$BASE_DIR/web/minios-welcome" "*.js" "minios-welcome"
    sync_files "${WEB_MAPPINGS["web/minios-linux.github.io"]}" "$BASE_DIR/web/minios-linux.github.io" "*.json" "minios-linux.github.io"

    echo ""
    echo -e "${GREEN}Pull completed successfully!${NC}"

elif [ "$MODE" == "push" ]; then
    echo -e "${GREEN}=== Pushing translations FROM centralized repo TO source projects ===${NC}"
    echo ""

    echo "Syncing .po files..."
    for central_path in "${!PO_MAPPINGS[@]}"; do
        source_path="${PO_MAPPINGS[$central_path]}"
        sync_files "$BASE_DIR/$central_path" "$source_path" "*.po" "$central_path"
        sync_files "$BASE_DIR/$central_path" "$source_path" "*.pot" "$central_path"
    done

    echo ""
    echo "Syncing manpage translations..."
    for central_path in "${!MANPAGE_MAPPINGS[@]}"; do
        source_path="${MANPAGE_MAPPINGS[$central_path]}"
        if [ -d "$BASE_DIR/$central_path" ]; then
            echo -e "${BLUE}  Syncing: $central_path${NC}"
            mkdir -p "$source_path"
            cp -a "$BASE_DIR/$central_path"/* "$source_path/" 2>/dev/null || true
        fi
    done

    echo ""
    echo "Syncing web translations..."
    sync_files "$BASE_DIR/web/minios-welcome" "${WEB_MAPPINGS["web/minios-welcome"]}" "*.js" "minios-welcome"
    sync_files "$BASE_DIR/web/minios-linux.github.io" "${WEB_MAPPINGS["web/minios-linux.github.io"]}" "*.json" "minios-linux.github.io"

    echo ""
    echo -e "${GREEN}Push completed successfully!${NC}"
    echo -e "${YELLOW}Don't forget to commit changes in the source projects!${NC}"

else
    echo "Usage: $0 [push|pull]"
    echo ""
    echo "  pull - Copy translations FROM source projects TO centralized repo (default)"
    echo "  push - Copy translations FROM centralized repo TO source projects"
    exit 1
fi

echo ""
echo "Summary:"
find "$BASE_DIR/po" -name "*.po" 2>/dev/null | wc -l | xargs echo "  .po files:"
find "$BASE_DIR/web" -name "*.js" -o -name "*.json" 2>/dev/null | wc -l | xargs echo "  Web files:"
