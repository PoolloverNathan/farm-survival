@tool
class_name GimkitImageProcessor extends ImageProcessor

@export var fill: Texture2D:
	set(new_fill):
		fill = new_fill
#		bake.call_deferred()
@export var mask: Texture2D:
	set(new_mask):
		mask = new_mask
#		bake.call_deferred()
@export var outline: Texture2D:
	set(new_outline):
		outline = new_outline
#		bake.call_deferred()

func bake(ignore_baked = self.ignore_baked):
	var outline := self.outline.get_image()
	var mask := self.mask.get_image()
	var fill := self.fill.get_image()
	assert(outline.get_size() == mask.get_size(), "outline and mask must be the same size.")
	var image = Image.create(outline.get_width(), outline.get_height(), false, Image.FORMAT_RGBA8)
	for x in mask.get_width():
		for y in mask.get_height():
			var outline_pixel = outline.get_pixel(x, y)
			if outline_pixel.a > 0.1:
				image.set_pixel(x, y, outline_pixel)
			else:
				if mask.get_pixel(x, y).a > 0.1:
					image.set_pixel(x, y, fill.get_pixel(x % fill.get_width(), y % fill.get_height()))
	_emit(image)
