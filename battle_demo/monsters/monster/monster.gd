extends Node2D

export(String) var monster_name
export(Dictionary) var stats = {
	"atk" : 0, # Attack
	"def" : 0, # Defence
	"spd" : 0, # Speed
	"lck" : 0, # Luck
	"hpm" : 0 # Max health
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

