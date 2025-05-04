class_name Bush extends Node2D

func _ready():
	$Hitbox.Damaged.connect(TakeDamage)
	pass
	
func TakeDamage (hurtbox:Hurtbox) -> void:
	queue_free()
