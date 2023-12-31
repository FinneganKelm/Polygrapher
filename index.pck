GDPC                �                                                                         T   res://.godot/exported/133200997/export-8d4fb4946e8bffb054f540fa46db5c2f-dodec.scn   �?      _       �N�{�gI,����tyB    ,   res://.godot/global_script_class_cache.cfg  @�      �       ��h���I���X'���    D   res://.godot/imported/dodec.glb-e94a0d0980820bc8fcb79994a55eaadd.scn�      q%      ����"V�
�Jo�+T    H   res://.godot/imported/dodec2.glb-db4474c88e597623f930b342dd4ec8e6.scn   �      �      @ �1I\4�l��n8�V    D   res://.godot/imported/icon.png-487276ed1e3a0c39cad0279d744ee560.ctex `      �1      X ;O��0Q-�C�^       res://.godot/uid_cache.bin  0�      q       ������@��J�x�       res://Camera3D.gd                 �	��I�tɬ�"Y��k       res://Mesh.gd   ��      G      �r��iA4�I=��       res://dodec.gd        �      ��@���7B�A%���       res://dodec.glb.import  ?      �       lo�¤H� u#0z~�       res://dodec.tscn.remap  Н      b       ���}|��@;�_E���       res://dodec2.glb.import `      �       ,����J�� fxȉ�]-       res://icon.png  О      QH      �I��a�9�&~�inJb�       res://icon.png.import   ��      �       {*��ǀ4j�D�{       res://project.binary��      &      $&\��3p�ơ���    class_name FreeLookCamera extends Camera3D

# Modifier keys' speed multiplier
const SHIFT_MULTIPLIER = 2.5
const ALT_MULTIPLIER = 1.0 / SHIFT_MULTIPLIER


@export_range(0.0, 1.0) var sensitivity: float = 0.25

# Mouse state
var _mouse_position = Vector2(0.0, 0.0)
var _total_pitch = 0.0

# Movement state
var _direction = Vector3(0.0, 0.0, 0.0)
var _velocity = Vector3(0.0, 0.0, 0.0)
var _acceleration = 30
var _deceleration = -10
var _vel_multiplier = 4

# Keyboard state
var _w = false
var _s = false
var _a = false
var _d = false
var _q = false
var _e = false
var _shift = false
var _alt = false

func _input(event):
	# Receives mouse motion
	if event is InputEventMouseMotion:
		_mouse_position = event.relative
	
	# Receives mouse button input
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_RIGHT: # Only allows rotation if right click down
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if event.pressed else Input.MOUSE_MODE_VISIBLE)
			MOUSE_BUTTON_WHEEL_UP: # Increases max velocity
				_vel_multiplier = clamp(_vel_multiplier * 1.1, 0.2, 20)
			MOUSE_BUTTON_WHEEL_DOWN: # Decereases max velocity
				_vel_multiplier = clamp(_vel_multiplier / 1.1, 0.2, 20)

	# Receives key input
	if event is InputEventKey:
		match event.keycode:
			KEY_W:
				_w = event.pressed
			KEY_S:
				_s = event.pressed
			KEY_A:
				_a = event.pressed
			KEY_D:
				_d = event.pressed
			KEY_Q:
				_q = event.pressed
			KEY_E:
				_e = event.pressed
			KEY_SHIFT:
				_shift = event.pressed
			KEY_ALT:
				_alt = event.pressed

# Updates mouselook and movement every frame
func _process(delta):
	_update_mouselook()
	_update_movement(delta)

# Updates camera movement
func _update_movement(delta):
	# Computes desired direction from key states
	_direction = Vector3(
		(_d as float) - (_a as float), 
		(_e as float) - (_q as float),
		(_s as float) - (_w as float)
	)
	
	# Computes the change in velocity due to desired direction and "drag"
	# The "drag" is a constant acceleration on the camera to bring it's velocity to 0
	var offset = _direction.normalized() * _acceleration * _vel_multiplier * delta \
		+ _velocity.normalized() * _deceleration * _vel_multiplier * delta
	
	# Compute modifiers' speed multiplier
	var speed_multi = 1
	if _shift: speed_multi *= SHIFT_MULTIPLIER
	if _alt: speed_multi *= ALT_MULTIPLIER
	
	# Checks if we should bother translating the camera
	if _direction == Vector3.ZERO and offset.length_squared() > _velocity.length_squared():
		# Sets the velocity to 0 to prevent jittering due to imperfect deceleration
		_velocity = Vector3.ZERO
	else:
		# Clamps speed to stay within maximum value (_vel_multiplier)
		_velocity.x = clamp(_velocity.x + offset.x, -_vel_multiplier, _vel_multiplier)
		_velocity.y = clamp(_velocity.y + offset.y, -_vel_multiplier, _vel_multiplier)
		_velocity.z = clamp(_velocity.z + offset.z, -_vel_multiplier, _vel_multiplier)
	
		translate(_velocity * delta * speed_multi)

# Updates mouse look 
func _update_mouselook():
	# Only rotates mouse if the mouse is captured
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_mouse_position *= sensitivity
		var yaw = _mouse_position.x
		var pitch = _mouse_position.y
		_mouse_position = Vector2(0, 0)
		
		# Prevents looking up/down too far
		pitch = clamp(pitch, -90 - _total_pitch, 90 - _total_pitch)
		_total_pitch += pitch
	
		rotate_y(deg_to_rad(-yaw))
		rotate_object_local(Vector3(1,0,0), deg_to_rad(-pitch))
RRSCC      �  �  �  (�/�` =/ @ @0������g����T͈eFDD�Ҷ�Ȟ�{o�s�%ro���)ʍN�vU���>x�R�7����7ط)� � � [���q�Q�����"��@M}.Op]���D\�G�{�V�Y��&k�i��^x5���EQρ�s[�J�2CێUu���j��\d8��|�"�N���)�ɪ���G��|=Y�����qC��n��q�KR���_/���#��"m3���o�O�_�q�|]+S��F���B6rqD�Zo+;��ڶ)n�H۩R)�����,�T�+m���N}S��[�|�p�B���MfG`������1E-�9�
IHeFSv���L]�z�_�^[/n��V���XlY�y���������,�G鳸C)�
tɆ�V��8�x{�'�R)����܁� ���[=�����B�VQ�0��
"� �6`�}�u/�^����H@��5���5M�̒�^�r[F�V�b���:_��hY|��dP�f�Eo2��[��곞H���1l������e�E������d�&�H�^9A���S�dH:yܸ�'7W�(����`l��e�$�	�����>$%�I��TZ0��ĤC��Q*�tJNJ�#,*�A�<��t��f~y�1����_���[����5���9NѼ�S^9��x����7Ǹ�c|s��s^q�s�yE�S��s܂�Sn��7N�AA��Tp�_��!\|%>&>HhH�G��g�I~���C�|H���B���|�
��i�a1B
Ɍ�hA�B��P	K;��)ɒ�1�HHd$��iP���4Ύ}>A�O��*��u�ÆF��R.��ѯ%�L۱o���-�r�F�������[�����n#��g_gs�r�!�L|x�F���ɕ.cv	)0(U�jJE"����6	�9;gg+
��ɫf�n�<���yЏ�]�� T��	�n5�-��>��',�YZ�6� 6�+G+�1�H0��J��a.E���P�UȮױ�� ��~Uӑr��$�t��N��_����)};�����~���J����\�4�<	H��r�'�F�����r����,3,Dh�g�w��}T��&�;T��J��Z+ub�UD	Zҧ͟��~f�s�5��$�������d�C��	�8b?N�:�m�݆���߿�x��fΩ��'�����X���������ha�<�C."����#kB��-�Hy.5L��,�_�,HO�'d��I$��N��,���Uu00m��Y4��~)i����ژ�[v�"�
m�]����������%AYh��l��RN�q�3�m갓�0Wۗ�P�g%v��D�}�·���yJ��h�tz��͹�-:��Y	��H��KLVr�#(0\����֫N���bٗX�f˶aq�,��dp�G�;*кX�K*�CC���qO��o��ܩN�šLbºC�|�^=!*�T�����V���!w	(�/�`�� ValF �:k��3�������PUUUU��6G�g:�;7Qz9p��f�-l�\@@� Y��
Bm$H�8qx�d R T +��pŧ�c��_����%Jq5SOX��9��@��h���6Cy2۽�Nf3�_M��:��g��[��ʯ�DqBDy��2[��:���[�1�_�J7�Gјh��2��!X��OX���cЦQ0h�]6���������;�Y9�y��1��gsS�37�	���7��8�2=鸚��%�O1"�ټ�$��AvQVO��3\;8�%Gxd�K���Uΰ�VY�n��2j�n�����\a�Sw�����1ˣO�x4�/\��C�+)U�cK�����bѓ�j�t�jkKт�����ձ��h󴔄Q��Ӵ,-����c���IW�:�Ա|1�X�?i����/����������1*�IK*Y6����P����6)��<�	w�LM�E(:\�%�"�ݎk��3#)MS�+6��1�Հ:�Ý� �//Hi�}i{1�����A����>=���ȍ�/��[�}Ç��dBB�:�=ܺ!V"������d֥Fγ|���]��t����R0��#��	������u@?�bڢ�f$8����l�a
�zS��Dk9�@���c<��M6�^� ��8��;�^�t=$=E)�>����b��RSCCw��t�P�w�u_���[remap]

importer="scene"
importer_version=1
type="PackedScene"
uid="uid://cewjhfthcs50p"
path="res://.godot/imported/dodec2.glb-db4474c88e597623f930b342dd4ec8e6.scn"
 ��؞A�extends Node3D

var targetAngle=0.0
var targetAxis=0

var realvalue

func _on_go_pressed():
	targetAngle = deg_to_rad(realvalue)


func _on_option_button_item_selected(index):
	targetAxis=index



func _on_spin_box_value_changed(value):
	realvalue = value

func _process(delta):
	$Camera3D.position.x = 3-$UI/HSlider.value+1.5
	
	rotation.x = lerp(rotation.x,0.0,0.02)
	rotation.y = lerp(rotation.y,0.0,0.02)
	rotation.z = lerp(rotation.z,0.0,0.02)
	
	match targetAxis:
		0:
			rotation.x = lerp(rotation.x,targetAngle,0.04)
		1:
			rotation.y = lerp(rotation.y,targetAngle,0.04)
		2:
			rotation.z = lerp(rotation.z,targetAngle,0.04)



	
RSCC      �X  �  W  5  p  �  �  (�/�` E/ �@0A@m��6�~�Z}} �WEQ��ef-ٓ��M\b��[�٣�,S��QǐEB�u�W������� � � 0ƭ|��x��� ̪uΝU׎S�����T�F����5�f��Wc��!um�H-�3�e�U| 	�Z�R�m���kV��Ř9~�jOr��k��$�bTn���t�VI,�c^��'l�5?�9_+3������&��?�����Y�#yr{������?k��+7b�keZUsD�5�66Q�	ѽ�V~ �mWܘ�[��9)���
���
�ܕ6�ZuF��B�Jɭ��p�Ƹ�XØ� l/��o8s���65�k4c�Q�f�I��`�N���U	���q�{��Q�dϺ��l��5fW+��%�'��	)�w(ei��ّ�\�5o��"���I��b`�>@|$4�|p��k$f8��p��yDi���Y�+��[�9���QX6׭�z��J�@��OfT�(_�ۮYi�(�m[�Z�5�X1��B�&!Kk6$�[d���m�J^�4�rt���N�5@��`%�ym�a̡��I�)����|,�츗1n�V������s�u��ӧ�t�)9��8�DJ��8�,��N'��H	K�
ƃq�4�o�g�5~9�_~�L�/�x�[����o~���W�9�c^��k���x���<�g~�q�-~q�1�p|��|�[2�q�-Ǹ�+6*(��[|ē��"��E�	ӆr����Cg�!' x��>��c�pB<��⿁o�WalLC�U��؅!�`�q�1
Ɍ�hA�B��P	C;��Q�%c��Ȉ452��ϐ���(/�Q	M�K��C�Ȏ��d��=}o����B�wN:K~s�Kٰf���[����#��RʕVy���r�T�}�5;~��Dd$:�{�5�O��@��w �$A9�����Hy���8nXSg{i�E-��t�N����$�huO������g�tDV�����=6pq��t[�p;n���Z�h�d��.ߡ��t.�(�a®�{�CzM��Q�k* �d�0�S:x��U>BK���Tm7� �	�`��w�j�
0�!I��sQ7w���%� -�l�ŋ<
6��u�ۈD>��o�u��`�t�4�Q�>����ɄX���}Ġ8��0վ���k�w_/��䲙S,�lOH�%���C� r[j�6��ј��p���@��]���7y��i��BX�C���V����d��E>h����[d[&�l`��^�	�h���#"�,C@�˴m�������)T�AK�!��X�8=r>?Z�;�[)�@�F/Ч)%�sf,:����.�2[�*3��(r�G�������)��K�^�h�]a����S6� �1�~�n�e�W	�������$�	pG��4D� ��2l5��J��!
@D74t�c��]��;.��7e©����a\]ա�u9�=ȸ����e��%�N�a�!�(�/�` m2 �^�?В� }i����?������
H��苇
�Egf�
�"��x'��4�g�2R^�op��"� j�,ܤB
.Q�B��+tg�]�Q��,5�̮T���9��ί#Ɋd�r�H�CM"=�gғ8��i�������f֪ڬJ`K�.�.]�r�W� ��r��֔XQx{�mS�JK�i`I�Aa�|iu�/q�&�4��.���������}� �e��B|P�����*��z�ݎ���x��6�"G[��9F|t<D�ݐᵵa���]�fD�}���OD����2F:�fz7d�ڌtܐ�y��^Άӗ���8�5��hQ��E��,�k�(�9�-�%�hK��$z�����C��v�ИCB�.TdL�AE *t��;E��hP ���	�gΟ@u�,r�Ԃ��Y�Ԃ�/*J���^��o��z,)p���B��^����J�� ��7��Y˗�#�+ip�@c�cI���V�h�M(Q ��<�7�� �`D\���(1b��bFO��(N�"�B����}��}_���V���B���5klXnh�0D8I�el�A�5/hllR?�J�JcCK��Ɓ���0�����G^�iR���V����3�ժ;:�Z�YU�ΪTURR���jM�T��МJ5�T�5�J5))u*M��1�x;��-o������w7����̐�QgdF�5�̨�F�	��ϥOIF>]���L�O���t�t��Ӧ! �:��Ԕ��'Ӧ ���e�ԧ�R�<������"�4PiΥRY*E���@��*uY�.��g�O&��iH�Iy"�mI����DY�y{�hNp�\��͹<��ɳ&s�*hRR��.�iR�kh&�`�o�L��M�	�4��YQN"h�&��0Öŭ,�eٛ�e���$[v%ٚ7Ɏ��9��ͱ*k���R�X�ba��eX�)����V��j�O\�_}z~��ϯ^u<�~����׮('�z���&ʮ\olr�z�+�ϫ[q+�^��&�V�0/�n]�U@�Z�
0�֗YI
�+�H�Y��$֫>=�b�M��5!�DDDD��-��D)$���<�5��$�,�F����z��)מO����ho5�_�����)/��c���Q��*�et�e
����G�v2���}����i?e'
G���bL]��AwX�rD����*�}�&S漽N\7�~5g�G�f���0\�?�ixʿ��M�������#W�+Oh�(~�Uuh���J<Yp�<�/���~ �����i���
{a0*.k���l�k~�������}��e��ad0}�D�~w��i_�������^���ŗ�_�Y�W��ō8{�?�^�v���猷�u5o�.R�j^��Sd��Llu�`���}E#M\(�jg�:Ϛ@��zb�58�p7J���6R��L� O��
K>��E6"w�ہں�U"���C
h�d� a=����U9��(�c�N��D���@�t� ��yJ8�7x�˃�Nl��>��Þ	<c�e3,��p�H1��}Z`�>7;�f,��x��D{ҁ�	p�d �Qb5Z`,��v�k�8�P�qu�G��P6	��p�((�/�` ]9 je�J����?��Pl��u!�G��=��koOi!i"钤���N���X��$�����3
�yg�@�Y_ yo�[��� � �̮|]�����ׅ�L|�p�0\x̽��c�s�����}���ӑ�k�M��v���Q�}~�9�ɳ�q��Ɲzvz���(�NG�����(/�\9��(+?y���2�d�ȯ�&���Q�h��\&A��h��	��[�N��E�����v���kV����S�Vޞ�]9��c�n�9F���#�,;���eN~3��g�����iyɳ�/I�q�>����6�l���[��5�H��� ל:v�4����i�~����M^y���wo�[�������]V�2���-�V/u˾Knyvɾ]�����5��]���{�F�2˨{�.�wɪ{�V���m�W��2kؼm�歲m޼a��z�k�m�w�Vy���/OIY7zn����s�F�{��a�~;�ܯSV��r��-�ḽ�2n���q'�y9�×����*_9f�0�.�,<�����\�����ۘ��n��,��Ͳ�t��q���n���_��2q�Ɖ@#'����W-���ڂ[�'	"Ǉ'�C����;<��<L�_��(�7�s� ����)�\��0q~zr&�hyx^���gxm{<��b����bY�������n���r���n�"�����Ͻ>�wp8�����x<=Ǟ�eO���A�M.��Ye�j�M6���i0�3�f]�8�M�M������[��z�k��e�~۵pᮁ�-����m�:�k��i���v̲]���cˆ�wl�U��}[��o�^o�޺6{mtvv���80�OOCK:4 M<�t������*�:-V����"��1p4 :��>M	��F�.�fB4�^0�zt\$Zb�h ���gh�BӮ9hh�v��)U��Pk�(Z}1qd����R��]s��v��)U��Pk�(Z}�|��T���D�'I�	m�� �D���C�-Z�}��%z��s��HN�H��I�2NmVh���;�9$ܢ���[�ǽA=CK@�X�������B�N�$����	�ʔ�LՇ�H��Sk�H��E� $U��		$�GEr��T�$�*
T���	��|x� ����L���F��|T�� $�������� �E�}��GF7���sK���$D���Ԕ�c M(�(h�JM�W�]`�D�� ��[)=��]��0�DD��0I��� b���L�TI�6�饝g8�.?�� �Ӈ"���`2������3�~��=owR�9D�o:û�*���P�)��X�o>����� P�k���xu�7�+Q�����j�y��4ތ��Aj3�pr8�՜f��֙<r�_a"p�9�4��t���L.���k5��f�u&���7��8�&�f�Q\��P��98�N:�?5m=t���y\0s�;q�;O֝���[����y����!���������qwH��~z���OM?�q���gtN�Gpl��!�N�}�9����ܟ���Y��T-!ɫH��*�Z�
�!S���@i��������!C��L=,0?p���Iپ�dgڿꬱ�MCp���7��Yű��;�wp_ A>?��?�6]���{�v�"!A�&��D$�����ז�)���Rz+Q��M�_g��Rt���|M�%?�.|=�t�;�^�	+-�W�����g��޼/¿2�K��>�¿�)*d[U���<4x����xM�0{z �kw�#e���Y#F�	ǃL	��яC1����c���h���1����C/���P=���߰L�8ֶo*=����կg�7�S(�/�` 5# V�vA@�l(*m}�es�A<��P#[ ]	}5�������Uz+��q�L��L
����&ϱ�c�U]�)f d g ]�|�N�EF���\
*g���8eލ}_�6�q��N"�u��>�M	��8�.tXǸ�gلBs�yc+W��M:�� �F3�`�E��c�c�SY��������L����0ǚ!�|3��ʼ�w�`��DB-t�)�sҍV��i[����;(���>�S�v�~ZcP�)�az_�wP.5t폑�9#+x�O����	u���R�߁G�i�����48�0��T1���2 `ܨ�+6���� ��ѝU�#@�;[����1̱� �6%�e`+�)��NB�	ua�T�1+��ͩo�2.��;���i5��6Z���0ѝ�YwP��?��莩/5W�i3$��c�@W�!9E%0���u��K�%:�"�s�i�>�N�Ծ����:�(287}����y������T�Js�9De �Q	J�pB�h�0�d�1�ΉA��ӄ�� �2�����9��9u���So:�J���;�Aq\#��i�p�n�T���a����1�Ly22O�=�:}Ñ����jH�����C�'��b�����,�9�}���H���du�Ǜ�CS��!<���(�y�n��Gd�1c>����u���]��?�x�~��?ӄ��P�x����~<�� ?�OL=P{�9��SK6�bh�h^��{rLu��X5�6�Tj+����5P����Bg��4������߰�bTi���\����&Kr*�͘QG��	`�7�ԃ=O�7�×�g&���Kj"��s`��$�8Ik��0�6�8	��f����g0Uv��i6|%������x�6i�x��C�FmG�ژ�)�Y�Yv�wL�4p�1��=�	申q�×�I�D{�]�>�������0��wyq��գ��PNX�Dg�s�86���L��u�ӛ���H{C��}�'��Q=�l	�eMt��ҽ�e� ]��)��mI�3�9|3��wΉi����C'?��C�ˆ��~%,��B3T�̙@��d�jf�2yK��Z�Nc�u۵ﺪc�ŧ&iu*�T(�/�` E> �u�( �������;�dl[t�����Fh
fD����Y��dL�@Y����hˉ#D*N�6�^�s��$�3��7'���k.*ԡ��:���s�����}�t��"��Ѹ�L�NS�F=:���8���)qq2e�N�,���%'���s4D�#y�̈�$�#$�)\��IAi���*�"��)2�S���H���S���4,�1<�M=�ϧ�4�^�#7���9q�*�,��4�S$����P�U4Sfj��>ėO/��|��K�����D�R�D�R�T|�L�V�����.G�S,��`f�{�\>��N|r�d2)(M��O)��P�اd�S*i�P~��Ŗ����v��FÆ2��?ME"�L9UJ&I,ՖI?~�g���H5���4]Z�-�f��V��F�E���L�N|�'�u�����no��r�L�g���6qRY��V%],�GGC(��b3S+�$�t6`�É���K�����MbYg2DZ��)���) ���yC��f8���J5�m�j��Z��j�膯�����b��4j�>U''մ^8ٴl�*���ϊ�	*�c?�X<V���2�������M�>8����P��R��+�`H��.R�7����z5�m+-��n-;�YJ��RW�I�Jv��M�J�j�	��F��ۺQ���
��r
�wsd#�p��l��������N�l^w:�ƴ�Ma][�ӽε�{���o���o�����\���='tvQ�2����0��{ $� ��e�k�d�I�-��/�bLW	��TpBa(ś����0ɏ���lޭ�J�(̗(��P�|���Q��%CZg*ָ(s4n9c��<�6K�|�2`�.�_���"՛9��of�s�bi��������W�[C���{����z�(���k�*�Vy�P�t���%5�"v�'��>YӑJ�%k*݌�T&��Q����5�p�;�6*�&g�܉�h\��ظw��G��=���H���F>�D�ɇ%r��4F\�1�3���p
���
�<�R �Iu����Oi���A{�d��7���8Z�>��;�6>�ϙ�4������k��2���VAT������m������dW���3��)��M1���EO̠,γ��U�y�6�EI��(Np����TĵN�q��xԮ��#�׭���F��r(�w���f�G�����h�����������<L�a.m����`�XEc��[�P�6���c���54���j�]��'ƫb}���=��]ܮ�E	�@%t��4P]��n|P�ύ4�zXA#��'�a���+�la���|�l*�����B��n&S=+IkgE�Ȇ��{&R<��;�P��8��i�[��¹G�lx��)�+g3�蛮�L�|�1m�8�h��vl��9�]^�Hմ�Ū9�I��e�U4�U�� =s�a��b.տW�cj�U��!�W�2귨[L�,�`v>�_�eg��C]6�0�\�Y�ҽ�*�W�N�U����
��#�ԣ0��D �C� a��i�`�"�)E�1�7E@ej��h��ٛt�)��|F
��o���s��ţ~5SĞ��4����(�=����sc?�a�R2�f�<;�Ԡ������f��H�����9�n@2��f7�h�$�j>'�7=���ts��/1�����y� �;�s�t,ag���f1� :xv��),�}>�D�3x����F0- j���i¢�n�"؀���	Vh����t��<�*��mM��݌[w�N�y��d��eԱ�d��hƻ �q|�	������x4��̄(��-��Z[��O�0�f���'	;3����i�|8�k_2���i�6�;���4��,GN������um�8����1�fЄ�&�35@��h�ǔ�i�G�0��
9QM^�,M�92�Z	֫W��uva�ڟ�!�~j��-'A3���� =7�G(�/�`��+ �[X7��iA{�wW���3˵�A1�G����*,h�Wۂk?A�Vёov<��N�嗀�L) 	� X���M���Mv��&��6�����i��4���6\�������:����u����5xn/�=�Ӻ�|�� �36�� bҟX��I:��d$�Ĵ�'}�iIF:χ�m}[�/�����6�Q��Q	qR#��;���Fm�g�v6V�ogV�P�t��׌G�Q�+�3���8�}�:���*t���b;^97��x5���8�1�q4b��v���l ��<g����#�Y�L�#���79�T�:n4R9N+�lf/ZmF+J��rZ��O_���7�����s�"|�#� !�]RY�.��ᮻ>��LTik�h~�h�)�5��4�X���'�V��`+�g[Mh߂/�����=} >������2B�$�7~�đ>(�N�A��5#׎�iFG}>����t�g� _���k�����.����O�s�}�|���/���>�������M��.�Q��n��E��E~0�E�2�Y;��鬫~p�[s���^��º��N��N��d�xjO��]�2�ɞ���춌ݞ���^��:�hCߙnC�qN#��;���d5t"Q�1�Qk9���q8����/�R��a�3�0fQ�\�3�\a��|Ÿ����}����7M|E-~9�`j9�P�"�Q����(ö��&�P�䌗���mK/1ϖf��<�=D��^d��F��H��D���X�%�N��=5X�4��x�c��-|��7ʽ{��/�s�/ܲ�O����)�ň>��oj1��G`1��|S�P�K��Q����K�s���V�o�0�o'�\�5�������P�����!�+���8zbh����}fR!�X��vg�_S�L����?lmՐ3멙����c������ӡ�C��cW��̅W��l��;�P�T��3S���ό7�b��1&�b�����V�C���'�C�R����t��ς�����D"�����7 9c6�Xh6g�--M;��p˻�����c9�Id��������2k�����$�3N�]5�pd�w�p��tU�\m��M6�n��5ׁ�m2�=7�v"��9�&��d��{4���a!b��	d&�����@b�>X�����H�1!�@{ R����P�����Η<��꿟A U��i�)��V�kѻNL6}g�]��6�C�.O��RT�O�}TЇ��n���^rd�N��P����b�����.za�"�����4B+�ׁ�^��х��~��S|!H�b�?K��(�˦-�ĩ�"��U�m�WJm��I��r*I��1DSߥ�4]�'(ZPU j���=��X�7����<=��@ݺE�.ȱrR���鱉��I�Z��9:	7u7>�=�jRSCCJ*Lf����֔\[remap]

importer="scene"
importer_version=1
type="PackedScene"
uid="uid://dicg5cnpvna0j"
path="res://.godot/imported/dodec.glb-e94a0d0980820bc8fcb79994a55eaadd.scn"
 ��6&�d�@RSRC                    PackedScene            ��������                                            �      resource_local_to_scene    resource_name    background_mode    background_color    background_energy_multiplier    background_intensity    background_canvas_max_layer    background_camera_feed_id    sky    sky_custom_fov    sky_rotation    ambient_light_source    ambient_light_color    ambient_light_sky_contribution    ambient_light_energy    reflected_light_source    tonemap_mode    tonemap_exposure    tonemap_white    ssr_enabled    ssr_max_steps    ssr_fade_in    ssr_fade_out    ssr_depth_tolerance    ssao_enabled    ssao_radius    ssao_intensity    ssao_power    ssao_detail    ssao_horizon    ssao_sharpness    ssao_light_affect    ssao_ao_channel_affect    ssil_enabled    ssil_radius    ssil_intensity    ssil_sharpness    ssil_normal_rejection    sdfgi_enabled    sdfgi_use_occlusion    sdfgi_read_sky_light    sdfgi_bounce_feedback    sdfgi_cascades    sdfgi_min_cell_size    sdfgi_cascade0_distance    sdfgi_max_distance    sdfgi_y_scale    sdfgi_energy    sdfgi_normal_bias    sdfgi_probe_bias    glow_enabled    glow_levels/1    glow_levels/2    glow_levels/3    glow_levels/4    glow_levels/5    glow_levels/6    glow_levels/7    glow_normalized    glow_intensity    glow_strength 	   glow_mix    glow_bloom    glow_blend_mode    glow_hdr_threshold    glow_hdr_scale    glow_hdr_luminance_cap    glow_map_strength 	   glow_map    fog_enabled    fog_light_color    fog_light_energy    fog_sun_scatter    fog_density    fog_aerial_perspective    fog_sky_affect    fog_height    fog_height_density    volumetric_fog_enabled    volumetric_fog_density    volumetric_fog_albedo    volumetric_fog_emission    volumetric_fog_emission_energy    volumetric_fog_gi_inject    volumetric_fog_anisotropy    volumetric_fog_length    volumetric_fog_detail_spread    volumetric_fog_ambient_inject    volumetric_fog_sky_affect -   volumetric_fog_temporal_reprojection_enabled ,   volumetric_fog_temporal_reprojection_amount    adjustment_enabled    adjustment_brightness    adjustment_contrast    adjustment_saturation    adjustment_color_correction    script    render_priority 
   next_pass    transparency    blend_mode 
   cull_mode    depth_draw_mode    no_depth_test    shading_mode    diffuse_mode    specular_mode    disable_ambient_light    vertex_color_use_as_albedo    vertex_color_is_srgb    albedo_color    albedo_texture    albedo_texture_force_srgb    albedo_texture_msdf    heightmap_enabled    heightmap_scale    heightmap_deep_parallax    heightmap_flip_tangent    heightmap_flip_binormal    heightmap_texture    heightmap_flip_texture    refraction_enabled    refraction_scale    refraction_texture    refraction_texture_channel    detail_enabled    detail_mask    detail_blend_mode    detail_uv_layer    detail_albedo    detail_normal 
   uv1_scale    uv1_offset    uv1_triplanar    uv1_triplanar_sharpness    uv1_world_triplanar 
   uv2_scale    uv2_offset    uv2_triplanar    uv2_triplanar_sharpness    uv2_world_triplanar    texture_filter    texture_repeat    disable_receive_shadows    shadow_to_opacity    billboard_mode    billboard_keep_scale    grow    grow_amount    fixed_size    use_point_size    point_size    use_particle_trails    proximity_fade_enabled    proximity_fade_distance    msdf_pixel_range    msdf_outline_size    distance_fade_mode    distance_fade_min_distance    distance_fade_max_distance 	   metallic    metallic_specular    metallic_texture    metallic_texture_channel 
   roughness    roughness_texture    roughness_texture_channel    emission_enabled 	   emission    emission_energy_multiplier    emission_operator    emission_on_uv2    emission_texture    normal_enabled    normal_scale    normal_texture    rim_enabled    rim 	   rim_tint    rim_texture    clearcoat_enabled 
   clearcoat    clearcoat_roughness    clearcoat_texture    anisotropy_enabled    anisotropy    anisotropy_flowmap    ao_enabled    ao_light_affect    ao_texture 
   ao_on_uv2    ao_texture_channel    subsurf_scatter_enabled    subsurf_scatter_strength    subsurf_scatter_skin_mode    subsurf_scatter_texture &   subsurf_scatter_transmittance_enabled $   subsurf_scatter_transmittance_color &   subsurf_scatter_transmittance_texture $   subsurf_scatter_transmittance_depth $   subsurf_scatter_transmittance_boost    backlight_enabled 
   backlight    backlight_texture    line_spacing    font 
   font_size    font_color    outline_size    outline_color    shadow_size    shadow_color    shadow_offset 	   _bundled       PackedScene    res://dodec.glb �*��4�5k   Script    res://dodec.gd ��������      local://Environment_6l3cr �      !   local://StandardMaterial3D_0l0xn 7      !   local://StandardMaterial3D_igxs8 ~         local://LabelSettings_4hi14          local://LabelSettings_dycr2 C         local://PackedScene_mdw3k y         Environment                     �?  �?  �?  �?         2         `         StandardMaterial3D    h          n      ���>���>���>  �?`         StandardMaterial3D    c         n                    �?�         �      ���>���>���>  �?�         �         �      ��~?��?��C?  �?`         LabelSettings    �      8   `         LabelSettings    �                    �?`         PackedScene    �      
         names "   9      dodec    script    WorldEnvironment    environment    Solid    material_override 
   Solid_001 	   Camera3D 
   transform 
   top_level    UI    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    Control    Panel    custom_minimum_size    anchor_left    offset_left    offset_bottom    VBoxContainer    offset_right    Label    text    label_settings    horizontal_alignment    SpinBox 
   max_value    prefix    suffix    Label2    OptionButton    item_count 	   selected    popup/item_0/text    popup/item_0/id    popup/item_1/text    popup/item_1/id    popup/item_2/text    popup/item_2/id    Go    Button    anchor_top    offset_top    HSlider 
   min_value    step    value    _on_spin_box_value_changed    value_changed     _on_option_button_item_selected    item_selected    _on_go_pressed    pressed    	   variants    (                                                     1�;�      �?      �?      ��    1�;�\��?                               �?      
     HC  �C            �      B            PA      �      Angle               �C                 degrees       Axis       X       Y       Z       GO    ����   � p?     '�     $�      Camera Zoom          
     �C         ��     ��     �?     @@)   �������?      node_count             nodes       �����������    ����                          ����                     ���  ����                     ���  ����                          ����         	                     
  ����                  	      	      
      
                   ����                        	      	                                     ����                  	      	                  
      
                   ����      
                                     ����      
                                    !  ����      
                                "   "  ����	      
   #      $      %      &      '      (      )      *   
              ,   +  ����      
                         ����                     -   	      	      	         .                            !              /   /  ����      "                  	   -   	      	      	      #   .   $               0   %      &   1   '   2   %             conn_count             conns        	       4   3                     6   5                     8   7                    node_paths              editable_instances              base_scene              version       `      RSRC�GST2   E  E     ����               EE       L1  RIFFD1  WEBPVP8L81  /DQ !3m�(i��g<���(JqGݫd�a �'=������ 0���Uж��� �~�̇��|d�� �fug�����m�V[kk3o� �/�(���6��轏����^l˶m�m����s/��П� ��(#�I��d�7��l۞�mΛt�Z#�����˱���>� �h�;�����&|"}���|����_;m%�?�*����^��Kn�n?"M�F������s���b��#����r�H3���_C{����
ѥO�����v(����0�(�Sŏ��!��{��U�� =7ß�yh/�v���ǂ���ʸ^�|d��64tׇ�<�O�w��y%���^�X\����>}���@e������Ǆ�3�����5K��i5��a�nŋᗏS�h
���F*�ͫ�k�uLWj�"�f�8p���4�ߦU��鑞'qi����6�Q5��9���y������fi2�×�V�����gl�N�Qk� ��H��S��0	��|���󷏏��y���߱m�NL}
��0|��{�2�	����/�we�n ڥ�A4���<W�������~�V�a��.cS���<C�ng_6���{l?ϫ)�Es��sHK���/`��f�)3�����=��yZM�p��KG���iŋ�����cz�_��y{kڎ���8�L��8@��5��h������O�J=�4�dTF�HK[�	"ϓ���ssz��iyM��Nmg�25 �!MD�~~}mZ�4r�J���`�M��sd��M�q^z}ir�!~�fio�*+ yv4�'�?��6�~����-VWG$�#I�� ��,��P�	 ������KK�yy�Ep74�$ �?��n�G�6*�r}��o C+�dI$H�G�|,<�7iO�~|y��aZ��V����Oi ͔\�?��K+�|���2�=u��x2-M�J��:��8v��w����ӷ[6��Z�j[�p�V�g@������eO���4��)�y���P���狈���M[��ִ�Z@@Ԯ��~M P��}7}K��`��2�Ы��p;����~����g�;?�˦a�a��`�^x.�����D�N˅3 ��O���m��	}�.Ko�oV��SF!=��n�!�����ܾ�H%릔5w���D��#sq�w����o�^�2$F�za��MrD���4��ڡ7������x��$�i�J Ht}���g�_�i��i��7�o��di���H8���#��˿��t�������z3�~!�E�n�3|��M�F��OO]{�G$�����.���i)��, 2".�V=M�b�e��(=��\�����e1~�p�l(��Bѭ�-��'YG[�8v�fB%�J�ڊ®������]4m%+���Y*��#�a.��x���V���b6G���Ih��v�S%ȅ/Z0���B��zyq�7��7�IY �����L��NߓG�CN��.���[ATR�~�ص׫	��'
����R���EH楴�)Aq��h�f�j�h/<Zs� &���t�j�A;up(`��Z��p�R��Y$£w���%�-%;�����쁲ՁS�Fp��5��՗�@xt����2}*�5!#���q�%:�q)�9km�K�?�}~��)x�~LL��Q�\���ެ&oV��.��=�E�n����nn (����f��@'|$��W���HZ�	��
ݭ���z�o���fw[;0�^��Wr�z5y��PT#�iP�9�T[$�˽��[O������to�Qrh7ׅ��믗Yp��<#8�Q������GF���w]%��|K��� �!������D���)a?�H}���������ca��&���u�Y �O�@A��K��8^����>Ɗyґѣc[�Q[�����QML�x�K��f1�ʚ\�@�������:�1�{��З\��ݕk����2��qs�������z9~��n�.����v�9?>W�Z��VmU��!��@��r��R��r�j1��dE[N�����S�����@�b�~�H���v���k����Ÿ �K�Z}q|����2�����1���~6�p�b���k�[/^-F���3Ѝ ����Ǉ�6��>����roD/� �E���P7+��)TC��v1�v1JВ�:9���hB�_3 ����\�3Ȱ9�[�i���M23ݵ�� z)������ѷ秛�P���xD���)z���x�E}��V4]�%G|�F��U@Zu���uSߞ�~s~ZQR_�}z<���������{�t`ӑ����}k�	���d��ݢ4�� Tl��-���ys}U��9;����볓��NFt~�����<l}�˝�i�dfq+O4�z	�sh�=$����ni�F�ڥ	������^?`6}�8�ꓺ��ML# �Y&n`|��8��rw0Z.�42%���V�_��y��g���dT	%�"m�?!��t.��2�wf�*3�~y{���)�����0I��/rQ�x�H�+����Œ,tJ��f����r���ן��6@�&�#����Jfu��d�U
5�DA}�$oDr���R��MH��u{󯻛��O���
��
6�n:.@>��Ҫ	�!@���

�	6�ntDI-|�le��S��V����Ϳ�n�9-��M}>�K �3�HrJ�L�k�$�0V-�U��8i7�"b���S�E�V�<���nol?�����R?�uF��q��N��qY�)�و��m)mh�%)���4�)!Z}������������M�S@�����hf�iF���ȔJ	�e���"L��F�4�����f������b�e���Ǘ;_�q�e�&R�,ίEyE(c�&	�9���JTH2E(J�s/c08������������� ��i�a��l�}���H���ۇ�)g�pب%A$*�lj�b-
f�1� }�6�p����O���i��O1�&�Ę�eUT#bl,���S�"�Z( \N��9�Y$�O�<�f�>l���*�m"���6 UtJ�1׷�!��A809�
쨿^M�����(�F�Gﯥ�

H�X�� �����UğM�-w%5����{�m�m|.�ʊ@۵7��6���l�P��͝� a�h�`qc��K,%���B�Vh�o&��҅\&�6A0�������F��tS����!�ѭ��k��Χ`�s�D0Eӻ#1
�P��`��6e�����P\�5���K��O�Ov�ZP�!S��rjz�F)Q� ���   T���	�O���Y�-��q�)��<� �G�ZIJm��lcH�%n�-]X��E��s4g�� ����,6
5\�(����%�^;�"SB�4网6a���s�f������]	⻋�A�z�|�������O���j�c^R���Lٹd�7��nx!͔��5sI�o�(�z�}شM�3e��~/bi,�2�c�!���0�����,i�]�@��F�)��SA(���>�@7-j)�	1��K,�:��#o�/�
�� EdS��NZ�)�U��E��˸��.����Zn�%dM��Ą����Ԣ�W��m
d9<��� vB^Q�,���f�kq��%a_f���h;�?�J�H�{ps�6 ��
J5���v�\ m,��6P����_���b�ּ}�o�*K��u ��!���y��P4)"HP��7u���J	_�t��J\���vDڻ�Ŧ�$�$��M�FX8a
�Q��i�H��o�d�_e4(iؔ��es��G�GdJ�o�AEh+�E�y�=sU�w�RЍ�l�5
4�_���׫��"�*���&��5������c�����-54�h�{��f%L�r8
��e�g���D�����С�<��{�1J�BB�!S����ݐ;	�ȱ=6�L�ac�]C6TW�^o7�9��}���w,�Q@�aT�n
��Tf#��y�0[H�Q���̕'e2s�_G��	fڸ��J�����l����^��KU�52Uɻ�nB����)D�l�Bb�W9�G!T��N9��E! c�B(��G_2V���`���G�wL][�d�_�BU�!uB��S��(�`�A��D� KI8��w6��L�-�iH�MF R��гV�Z��Y�@� ��ߍ�Zb|�Ќ�!��VF��_�;�ٸ�e	��A*�,wa��)U*�:g�l��]Z��+r��D�Jީ!1#���i���h���)�A����#�H�}㌉n��BM�(n�Et�Yr�'�8K�"��m~�`g{�h��45Z�&y�Uٞ���)Y\�(�:X7��q�	�i*e��ԩ��_���%ڶ�v�η#T����n�	�p�V�|��M0�Rs ��wi��37�hA�h�@Ѹ��hG���Ƃ4&��4��*ֺ�\���T��4��M�YJ������n|�.^P7�C�K8��w����
��	�\�s*���5�/#������6�J��
	K�F5���/Χ�i�n�0J�6$qΒl������~E䰐�y��閸��l2�~��m@ʘ�F���~FM@�ef�|�+S^jɜx*<��n�K���	�����T-ܰj+K�X�m�.����Dۇ͌Bϧ'���^y?wz�v{�/���Mi�ъ/�iB�Łڢ8�:	��[�΃���c��z<��08v�~;�Va<I�-�h�%g̲�v#B��a3߀|[�q�z������r�e�&I�$�T�j&�b�h�KF�fT�3'vT1P~�z�ʮ"3 �aQ�H ����SÊ���b4:��ILq�*{G�/Y�*{z��S�V�uS.2 .Ժ��
ᨀ4��ۣմ��?��*���Aª*h�o#�T!�:)GC�.�s7h�\2�[�	?~�.R�J��K� B��3F�܇+���O@��P����A�R�v*Ť4ogi>�x�͹��(�Qb'T>�G���R'�F+��)�+m���u{#�v)-35-F&�<��t"m�|���K6@�*�t�TZ�,�(�63��w��������o�G����E,@�P�$�(��Q�L~�*����`s�G%Q
�$!�m�x����dD;?r�IH*ӭ���H�ܥ� �`J1@���]~h�P�K�0͍*	X�
���S�1�jV�z4��'D!��X�l*P~�y���ׅ��M�VB[p��SG�A�9  �x��w1Jh��_�o�=?��]BI�����v,:P'ڝ3	����nͥ���v���I6��� ��p��	�N��IYe$����[��!K����f�B]����<i�m��%#���H�g7�ͳ��f���^;Z�j&66�pQ��Ѵ%��)�Q��ڞ�����pŭ�݆����� 4�^mۈ6!��_�C��l�o�O�����cs3Z�6��/%#u�)��V�3����Ð� �ݤ��P:�Di� ����fU�Z��?�+�U>O�h�O*�E�Tz6���P'��h�^�]zv�U ���[�:�Y���).�A$�hƴ�V���Ï��etxZ�!L��_�L"�X0Ly�	I7^  Ca��B��G)�j�%Q��C�jn�f�Q�X$ߜ��X{W+Ɣm@T4��ñ����(btb�9NG����M ��6��$-�Zq~���v#�Z�B䛳��������Y��:�c��>TF�� P�D���7S�"�A�9�z��]P'�M}R����N:��?ܡ@i22Z�{�L7�C%�܅�g��|D`����U��P�Gv�����CRt��A2`3��#����ɡ�Sx�P͹I�%��Ze�Cw^m�$ʲ�/���w꛸+�c)��TJg�6d}!ȘL[�6���B�Dw�rh��"�-_S����C�B�Z��n,��OOF�֔/5-��W"�̔��J�it7�~c�P�a�2�]h3��4Q��lG��p��PMI�x�y����������L+'�:[��h���D��x�	��h׬$�¤'�h`A��Q���M�`�q�p!�M�j�o`�w�����(5�	�BT�2?�b��D@4��4���:��5��>�;*G�	iT�8���n��f?�\��jb��+�Z��A�)|%DNBhe��D��I1~uzܞ'�[C���e��ڮ��*䇒o쭙Ҧ8Y�rܗ��6��ǍFOi��8�	~'P��y T�bߵ�-�s_�,�M*HD�:��.�-�C�����Flq~~t����Ǉ_~y|���ї'G_�����ML�Xs��r��In�ٸ��8�@;�v/�ʢ�S��l(#�a3��U�_�l���z���ro����'{;���|������{��}v������GSn��7_K#��`���,��y�"�*�b�攄��T���/��� m�6�R1ja�RtH����k�kh<���D�Z牥�qUi��X⊎�|�v����_o72j��u��G��P�Abn��|�~�=[��>o�L��-�ԅ9���xz��'������btm[��n�|�આ,��j1� �ݕ��i���!r[�����[܋#�3���dA���fZ\^ۇ��QL��o�������ş�Ň���f��f����������??������׏�_�ߧ�^-�C6�	bZX�.~n���{�Y�v��+��)������lR����/�￼��������ϯ�?��������K���r�[ӊ�!9;B��D���?>�Ы�#���)��2D<��{;�|����݂�FcX\�EA�ty����'u����gI�AM�Ӵ��ţ�F��j���	�w��Αd��|zaH8}/UOJr���\�Z���P7�=L���=b�<U�Zj���K#�"%��CIh "T#������A�)p�ʊ��؄R���+`!� �4�7����/����*\�|XZ�IF K~���"f�VDL�%ny��rT�)���N2�B{�|De.>��b@w~�7S�Zh,��t�W���jZ�YT��� �9��P�����s�ެκ��4\�kI!�|ѨK�aC��9�3�X��vHDh����O%�b�rhvf��:��v�����s{tۈp��ڢ3x.4C��9x�@X :+,96*�C�ى)!t�DsCU?��y�� 6Ar�1�Y7sÉ����Kڱe(��4ؑ�$[��iTk�V���:�6IE��������"|9M��D�`��U2A�̹J��5���W�}�f�i�����_�e��?d�r��%z���bQ���;��]��XT��2i	�6j+��`*!��(���LW��ڈ�� #��UH��xخ��!���O��.�Ct+2h��n��VX ��n��6yٖ��.�D�]I:yH��J�B�2��G�}�C/��aQ��&����S��6��@ZbY����n{I�/�+�2�(%^�vQi)V�� �W���]�����v @r��DeNwbL͢�r��;�p$�r��gnU	�P�GB�Ⲙ<�T�!u���e��I�҈���5��ebQu'_�$N6�R�RH�`��/A�X�"8f�aPQd5JCe��Ue���=��ľ�%,{L��Ȋ`����<I�|�&��/�Ĺ
f�⬜�,�)��GC�@R�!"�z���#�YQHJ{��Ե�.�%j�K*٣!���5��:\��V����$[NBp��Bw�� �;u�_��@��h��^^��ds����T�j��$L�Y<J��6�o����p�{�jr9	�Ex����iűM@c�@|���9�%�	D�	�ە�o=�diK�  �]o
)�]K`q�Q��:��rZ�Hc�zM9B,�Cܚ��[�Ҫ���JDԎ*:��Fh��H�
��ɘ���4��e��%�<�2!L�*�ZI��#��T��C"��W��l	��B������o
���!�B"������(�_?v4�zu���*@�Bġ�`�%����b>Ռ8S~��¢�����:$f�.2 #����Ƌt�)��]]j̖P[�Ai&$8凁��R1/b�,��x		�a>��4�5��w6���da�'ޯgY=�#
8��Ֆ1����y��V�%�n����D�T2ڟ ���x4�DT"��n�8��dMl-��H4aQ���<�+jfı�t�踰��YLL�_b�p�wѻ��
����w��!��U> L�t�4�E;!V�r�u������]85`Y��Hbڋ�ʰE����D�'�|�lN�5ٯ��?o�Am-��M(����w�"��Z�f�_+�;��h�� 'N ��Q��$������Dۇ͌B�'�7v�V�U=yv�!xXnJC�V|��~�6��v�. ��I��|-�\�!�L���iK��u��=V��� h������E���v�Y0]C�M*er>iꈲ��֩ݸ���-li�s�2��AKV�ɭ��[�"):T���Z*e%%�Y��$�I��� ����L�i�#�{�0��ڄ�4��h6�Ђ�:n���۶T�3�J4)%mқR�e��z��f�h�1u�P��|/HM�
S1��䝀�8��V	ړĨY�Xڊ."�U��U'4��wmm���x ���,KT\�K�B	ʜٖ�Tl
�y�i;4,/E�*�3bg���&U�Q ,@�qo�`�DS������Jm���O�nz�6gB����!R�pn:�Z�YЎ ����i�`@]�+-�h@ul`x�-Rn��ƹġ��H�,�A�E-�ᱼ������~��g�[���U46B�*��v�i�jߖm:3��h�q��	a�,Χĵ�dp�̆n�z���kj3ihU,
w���@��ґ2=��n-��FJ�z���06����F�f�b1��M:JH@V���$7�U��������#����@{� WؘvC)�J�0�Ȣm��bRD�f����qo�!1�@����2qG���_��'�������M�DB襄v�✶J����G�z��9N�[�TA5jP_$c�Q�@�z�l3�IX��n�s��F]X�	͊2�{Nj'é)�65��&���p�h��$B�C�L%[''B�'�'�$1�
5��;��tC���9U�7H�lQ�UA�%�@t�Nī��^t�l/Oe���D�&�;�dp���,���C�Ͼ���� *A���3�T�P��B:�%����(�+ �,m�.!
u���� �_J6��1w�F@�=hZ�f.!R��΁�,{%��I��PЀ"�zǃ��jSS�N�'t� 	-lj�	z�;�x�M�(�B`	����p6- �t����w��'�6�����/j.
@9Mt�幀$�HSV������
�P��O�я��G�v�/y��\�Qe�$��YŃ�<����:���K�ђ�U%�"��+@zӇ~��ggd3,�N@oSe��)�"
����X���Є�c{���	�/�FQ�S�W��\� D�ħ�lp.�l��({�a�����K�i�4�y�U� :U,�yNo��ԡ���b�~VL�\�Z�X��!w�a��$�J��դ�`�$ۄ(Z�
@��$$�6q@�S�*^�\'! �
�'���q\��(4��Z ¨��hC|.���C��: �Y�#R��#3�������M���$y��.�Kn;@���(x��%�[1�$P��"����^� v��t���Y��
�
��	��7k�5=2��o>�w�J#乲�ס_�!E.�1�(s�����ه#v)��˨�O�t^lm� �3Jw}����ys״ɳ��6�Zw�F-R���4G�������v����6rB��QD)I ��.@iK�"Ơ�5��v�i�R�gn��z��<�%�����g'b8,�d��U�5h����J�UBoVg��#���=d��n���G����Z��"�E	��;{%�HM�j�3q��󻋳IZ��üq���E�|�� :��<�u�\�&D�p�T���iN�z�$떀�m��.Χ��f ?Ω���������G݄�_��� ���+�f^�dR���蒣�[v�]�ߔ����8 ��������N�?����夅*��~_Z��6���-�M���E/f)����l�v�O�,|~�X��`�@}$<6���w	hf��H�H)z�`���)�<�-��;��/rM�j��91	�>�P�m�V�nЙbq�M�����R@�vuYy���y
!� ����|�'��䙲��|o
7hR��nk@\�6I��9+�3X��%A��_���)2.D%���}�`��.� �N�(����?�u��T��/��2���,�En����#Ze����^S{%>E�"� ���A�1�_��
!��#�p�l��^���S�!�.1[�:uc'��B=-����&��MA�Z���=��w�Ϳ�nԯ�\q M��N�fN�;ӿ_�,w?<?շ�ף	����6�-
ENnM�ԧ?O���@��5�9��7��	�qN����9x���]?�9/�}�l�OY��<�N�D�FwK�����A�ئ���Z���c�=���4�ф٧�?�ъ�G�V�m����"L�VeW�
�Ө��@3�0���#�	$?�k�/Gv��Ü�c�(�_/���qk� �B�l����dy�|���Z�����g?���s��������s��@��$�B�yp;!<�}(����z�Kg$�˔/�h����6qE���[$�&��^�f�Z���������2�->�ǧ��S�������^Ƶ�FJ��R�:#o�_�X<p�_�,>3$����`B�Y1�����ĒF8��m��j�������|d�mZ�l���Z��\"*l���%P�gp���S��@��f���t���;nb�~�Vޅ���A�>�K�2ڜ�����A>��ЇO�W�qe�*s����]]^�@�����j��A�s^w� n����Tu���6�$ծEDJ���	jx�h�0g%/�Q�o��Zjs�#�Z�����L��g'���sV�e��m6�V��b�3Y l�n��$$Q�4�0|%d_���b�����#,I�z	2�Y�Jh%Њ��G���'/O�.��z��_//�Ff�5�lH['0�����U�17H7�z����l""y�v1j��dT3����}'E;��'�%�U��屿�_�[KAo����u�Wo?�lm|zd� ����J[�����>0$�=����'�d���;$��%; Un+h� �9<�,��>���H�D�Y�ª∼��[��hl�¥R���������' �7�E���Sv� �#	�	S������n3=�|��7��!���A
8� �{��z�������m��(�z�:��a�(1]�\��"/�O%��$W�%�ߌ��n;-����U!��|f�f���Hκcw��rg��I��b�pb�V�̂������.��.�R-#Mb5�k���.Cеq.�H� �h�t��ғ��`�v3-�q��x F�������ۿ׶w���kl}�H�V����'A��w�iû�uġ�c?����$_���vְX�d���ER<HO�oI�$��zܸ����&�{�<�Y6}����ȍ��v6��:���A��I�,���o�㊛y�չ�|����/��IN5�q�a;WO;r� �U6J
a.#�Υ�-���7E�<=�﹬���m���}?�	1��	�V�?<�
w_�]��{q�Sf�d�va�����`��aiG�_������v�rA�7�MS��ώT	He��a����?�i�-�d#���(��a�_���P�/Ǎ�;�L$3?���6΁-}<;�pX �,nzK�B�"�ny�|�7��� ����W��̾����ڡ��M�gNBʓ�B���Aɬ@i-D�L`����Y�$��b|1nL�X��)���V��@�,{Z�b����Y�3�a��������6���8���_@bZ���>?�JFu9���m�nƢ���V�ԯ!�bg8����K�?�L^�?_;��<w҇��K����a0�W���k#�3���@!Ϡ�d�
}6>7B����@++��_;��9Y�,JV�|6"��U��d��V���S	L*��a=֫�6qi�6پ��ǉo.=���_멑4��2�q�����81=��&���~��?#�8, �M�Vض��W�J|�k��a&���h��m��3�_뱖��0���ǃ�JҦ_����7L�����}���ap��_���U��x{1�C�Y[��r�Z��G@���#�m/���/ú�?���E��c��v���^�|���ߣ�+�������l7y�F;|������ �S��+���n���[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://d266g8hwhlvjw"
path="res://.godot/imported/icon.png-487276ed1e3a0c39cad0279d744ee560.ctex"
metadata={
"vram_texture": false
}
 K%[U��i��n��extends MeshInstance3D

var phi = (1.0 + sqrt(5.0)) / 2.0  # The Golden Ratio
	# Define the 20 vertices of the dodecahedron
var vertices = [
  Vector3(1.0, 1.0, 1.0),
  Vector3(-1.0, 1.0, 1.0),
  Vector3(-1.0, -1.0, 1.0),
  Vector3(1.0, -1.0, 1.0),
  Vector3(1.0, 1.0, -1.0),
  Vector3(-1.0, 1.0, -1.0),
  Vector3(-1.0, -1.0, -1.0),
  Vector3(1.0, -1.0, -1.0),
  Vector3(0.0, 1.61803398875, 0.61803398875),
  Vector3(0.0, -1.61803398875, 0.61803398875),
  Vector3(0.0, 1.61803398875, -0.61803398875),
  Vector3(0.0, -1.61803398875, -0.61803398875),
  Vector3(0.61803398875, 0.61803398875, 1.61803398875),
  Vector3(-0.61803398875, 0.61803398875, 1.61803398875),
  Vector3(0.61803398875, -0.61803398875, 1.61803398875),
  Vector3(-0.61803398875, -0.61803398875, 1.61803398875),
  Vector3(1.61803398875, 0.61803398875, 0.61803398875),
  Vector3(-1.61803398875, 0.61803398875, 0.61803398875),
  Vector3(1.61803398875, -0.61803398875, 0.61803398875),
  Vector3(-1.61803398875, -0.61803398875, 0.61803398875)
]


var indices = [
	Vector2(0, 1), Vector2(1, 2), Vector2(2, 3), Vector2(3, 4), Vector2(4, 0)
]



func _ready():
	for ind in indices:
		line(vertices[ind.x],vertices[ind.y],Color.RED)

	for v in vertices:
		point(v,.05,Color.BLACK)
func getClosest(nogo,vert):
	var closest
	for v in  vertices:
		if not v in nogo:
			if not closest or v.distance_to(vert) <  closest.distance_to(vert):
				closest = v
	return closest

func line(pos1: Vector3, pos2: Vector3, color = Color.WHITE_SMOKE, persist_ms = 0):
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(pos1)
	immediate_mesh.surface_add_vertex(pos2)
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	
	add_child.call_deferred(mesh_instance)
	if persist_ms:
		await get_tree().create_timer(persist_ms).timeout
		mesh_instance.queue_free()
	else:
		return mesh_instance


func point(pos:Vector3, radius = 0.05, color = Color.WHITE_SMOKE, persist_ms = 0):
	var mesh_instance := MeshInstance3D.new()
	var sphere_mesh := SphereMesh.new()
	var material := ORMMaterial3D.new()
		
	mesh_instance.mesh = sphere_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	mesh_instance.position = pos
	
	sphere_mesh.radius = radius
	sphere_mesh.height = radius*2
	sphere_mesh.material = material
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	
	add_child.call_deferred(mesh_instance)
	if persist_ms:
		await get_tree().create_timer(persist_ms).timeout
		mesh_instance.queue_free()
	else:
		return mesh_instance
��Ɵ\��?�[remap]

path="res://.godot/exported/133200997/export-8d4fb4946e8bffb054f540fa46db5c2f-dodec.scn"
('�T����ϭ ��list=Array[Dictionary]([{
"base": &"Camera3D",
"class": &"FreeLookCamera",
"icon": "",
"language": &"GDScript",
"path": "res://Camera3D.gd"
}])
�PNG

   IHDR  E  E   {t�]  �iCCPICC profile  (�}�=H�@�_S�R*� ꐡ:Yq�*�Bi+��`r�4iHR\ׂ��Ug]\A����I�EJ�_Rh��q?��{ܽ�f��f��j��N��\~U�"�a 1�%f���b���>���x���?G�R0���nX��3���y�8�ʒB|N<n���.��ƹ��3#F6=O!K],w1+*�4qTQ5�r.+��8��:kߓ�0T�V2\�9���D
"d�QA�U�F��4��=�C�?E.�\0r,������ݚũI7)z_l�c���m�v��?WZ�_k���7:Z��.�;��\� �O�dH��)���}S��5���>N�,u�|c%�^�xw_wo��i���br���   bKGD  Y  ���Q   	pHYs  .#  .#x�?v   tIME�
 .��   tEXtComment Created with GIMPW�    IDATx���Ǒ�#���,y$J$���Ų=?ε�X��I��M͕����*3��,� D�TU�����/"2�� [�lٲ �g��e˖-��-[�l	�lٲeK(f˖-[B1[�l��ٲe˖P̖-[��b�lٲ%�e˖-��-[�l	�lٲeK(f˖-[B1[�l��ٲe˶������Q\���e˖PL ��ٲ%��	�l��	��̖P̖-Ue��b�sV�	�l	�l	�e�l	��:�o�2[B1���������u+Ue��b�T�,����ڢ<�N�������/o:x���ը�e�T��B
1	���brU<(3N�-��@Y�(�*���_=���r�*ܽ�`��̖P<K �V�ģ�X0�&may�{6��v�2ۺ���)���H[�}q���|xӬխ0�u�oX��ΖJ���=�#'i����=7�r�*7[|~#Ue�T�y�@�B�������3����e�bP-Z�����Ue^B	�l���D��`�y����?���_7|�8@��X�����*�i�����>�%M�Z2^��f$���m8o���UN�Y2��m�@�8�����(�� ���HX�m'�X�*�%C�a�9�	Ǆb�������D0�L�p�31��2�d�>J�i��J ��rL]e�����)kE�[�ͺ/o�s��/�_4���b�5�m�x�7N�����;y��R�6� �]W�o�ލѶ�h��V��n��u���BR�6�uiL�P�6�W*��Dje",��+H��%`: ȁU �lU �
$[�pL(f�h! R$>��D������C/0���T�d!X��@�d�+)S\�J���M�h�p�����C�������fc����Vy�'�������$�	�^ nHP0 n�~�⨳��j�����F�(���)$�K3�s���Zg���
/��G�^��5ն$�j�A�2�n���㬐�� 3�J1���BN�ܸx�~��y���a�I�[�C�R�*Ų��T����Q���>�]�{#��?�PZ�P��{��r�&�uS�+ȩz�U�	Ȅb�}��e��[�k�
M� )
J/$'�+ 9���<�Ӡ�i��>'+�%����o�����c`�8� z� v�,�6��d�Q]��:��m]v�K�\-�����������F`����H��'/K8&�S(�e�(A�ĩ����O����{�
�\���[)04�c�1��@ D3�x�����w MJ-5ƨ�S����+E0'�6�P<o ¬�Ɠh1��d�@� ���ޭ��P��d �b�싎��RO(�9u�/ ր|�*��恟�$[ �]�V�~�&�	Ć�7w�[��� I������& �`�pL(&���3}�,��(� ���Ye�.@㌝V;�P< 2	g�y�@��hO:b�uH�i�G�Z�2��N(�)-�<W�7�}wt�� ��٦�@���dX=*0L8&�@8N(� ������:G�*c*2
HOfEp<W@&D��J���>v ր�5�uXb�GE: ���N8&���>^�@�D�: �y����q���~�� �v-�� ���8v�0�P\�J��V�����EE\|�^Hʀt��Z{UdG�1�PL j@�Zb�]��V�I����v��_W}<�<����Bϫ5�(Yh�Z'�	� Q�a�� �<\? m��^�}�-�rpdaY�=2�	?��)2��z �vy>�v�?bAH��4������Y����pd8����iZO�	Ž �D�R*��[�{��k��w��g�:Ua Cp�tñ�=J�9�1�8
��!�F ѓ`D
�0λ��m��� Z~�u���p��s�pL(.D�F7q�����XJ��VC��T9u@6�G#���rlOƜ���)�UQQy�A�����ߏ ��y�cfڿ,��	Gvlǫ�Ǆb�@�>mI��������`H~ v��S��Z��Ѯs,a82�ǵ2��Dp�Z��.�<�^�E��ӎ��+߱��p\0�b����Pl��� Vy�@�@���(y���  ��(/���10���)��b9e8��o���"�@���q ��F���'�b+ɥ-����7��D �qh��P�s�A;_?��CGMb��;@��k�ԥjD��1�%;�X)��E��@�&�y`)�H�O�'�_= �K���x	���,5���$�	�b-�B�V��w���aFA����H��b���Bk�Į�%��DA5� ���8�Bф���H��`{����!8.d�G�ƿ|}ѽo�G�Jv���H,�F Q��+�>=���㜥'H ftqX����;��EB�h����m���8������ˌ3$� ��Uc�����ͻ�Bq�PdKoz�8�ޒ@ x���6����s�@�����h�u��iM%~y��"�9�xL@42�S�%O'`� �����\�G���
)�w!�a�uf`��E�z@�xR��0�m��u��zh$�%�@4k���a��O�	�v�����٩��\; /�sd�f���ܸ�`�����wj�NBqm@�P�8��r<Q��=�l{N1l�����C��f�o\�" ��J F�j찠]�#��`��B���r��N��m&�8cy<�=3^<��UrZ�z��1�t�ѕ��-�>��ځ�j�n��0�\cDd&8ΉsR��A<�7UvyA/{�ݨDQ��؀!9�͡q��#ڛ�)����|��1��ګ"���p�w�χ�����n�}^�Jg��ZD	�: � ��~�Njs��o���D���9t��
�O\	�o��{��o8�(wL(��6��m�9u(Ye	�2�< ��∓]����ա�ͱg�߿zR�țw���z�zÉ�F\?�*��"t�P!J�Э��ǞPlE��±e7͚�J��&�8#V��^���l=�m��O�͎iq}@|��Q��T^*�A��j�������X����>C{��ŷ�ʿ|�� rV����@�萉��0
Q�$V/�����ޘ��#�x�?�sp�V�h��{5�a��i�G�f�O�>KPT��x� �e�ؠ��4}����9V �6��1��f���Ly.� �|9�9�u�[V��F�9$�NZ)�@�	��� ����5�,�h�<�:lQ�<������p�%�ee(�ީ�6��qsS��9V�8��; ?^�ؕ��|s�V�i�Wִ8"(��Sz�����Tѥ��g�}^"�B��&�$��I
 ,�ױ�8�czL���������5W��'��"1u����6]����r.�Q��<l��D�U�
B;ȸ�}fWb�e35�Ϣ�F���<��7��iqV)[g�B�}����e΅�#B,�<�u�?AF���m�ǝؤ� u�U�QI�+S��r��K�^��9{�l�usM����yqd�(Y�[賲ϻ^+��PB���^	D~�6�M�ϴ���D�,8�b�2 K8J�8
�<DT�Es��jɬo;"���o{�~~{���(�wO�$�x�PTU"�Y�X[e��J-b�J��>@�*ƈj�q�Z�2�
y`�T����u^8bu��Tc���ӟ�_�� ���g��+�`��˦�W<dY����X�[�׊��G�{�,D�.+�%��Ս��^�U����#��w\�,C�ܮ�w��i���������Z<q�'˿�qpF���D�j/)�HJ�r���QZ%83�����+�H��m���B��3����T�e�z��R�30�~��V��y�S'��갴ѢZ$��ƙlL�|�X�f��mV������U5y5HL�@W�~R�:7�GC���H����5�m5@��E	��ձH�*���+XNAȀqcM�<�e���<�9s�A��ŀu>t��,l�`L�Y���k���w��h�T �V1r��-��Yp���u7�m�WmH��w�
�E&d�Z�m���m�_h���b��:���lg�
���X�D��
����+�:R�Rܫm��a�m��X�� j��x���o�'�~(}��!�=�V{���Q�����>s�qW��Ύ��"�L�Țq���3y�~Bq9�<M�T��fcB�Z1�b�  ���6���<�&B铉��BR�_���8���r������v�`l�͢�fKr�7`��u��Q�UrE�ϼmf�*�#���*�:�
�ž
"jT�!�(}γ(�B�b��B,!X�3��e%��#�^�x5��@D	�\�"�4)��?��$W|���q�v v�g�b��2�����!��XPVJ��l=Aa�ne��e<+Y�3�`�M��*�Ȫ��B+��ԑ�S�x�PTU"(갚���6/G\��:Ð���BE,�IU)�E@� �#�{�x�) ��fa�����(ЧgRs+9s��ëDFB�qV�E�g�z��d��� ��B�� vSY)� �uq�,.���C1� J�,��,5����\_;ڒw	��\!^	m�8��8���yi���XG%e5�����,�ߞ��w��-�w�jn���/��͹S>�y}3#&�>�f-=�\��;~wN~��6�Ⓐ����P2Ur�s~L�D��vQV���
����p��`|4��h#*��{V1��@�q��[�,����b��3-��(�.�,.�b�Es�	ťl��(Ѓ%�\��Q�h��A�;e�ბ'=�dgфd��uh�g��SRZ�:�F���mu��P϶p.��M�ÓlI(v�D��F*�)�<��DY%���G�D�-t'=�(FC$.'��:U�d��z�ሳ����i&���f�,�3��ѨY����Z�#%W�V�#l3)�0D>~P�C�3-���;�ד>� ��?�TG~Y]����Wp3���"%�2�$�E�B������4��3)�Ko��m�@��e|���kR ��Q�O�H� ���)�)c��jda9�32�����W�T�:�e�}jQ�� ��c �\���U<	�h�D(���\1&�:�v1��A1���/��!y��rZ��� K��@���P���>ը���L!��x��f��E�K�!�֯��a�Ȗ���Greg�"R5�C���#C�j\�(�soT!Y¬�FR��u�r���X��]'Xg.���ZtQ��$z���ٱ�Ӈ�u��8
�~j
�@�Vܑ�i�U5�quy����P�-$����b��0���3И4��Q�Y�8��w�n�T���IҸ󬉅�
�5����o���U<j��xaP�c�o+�9�m��e�kV*�ؾ�URNy�x�Lj|��f�kE9O��'Q7�9�yuY����"fȨ�~;��y�J�o�v_�l3�`Q�����	/ �X���*�<�Jܜ[5�L|Q�cm��x�4�X�i�9F~ݔ�||�5�h��uӍ����<Z�ȩ��F��D�%��Zh�	�d	D]Z��t���#�\'�1�Y 2�р#od�7S��sAj1�zH.�~qLlQL�0���Q��͘bP%Zc%�P��#w1��h���"-D&v�����/�I	*FL�X$5�Ⱦ�8�B�F�)f�8m������"-2�1)�E��(_����v��E5���-c��S�CN-V$*�C������O$'��sO��}Ҡ� RB��|�uǈL�\j�I�R�GN`ꡌq����L�;�AU�h�U&���1����2Y8Kq�6�)�@���b�L�N.,��d}��[>��\"��t�\�Ҭ���[-�.�L~������*Q��פ	����fpY�8b/���x�9g�BWzւ�m��������0֘�m(:�!�ò�7mW��zTmt}�u���y�h=e9G7��5��(�8
��2�Ϣ{�h�Cf�NŐ�q��ψ*ƨCR���31 �b���v+�:��A�un?��)��B[�`�	�N�>[���Ax�����{��jP�6�n�Y��Z��f��v�uцe��Q[g���:��q������˄m��OiV���L_c�i���\}^�rK`�U.ML�����`�����]<d���
�r�ɈI�B�Di�4)��K��1��r�$ʀ$	�$��fqE�`Ym�F!�X��p4��}?-AtGC�[SaΪ�^�M��D�Ub_>�_�#��q�f6��aF	�a����dc�K��:�(_����LK]�i��P��s#�K��?�/��g_��
>jS������\�2�֐`�r��W't$Z��c����C12�7Y��z�$�]�j9������)he��Qr�.��K���z�Y�g�ѧ��7d�wP�T��c3s~�d�i#,� 3Z�cb�����t�[���w��K-�i�,���zu����tA�t�����~�'�{U"DU"c�ow��Jl�����)R �H�~R,t� ���1*r������y���u&�RKv�L4�%U�x��>H�U�6�B+O�N�)�YI�C%���>4����*��n�lƠ��"}b��[elS��FG!9�G��N�B���	����pH�Q���z�1��ɴ�j�u@q�J$u���p��D�mVUa����XR�B$o��8��%����#�[������qΆ�b�%w/�^�.�:��⧏�B�|*�Y�3V%J�1���"��h�X���0d��3���*���$�"��Q��r�pq0b�u�q�:f�-�����<�WG��UU�d7ΰ�u�W�i2�)�wu?g����Է����<��0�d��Q�Rl4d�����:�(C�jm��-U\1����3�F�:��X�#�v8�H�M������$�}���KknH��R��<�n��a��Id�ePN~��Eb,I�\ ����>���lqHz�ȹ.^��@%�2R�>�.����Ⱦ����*�Yi�EV�I�ϋ4�6[v�R���%�$M��q�E������N5��FE!-�Z�I����UE#����h���8�=*�����!K�$Z\�Y����:�$2X�ŕ����i�[)+G�N��H�\j`ǐm������q�T��[�,g�J�T����O�[@|��2��hf���E	�i�A�gy�(Eq�0�:L�O���d�9�������B>���+�Б�
ES%��!��:��.d�C�����c���B�ǒz�a�Hz���6�s�|�9��}
�g��x�}1�@z؈��g�C�t��V���@(�D
��V�L��,��C���� }p��o��ȲOw6�9%������.���W(�U"s ��t�6�����w���B��e��q�s{�j�����z4m�_��B�D
� ���e�t�Z��a���ԫ�|�ĵ��?���c��`�]@|�s��'I�j�;���Ȉ+j��	"j����6����9�B����A�}�a�q�2G����8�¼l�j�*�fK�a���9����>S������1r�Z�c����9�+�l3��M��@tdO��0��|>�xfz���e�L.Ũ��s�����ǐxb�?�ЏhWGE�Jl*�vX�[��U��?��V�'�3���)Y�����@��r½���A�ef5[�%p8&'{�R5�pT�r#�ro<����D):��� !�z�h����O1,�L��  9/3+٢��_�$�c�fZIG��5,��ב�xYJ,�
r�����>w�D��k9�2��G����4`d(2�6;@@�dKt��ӗ򉖸���voǬ�a[�sƐq$	���F]��v+/T\�R��!n�#'�b��AT{�d��1@���;�5��3�Cv���T���X:���ԣF"7�6�T�i�4H�!qő�Z��Pa�N(j*�R%�wI;���w@��AI�g�X���*1R�,�\@,@��Oד,�Զ��E#�2�y�knL��>�j�����Z�Š���w5�<	�~�y��o���2�#�읍\�0f�5 :&%����x�aQz    IDAT��3 H��~0�T$��w��N+�3�;ŵ}���#�2��/�8�(t����X@ƪK��2�K[�]&Zh8+���������E�B4g)ry��\
I�.)�tY�"P4Ub��ƻ�Ubہtg�,oWd��@�:&_9V��
�G�N��5�œ��Zd��~]Ο�ۡ�r>;��:W�d�L{��oF�(~��C*ʿ/r	�CI		��|'؝}��ǝ�n�%2eN�$�{<Ao�ܳ^��v۾G(Z*�] ������=�|��{�sY�?š�NR��ן�&���Ԕt`�[������M�`�G�6FR<ȴ�1!��ɚf &�ۛg�;�����r�e/\rZF�6��X�Pa���p&W�H�}��Q��5�i$��\k;�Qr�*�TUH�ޣ�>���-�VjE����2�m#5�pD�W��MH:���H晛��/��e�4��m��Aї��q��͝> ��9V�5u���eLd̵��|���a3D������*l�����P�k�ղ��U��U��Y��?DC��Kϯ��t� �^)M�N��'Rt���6F�o\�Ѕ�ڐ�5���z����[���o�?_�Ad��6�9��X�c���_msn���b��(����O�L?��튑��;^a1���ۻG��$����[���˜�f�\|��?ysUw��/��]�k��rƞN`�o�3�˔t0��6Q=�m�-����%�c��خ��^�@��'.b��5A��v�����آ�j>�:�W{]b�g��{��蘞{�,w��I�TZ��;"24D÷g�{����l��q���g�KZջ�1�˓��η:�Oi��Q���<����h�?�N�P��K�Q�l�>g˖-�(.�_�ݾ���<��+��xR�b�_�j&�.�xT`|������w�cڗ'1�1�η:�OI�|2�$�28rKl�h�ۿ%z���x��mP<.��㘳n�'*����{��o�}��i<�cz�m�-�n~�n���d��M����Ku�x��u7��@c^[�U�{G�(��W��{M��3� �DT���mY��� ��������I=װa
K(���t����!��L�����O��=,���7
˶�����[������瞗����_��L������д4���L}����w9��c�,���X-����������_h?�|���������>~G���eW��e��b�u/1�Ͽ�5?/�/��?DcZ8�SQ>�;.:~
�Xm�>��1�P���$����nE�iWE�qX�	�7��m����A�C��U�o��h+訸����!���+;-\�b˗�-iY)q���50n���>�HG�@Y?��uG	��B���ю�[�]t6��"XK
EL��Oև�g��0��w���.���U<��X�}f��r�\b'�y�׈gi��h��9�m���{9j��D������?�V��:�&ƀز�Q��dk��x�7����_-Zz�;�G-Ǝ.G+�$F]���т�O���*n�m¸�V �g��ϐ1U�K���:�����x��m�,4z,�q����i�Z���Z`k���ʔb��6���U�n������u�u8[�}Q/CEY��0V��IA]���c[��Z�,tOO������>���_䕀����m��@bPǍ�`�0�[�V�l�DlՂ�<�UV���J�8'�y�BI��46∡�}D�8lW.��t���^`N΁�_g���H���0)�~�ua%q/c�,݋n1(�jQ���jt�~���{��G�柱���F�Bǔ��F���R���a�m�w t�q�,Z��*����dݿdo��Қ��JQ���1CUU����v0���'$}�QR���4.rgf@�K5��<�<�@ȹ=v9D��o�a>�bl���;cਬ Ӳ�Qr��*��c��Փ0��gr�C5��D9�X=��"����Ѧ����>$�
JdɈM ���Sn�z��:E=�"���ZC�R����Ъqq(jj�R-�/�+���G[,��X4��~|�]�2Dc�m��F���s����zC�2�jh���
���Dd>���PU��6�+O�V��j��-�]�ZĈ�(DY��J�jdo,�Gq�be�c����-W��,�� �"x���J�@Y=�@�P�8n��n�Z��v��.�(Jl;ƈ�ȟk~�o%^$+!�>)�b*G�%8
50z,�J��0۾W9�޽���{��q+j�!��b�W�U��"�8� Z�qfi�|-�~�N �����뾒�RI��F��x��з@�( n  �LZ�E�2�a��LʱD7]ж��3��)�`I�S`=jq^ԍ�_��Y�w/��⽉Z�ۓ,n;�-ɱ.(ptS�b��Q�5 ��D�gD��/��a
YOQ "*�X��Κ\4h���³�)�`DE?�[h�N0~��n�$x/
S-j�DUFck[Ո-~G�%�e�@h�����@�ceU�d�G��:�5��rEx�P��{�.m�����`d?OM�ȀlJ�0�9�P�������~׀̳�h���B�=6�#�˅U穎�ӭ9��@�q6" H)�(+D�m�I+��*1`/8�	�Sb$����>��g5�ܩ���=Ss����A-�H>��Fq�Jѥ�cdN�n����� %���DM��+�(�Q>U����3� 1[��N�!"o�@Di*d�;{#D_W��#��C͘bD-�t��hr����'6��вR�0�,�{l��80j���jp�h��kI��@��wvMH�qD��{o��ٿ�u^�D����8�U��bn#Ƹ�������a1N�3��
��ݴ�J�E�b�K5������P�8��! D^1������̸�j㉁�$O�=j,�h��`�Z��n�9���Z�9�R�i
���j�h9�>e��h���<ۮ¯��xbd�u�}�(\)�?RV���n�]��ќZD#�h�ET!���p��0J ����j��M�*?��]�bY��4 j�QR���D���4�1�|�#��R��Q��D� �ˤ����`��Ӿآ�a�6���E�ԡ$�7��ϊ-�h����m�v�D����9,� c���Y��
����U"Z�}��=	���#���-�q&����S���Xwjm@A����[��u(��R�hQ���eT�Ȓ�]�kQ��U�՞R� ��+�n�G�E4��G-*��h�m�SĐj��e { �)#ATFG>v8���8�B�BC(Ѣ�D�	���ϼs���?��c�bI2N����jQ�ӨjBS��so�EU�� ���0k�����ϵ�%%���FQ!�69h�[U"��J<Q�e ���/�9��T��] {�\1:Ԣ3+m�h-���|`�T#�@��ё���'���_*����URe���y<�o�G�D���	��ZĽ(���Hy�6:[�{��3��
FDE5"l�'e��g��`�C�*+v�T> AT�R�'ӆ�M�Po�Lb�]�W9�ꔢ�Ù>�1�ȱ�N��_��b��6�ZL���d˜��rT����A�� ����B�0�� �J�R�ri���wH`Q/ű���ue���>�U�N�Z����?�7�B�̼�w=�(X/w�T����b��ˬϹ��C��aDO�C�D`��������w��:!H� �z>�l�8n�7A���py������	/���Y��FI52�z�E�<��Oȧ��H�N	Rp��R�`Yh�{���@�kB���F����F)�������ǨE�H����d/-�,���y�3��@!�,�-�2�A 
�Q{��V�F�1��$z�b�Z�1J-��dC�W*_���D�:�l�QR��]iK�J{l�B�T���]��6޼������-��"sm�m�8G�e������#�I�F�N�v0j�,���5����-V��R��XR?}@��w�u�o�~�l'YR).�A��ҡJ{)��b��W��'/����-@:4`XG�E��C��x"
�ڀȚMW��i�v�Ўb������T��jQ�1���b�7�`��]�F���g�+؈;��fyh�����%�J��ܯ��� q:}��yt�C���,�;8���P�3.�G�E-u����`t�i��{h�6�����!8�)�z�T���:�J�|@��U�T�6 �#�C�,�ﳁ�^�͝`c��J�� �4y�0��F��(i@	x.���O|W�z�T#�a�%S�H� QW�����Dg�6�U:��V��Z���a�Z�@3�,�Q�(�h�h(DK5�ʑ��G"���[d��[M�NrV��%�����B_tmvF\�/�˱DO ����RJ�c���%l�SԬ3��F��5�h R�bc嶼شβ"䁇C#ȱ�)Z����)���E1��F�v�y���RT�.��gV5B�ZF��F�EU�訛�­.q_l�Zma�l|����v�zT�Fr�ct5�RBI���SW�p�o�j5ɒ���m����\�m}��vD��S��@אUn�耣
H�>w�S�ezU#�
���7G����*,δƸ�w.$c��Rj�/��}��u31E�<�ѓ�6c�@�R2�����>ZГ���5@���6���aT�K%�o��d��K-zJuP���|3:��M�8b� J\5�h_�"�*D!,�%�C�Bc�H�3�r<�yr��� D�B�����\w����*��T�x�Q�0�z�+� #�`��芋��Q@��Pn�=
R����}���ޮ�>�l�GlR�>��� ��p�d�"��D��(L����x�*�1F4�����:DF.�i>v�`�澐z����0O� �p��ʴ� T�W���� ��߂�q6z�
kH��(O�iZ��(�E������M D�w;`hN�8�zb�:(�B�,F7�,��3���?J��F�:G�(?�Td�}�
x�*%�
Ҁ�B%��!;���.���X���V�:�$�v���⾒.,ё����K���`4B���T0���� ��A�*t�íy�!@�q�(D�&w4W�������5)�A��aդWC�"(�:m`,����fF;)=�P�_�.��m��A4@8D1�t, �S��yүQ�̊7./6L(�@-��D���F��/2q��P��j�Ox�g�!{�4��h�.*zUU��bi���lzO��Q�h�H��MN���ˢ�!w�PlT�Ƙ�\��J�4�轁=aܪQ��Z7U�����g�Pɒ[ ��m���^�* ˛����P�`�D!�Rq�Jq�j1�ti��h��bT��<��h�3b��Yߑ�3գ�i����#$�	��O��w r�5����X���#%:qme��/:�h�iV5
�d�+����/L�=Q7�ňM�|0�*�j�0���]���d� ��*1Ǆ�~�X�Eϴ�J6��E	������1�IS-��2#8��*#]��F��e�w��k�drݻ\ӵ\���Wǒ?��/����|x{ut��( ��怜-ۼ�������mFt|��f��א��7+�o..$�mS- @���}�݂`w��܌H�َnK��X(?a��~��¯E1Nn�w�4t?�#$�%@k��r�P$"q�$D "D������/H��e8�8;-�|��W�h�K� ��(
� D���;Ҕm�Xl��f?x�B(w:����0�G��%*/qBҽ�$Ļ��4�z�y�{x��HGM%"�ˢ��!*��Rb'�>���7!�������,�"���W�{���������)�M���^V3�^H���<����>*"р���|�p�]�k�w������o��1\�y��	-�b��_T���trP��������� d����ek���6s�=�d�,uV�刎U>U���:.�Vg����� B��L��c�=p�_$(KgS��o܆O߆m�4T����ri�e��a�g��|⌻m8�\Y���X�b��E�i/D���1�1��	C�:����~�|s�!  |x�����h����R����>+vz��d�8W��z�~�jQ���*2j�k٨��&=@ :l�H�Yd��rI	�J@(�o���i�b��Q)�,�6Z��M�����3�G+��f����R}��U�e��P8?�������>�}.�w����:�gg�K��BE8��L�r�xj_'9�^J���[0���M�yv>U˸��}�,aC�Z�/IÀP4,7:��q����1�pھ��  >^���� ό�N�|T6t%9�֚b/�ԢxWu�F�R��P>I��][�b��X�(+����KV1jz�J�l�8��`��8�H������We���c�yjG��0<5�p|�J��8�O	ŵ��`y_<�YG���	�2yE�#����F1F��@X��U|����&Y �8���S}�x����� ��O������䲒Ku��+���V�x��h�w�����j���d�3�ʇ��s��J��P^_�[_[{����  �y��a����{����y����z#�g�=6�;���u�x��Ϳ�Փ�wW��r�ZS�^�!E	��.��՛�~� x��2��Z�Q�߿��T��z���[�T�gE������E���P0^�>8� yh� �?K5߽|\�A��?����|x;��>�j��Ąb����ȵ�QT�"�8�ԡL�ޓ���J���� �G[c�����fT���t��(�ULQEG�/�≛�#�]�}������/U�4���d��*!�ŵ%)He�n4b�+B<Nk|��t:�f��d�ǷW��7.��_ܸ��n��霔�[12�Do\�[�()ƋcԢu�����*rO�9`������V=�ܸ�`�����w�V�g	�=	e$����g`;�Ip4���n���(6�f��o_<'�GQٷ(F��`A��n�ߋ�K(M@��&(t��v ^=��O�(p���4@�_��ѡW��T���G1
�d�y��I1�h�J]3�=Z�`t�� ��?�4��&��>���ᯂ
�ա_�@ԟ_=���݄�y���@k�:S�|p0�
͂c�I��3�����@pB��j�� �a���_-��o�$��^u�vd��?F�;6Z�7��'�7�uB�G���Ld����_��8	(�u7�����ō�j�n��m�
T� NKx��:���6�[`�MoM=b-a�qgG\�`��nC0�T����y@-"\���8ei*�%�f�+s��z]�b�^v���j��/J\QW�{-h:n7
�q��ø:�F���:�������g �ք���^��uv���}�Ճ�ٯ�<�K�0�;b���8s�2Ǵ�Gh�w�,oF��,5�&���4��eg��{��}��y��l�����(�X8{��[����#��p����_�<: �RlT�����t�� ���?t\������6e�}���/e�����>Ct�ָG���6'O�z���ؾT�g��p�n�Ku��51�8��(:�r��n�H0��o�<Z���,�Z�S��eL��MKu`;��$�X���T{c�� d�����S�67xܠ�$S�l@(���0�բ�GJ8�<�ʧ`�S).�K�X)G!�ȪDV1N�L���Q��`g��»���8l�
�vU8
��-7��a�P�']�:�8Yv���Ϳgӵ��N������0f���y4��xn0L(.F����V��(0F�'���𧕃��.6�B�Q�mp<WnZ��Y����5�x�>b7c�
��j'ϯ��<�f��}�n�H�;k�4T �9�� ��X��	�F&Q����[{��v�ֽ��⑩Ky��_W}|� �6��,F�(�w�[>�$�W`4l�ŷ��s�� �Y�a�Ya�U����P\�O��� �>��E��y?�aE  IDATJE�3����ma�# �B�BM�&��2��i����!Ǧu��������b������WO��x���U�o�y��p�8b�0��9�E�;`�b��i����;��[�J��]U5 ��"{`8�	Ä�Q��+􎂑�����MN��[ۘU�P���,a����l��;`a�˲�J�]%;}� ��e��&U&��!rӇ��箓R)�b�=`��D3�ͻ�W��ú��^5 ��
;ms�0��`TK�y�l�`�|�q�FG��'�� �Wz`�̧+0L��������1T=^��Ӱ*}��q�{`d��(A7��,��Ǆa*�T�V&���7w���� �q��k�t��Wf�c�0��`l��l`|��ɂ;һ8�=����k�=�8a�P<s0jc0�0��\U�`|�J!�	�f���CǶm�9?��0�'kS\��c���c,�r�qƢlgG�{� ��a�Z��`Z�Ē}�٫�	�sՓ,�z�12���/n.O�N����p�,���T&z�� �Ǆa��l}	-�\�Km����m���6\��h�]���C��_&�ن�Q�d©>��"��^?3��r�``���^�,l� �:[r0,^�ɓ��g����m����Y�x=��~��Ӎ�b���U�lr~ tC�=�RL&�5���$g �.�F�_�W��j�c��V9A�i���#�z��`��<0E���>�y�}s�����؀�Q T��a�0��m�`�Lg��p�&Mר8���ׄhm����	�l���j������N���{A������\� ��0L(f�ao��Z�k
V�9�>�}���FpP�! Z���=Ӄ&�ٜ������,�4��Q�#� 5/�� T h��)�	�	b�������D5.ME��=����nH��0a�P�6���R���N�c���������;�n �&��e���W���6�ȴ����u��s�
|�;_�\�� ,!���a*�l{R�_ܸ|��N�l�.��l���cz�A� �Zؚ%N&����߸�~)�g󸌴��}9z�-�� �	�l��Ws0�b���1&����|�C�m�~~��A�Y��b��������$Z��߿�%%��q���� �M�%�َ��������n�/!��86v�W |�T	��b�#㮆1��}���V���	�lG�v`�dY���m��l�^	�_��b�E���J��4B%J�o�ld�_0[B1[����z�'k�_0[B1�8Q����T�N�e7�c=p�?�MDQ��˖J1��+�֖ ̖J1�Y+�`�l�S1&��eK(&�ٲ%�	�l����ٲ%V��b�/[B1�ق1�-[B�l�� ̖-�x�`̖-[�}�� [�l��ٲe˖P̖-[��b�lٲ%�e˖-��-[�l	�lٲeK(f˖-[B1[�l��ٲe˖P̖-[��b�lٲ%�e˖-��-[�l	�lٲeK(f˖-[B1[�l��ٲe˖P̖-[�Sk�K
% �<_    IEND�B`�w/ӌ_p,2k�u��-   �'��Q�F   res://dodec2.glb�*��4�5k   res://dodec.glbN9�7+z}   res://dodec.tscndn�N+��~   res://icon.pngS����d�T(���nECFG      application/config/name         Polygrapher    application/run/main_scene         res://dodec.tscn   application/config/features   "         4.1    Mobile     application/config/icon         res://icon.png  #   rendering/renderer/rendering_method         mobile  �����,��