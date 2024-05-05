extends CanvasLayer


func _ready():
    GuiTransitions.hide()
    call_deferred("show_main_menu")


func show_main_menu():
    GuiTransitions.go_to("MainMenu")


