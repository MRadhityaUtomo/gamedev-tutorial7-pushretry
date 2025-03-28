TUTORIAL - 7 -- 3D Basics
Muhammad Radhitya Utomo 2206830744
Game Dev.

Post tutorial added
1. New Level 2 using gridmaps and a 3D tilemap I had from an old project. I used free textures from the blender store, blender, and Laighter to make normal maps.
    - Added enviornment lighting and fog
    - Added Items such as a key, area to escape, interactable cube for inventory experimentation.
    - Added pickupable key needed to escape.
    
2. Added Player mechanics
    - Flashlight using spotlight3d emitting from the player unto the camera's direction. Press Lmouse to toggle.
    - Added Sprint to speed up movement, added by changing the walking speed to the sprint speed when pressing Lshift.
    - Added Crouch by pressing Lctrl, toggle.

3. Created props
    - Key 1 using csgcombiner.
    - Key 2 same but having area3d and collision for player pickup.
    - TestCube object to test pickup up items by pressing E.

4. Interaction Area
    - walk over items to pickup, key item has area3d that handles logic.
    - press to interact and pickup cube, placed an area3d in front of player character and camera as a pickup radius or pseudo raycast3D.

Free references used:
https://www.youtube.com/watch?v=hdBcn2rO6c8
https://www.youtube.com/watch?v=XLjCmdy8jdw
https://youtu.be/VjuyfBaryu8?si=vHWzE0XvtzbnyIQQ