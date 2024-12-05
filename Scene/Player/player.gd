extends CharacterBody3D

enum{
	MOVE,
	ATTACK
}
@onready var anim = $AnimationPlayer

const SPEED = 5.0
const ROTATE = 0.1
var helth = 100
var coin = 0
var state = MOVE

func _physics_process(delta: float) -> void:
	match state:
		MOVE:
			move_state()
		ATTACK:
			attack_state()
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	move_and_slide()
	
	
func move_state():
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		anim.play("Running_A")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		anim.play("Idle")
	if Input.is_action_pressed("right"):
		rotate_y(-ROTATE)
	if Input.is_action_pressed("left"):
		rotate_y(+ROTATE)
func attack_state():
	anim.play("1H_Melee_Attack_Slice_Diagonal")


func _on_button_pressed():
	state = ATTACK
	await anim.animation_finished
	state = MOVE
