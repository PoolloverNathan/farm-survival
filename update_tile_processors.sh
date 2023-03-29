rm -rf tile_processors
mkdir tile_processors
<gimkit/tilesets/lines.txt tr '\n' '\0' | xargs -0L5 bash -c 'echo -n "$1 ($0)..."; sed "s|{{FILL}}|$2|;s|{{MASK}}|$3|;s|{{BORDER}}|$4|;s|{{NAME}}|$1|;s|###|$RANDOM|;" processor_template.tres > tile_processors/$0.tres; echo -e "\b\b\b   "'
