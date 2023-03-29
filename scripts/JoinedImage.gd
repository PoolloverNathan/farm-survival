@tool
class_name TileProcessorJoiner extends ImageProcessor

@export var sources: Array[ImageProcessor]
@export var atlas_direction = VERTICAL;

func bake(ignore_baked = self.ignore_baked):
	var height = 0
	var width = 0
	var draws = []
	for source in sources:
		if not source.out_image or ignore_baked: source.bake(ignore_baked)
		var image = source.out_texture.get_image().duplicate()
		image.convert(output_format)
		if atlas_direction == VERTICAL:
			draws.push_back([0, height, image])
			height += image.get_height()
			width = max(width, image.get_width())
		elif atlas_direction == HORIZONTAL:
			draws.push_back([width, 0, image])
			height = max(height, image.get_height())
			width += image.get_width()
	var image = Image.create(width, height, false, output_format)
	var data = {}
	for draw in draws:
		var source: Image = draw[2]
		image.blit_rect(source, Rect2i(Vector2.ZERO, source.get_size()), Vector2(draw[0], draw[1]))
		var region_key_prefix = "region_{x}_{y}_{w}_{h}_".format({ x = draw[0], y = draw[1], w = source.get_width(), h = source.get_height() })
		var region_name_key = region_key_prefix + "name"
		data[region_name_key] = source.resource_name
	_emit(image)
