extends CanvasLayer

signal restart_pressed
signal pause_pressed
signal hint_pressed
signal next_pressed

@onready var level_label: Label = $MainHUD/TopBar/HBoxContainer/MarginContainer/LevelLabel

func set_level(n: int):
    level_label.text = "Level %d" % n

func _on_pause_pressed():
    pause_pressed.emit()

func _on_restart_pressed():
    restart_pressed.emit()

func _on_hint_pressed():
    hint_pressed.emit()

func _on_next_pressed():
    next_pressed.emit()