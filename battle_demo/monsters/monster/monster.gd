extends Node2D

var monster_name
var stats = {
	"atk" : null, # Attack
	"def" : null, # Defence
	"spd" : null, # Speed
	"lck" : null, # Luck
	"hpm" : null  # Max health
}
var health        # Current health

func take_damage(damage):
	health -= damage
	if health < 1:
		_die()

func heal_damage(damage):
	health += damage
	if health > stats["hpm"]:
		health = stats["hpm"]

func full_heal():
	health = stats["hpm"]

func _die():
	pass
	
func _draw_sprite():
	pass

