@tool
class_name ImageProcessor extends Resource

enum ImageType {
	PNG,
	JPG,
	WEBP,
	EXR
}
enum OutputTo {
	ImageOnly,
	TextureOnly,
	Both
}

@export var out_texture: Texture2D
@export var out_image: Image
@export var output_format := Image.FORMAT_RGBA8
@export_file var save_to: String
@export var save_as := ImageType.PNG
@export var reimport_after_save := false
@export var output_to := OutputTo.Both
@export var ignore_baked := false

func _emit(image: Image, data = {}):
	if output_to != OutputTo.TextureOnly:
		out_image = null
	else:
		out_image = image
	if save_to:
		match save_as:
			ImageType.PNG:
				image.save_png(save_to)
			ImageType.JPG:
				image.save_jpg(save_to)
			ImageType.WEBP:
				image.save_webp(save_to)
			ImageType.EXR:
				image.save_exr(save_to)
	if output_to == OutputTo.ImageOnly:
		out_texture = null
	else:
		if reimport_after_save:
			out_texture = ResourceLoader.load(save_to, "", ResourceLoader.CACHE_MODE_REPLACE)
		else:
			out_texture = ImageTexture.create_from_image(image)
	if out_image:
		for key in data:
			out_image.set_meta(key, data[key])
	if out_texture:
		for key in data:
			out_texture.set_meta(key, data[key])

@export var rebake = false:
	set(do_rebake):
		if do_rebake:
			bake.call_deferred()

func bake(ignore_baked = self.ignore_baked):
	push_warning("bake() is not implemented")
