#####################################################################
#
# CSCB58 Fall 2020 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Brandon Lo, 1006302831
#
# Bitmap Display Configuration:
# - Unit width in pixels: 16					     
# - Unit height in pixels: 16
# - Display width in pixels: 512
# - Display height in pixels: 512
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1/2/3/4/5 (choose the one the applies)
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)
# 1. (fill in the feature, if any)
# 2. (fill in the feature, if any)
# 3. (fill in the feature, if any)
# ... (add more if necessary)
#
# Link to video demonstration for final submission:
# - (insert YouTube / MyMedia / other URL here).
#
# Any additional information that the TA needs to know:
# - (write here, if any)
#
#####################################################################

.data
displayAddress:	.word 0x10008000
displayUnits: .word 32
backgroundColour: .word 0x008080		# teal
platformColour: .word 0xC19A6B			# brown
textColour: .word 0xffff00			# yellow
playerColour: .word 0x00ff00			# green
jumpHeight: .word 16
leftKey: .word 0x6A
rightKey: .word 0x6B
restartKey: .word 0x73
platformSize: .word 12
platformA: .space 8
platformB: .space 8
platformC: .space 8
sleepDelay: .word 30

.globl main
.text

main:

initializePlatforms:
	la $t0, platformA			# $t0 = A
	li $t1, 10
	sw $t1, 0($t0)				# A.x = 10
	li $t1, 31
	sw $t1, 4($t0)				# A.y = 31
	
	la $t0, platformB			# $t0 = B
	li $t1, 21
	sw $t1, 4($t0)				# B.y = 21
	addi $sp, $sp, -4			# move stack pointer down
	sw $t0, 0($sp)				# push B onto stack
	jal randomizeX				# randomize B.x
	
	la $t0, platformC			# $t0 = C
	li $t1, 11
	sw $t1, 4($t0)				# C.y = 11
	addi $sp, $sp, -4			# move stack pointer down
	sw $t0, 0($sp)				# push C onto stack
	jal randomizeX				# randomize C.x

initializePlayer:
	li $s0, 15				# player.x
	li $s1, 24				# player.y
	li $s2, 1				# direction (upwards = -1, downwards = 1)
	li $s3, 0				# jumpCounter

drawDisplay:
	jal drawBackground			# draw background
	jal drawPlayer				# draw player
	
checkScrollScreen:
	bge $s1, 14, endScrollScreenCheck
	beqz $s3, endScrollScreenCheck
	
redrawPlatforms:
	la $t0, platformA
	la $t1, platformB
	la $t2, platformC
	
	lw $t3, 0($t1)
	lw $t4, 4($t1)
	
	sw $t3, 0($t0)
	sw $t4, 4($t0)
	
	lw $t3, 0($t2)
	lw $t4, 4($t2)
	
	sw $t3, 0($t1)
	sw $t4, 4($t1)
	
	li $t3, 1
	sw $t3, 4($t2)
	
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal randomizeX

scrollPlatformsInit:
	li $s7, 0
	
scrollPlatforms:
	bge $s7, 10, scrollPlatformsEnd
	
	jal drawBackground
	jal drawPlayer
	jal drawPlatforms
	
	la $t0, platformA
	la $t1, platformB
	la $t2, platformC
	
	lw $t4, 4($t0)
	lw $t5, 4($t1)
	lw $t6, 4($t2)
	
	addi $t4, $t4, 1
	sw $t4, 4($t0)
	
	addi $t5, $t5, 1
	sw $t5, 4($t1)
	
	addi $t6, $t6, 1
	sw $t6, 4($t2)
	
	addi $s7, $s7, 1
	
	jal sleep
	
	j scrollPlatforms
	
scrollPlatformsEnd:
	li $s2, 1
	li $s3, 0

endScrollScreenCheck:

drawPlatformsOnScreen:
	jal drawPlatforms

incrementPlayer:
	add $s1, $s1, $s2

checkDirection:
	beq $s2, 1, endDirectionCheck		# if (direction is downwards) then skip condition
	addi $s3, $s3, 1			# jump counter++
	lw $t0, jumpHeight			# $t0 = jumpHeight
	blt $s3, $t0, endDirectionCheck		# if (jumpCounter < jumpHeight) then skip condition
	li $s2, 1				# set player direction downwards
	li $s3, 0				# jumpCounter = 0

endDirectionCheck:

checkKeypress:
	lw $t0, 0xffff0000			# obtain value to check if input is detected
	bne $t0, 1, endCheckKeypress		# if (no input detected) then draw

getInput:
	lw $t0, 0xffff0004 			# obtain input stored in next byte
	
checkLeft:
	lw $t1, leftKey				# $t1 = leftKey
	bne $t0, $t1, checkRight		# if (input != leftKey) then checkRight

moveLeft:
	addi $s0, $s0, -1			# move 1 unit left
	lw $t1, displayUnits			# load displayUnits
	bge $s0, $t1, wrapLeft			# if (x >= displayUnits) then wrapLeft
	bltz $s0, wrapRight			# if (x < 0) then wrapRight
	j endCheckKeypress			# jump to draw

checkRight:
	lw $t1, rightKey			# $t1 = rightKey
	bne $t0, $t1, endCheckKeypress		# if (input != rightKey) then draw

moveRight:
	addi $s0, $s0, 1			# move 1 unit right
	lw $t1, displayUnits			# load displayUnits
	bge $s0, $t1, wrapLeft			# if (x >= displayUnits) then wrapLeft
	bltz $s0, wrapRight			# if (x < 0) then wrapRight
	j endCheckKeypress			# jump to draw
	
wrapLeft:
	li $s0, 0				# set player's x-coordinate to 0
	j endCheckKeypress			# jump to draw

wrapRight:
	addi $t1, $t1, -1			# $t1 = displayUnits - 1
	move $s0, $t1				# set player's x-coordinate to displayUnits - 1
	j endCheckKeypress			# jump to draw

endCheckKeypress:

checkCollision:
	beq $s2, -1, endCollisionCheck		# if (direction is upwards) then skip condition
	la $t0, platformA			# $t0 = platformA
	la $t1, platformB			# $t1 = platformB
	la $t2, platformC			# $t2 = platformC
	
checkPlatformA:
	lw $t3, 0($t0)				# $t3 = A.x (min-x)
	lw $t4, platformSize			# $t4 = platformSize
	add $t4, $t3, $t4			# $t4 = A.x + platformSize (max-x)
	lw $t5, 4($t0)				# $t5 = A.y
	addi $t5, $t5, -1			# $t5 = A.y - 2
	blt $s0, $t3, checkPlatformB		# if (player.x < A.x) then checkPlatformB
	bge $s0, $t4, checkPlatformB		# if (player.x >= A.x + platformSize) then checkPlatformB
	bne $s1, $t5, checkPlatformB		# if (player.y != A.y - 1) then checkPlatformB
	li $s2, -1				# change player direction to go upwards

checkPlatformB:
	lw $t3, 0($t1)				# $t3 = B.x (min-x)
	lw $t4, platformSize			# $t4 = platformSize
	add $t4, $t3, $t4			# $t4 = B.x + platformSize (max-x)
	lw $t5, 4($t1)				# $t5 = B.y
	addi $t5, $t5, -1			# $t5 = B.y - 2
	blt $s0, $t3, checkPlatformC		# if (player.x < B.x) then checkPlatformC
	bge $s0, $t4, checkPlatformC		# if (player.x >= B.x + platformSize) then checkPlatformC
	bne $s1, $t5, checkPlatformC		# if (player.y != B.y - 1) then checkPlatformC
	li $s2, -1				# change player direction to go upwards

checkPlatformC:
	lw $t3, 0($t2)				# $t3 = C.x (min-x)
	lw $t4, platformSize			# $t4 = platformSize
	add $t4, $t3, $t4			# $t4 = C.x + platformSize (max-x)
	lw $t5, 4($t2)				# $t5 = C.y
	addi $t5, $t5, -1			# $t5 = C.y - 2
	blt $s0, $t3, endCollisionCheck		# if (player.x < C.x) then endCollisionCheck
	bge $s0, $t4, endCollisionCheck		# if (player.x >= C.x + platformSize) then endCollisionCheck
	bne $s1, $t5, endCollisionCheck		# if (player.y != C.y - 1) then endCollisionCheck
	li $s2, -1				# change player direction to go upwards

endCollisionCheck:

idle:
	jal sleep
	
checkIfPlayerLost:
	lw $t0, displayUnits
	bge $s1, $t0, end

loopToDraw:
	j drawDisplay				# loop

end:
	jal drawGameOver			# draw game over screen

checkGameEndKeypress:
	lw $t0, 0xffff0000			# obtain value to check if input is detected
	bne $t0, 1, checkGameEndKeypress	# if (no input detected) then keep checking for a keypress

getGameEndInput:
	lw $t0, 0xffff0004 			# obtain input stored in next byte

checkGameEndRestart:
	lw $t1, restartKey			# $t1 = restartKey
	bne $t0, $t1, checkGameEndKeypress	# if (input != restartKey) then keep checking for a keypress
	j initializePlatforms

# sleep -> pause
sleep:
	lw $t0, sleepDelay
	li $v0, 32
	move $a0, $t0
	syscall					# sleep
	
	jr $ra

# randomizeX(platform) -> randomizes the x-coordinate of a platform
randomizeX:
	lw $t0, 0($sp)				# $t0 = platformAddress
	addi $sp, $sp, 4
	lw $t1, displayUnits			# $t1 = displayUnits
	lw $t2, platformSize			# $t2 = platformSize
	sub $t3, $t1, $t2			# $t3 = displayUnits - platformSize (max x-value)
	
	li $v0, 42				# generates a random integer within a given range
	li $a0, 0				# using only one random number generator
	move $a1, $t3				# random integer ranges from 0 to displayUnits - platformSize (exclusive)
	syscall
	sw $a0, 0($t0)				# stores random integer as x-coordinate of platform
	
	jr $ra					# return

# drawPlatforms -> draws all the platforms on the screen
drawPlatforms:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address

	la $t0, platformA			# $t0 = A
	addi $sp, $sp, -4			# move stack pointer down
	sw $t0, 0($sp)				# push A onto stack
	jal drawPlatform			# draw platformA
	
	la $t0, platformB			# $t0 = B
	addi $sp, $sp, -4			# move stack pointer down
	sw $t0, 0($sp)				# push B onto stack
	jal drawPlatform			# draw platformB
	
	la $t0, platformC			# $t0 = C
	addi $sp, $sp, -4			# move stack pointer down
	sw $t0, 0($sp)				# push C onto stack
	jal drawPlatform			# draw platformC
	
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
	jr $ra					# return

# drawPlayer -> draws the player on the bitmap display
drawPlayer:
	lw $t0, playerColour			# $t0 = playerColour
	lw $t1, displayAddress			# $t1 = displayAddress
	lw $t2, displayUnits			# $t2 = displayUnits
	
	# calculations for starting pixel
	mult $s1, $t2
	mflo $t3
	add $t3, $t3, $s0
	li $t4, 4
	mult $t3, $t4
	mflo $t3
	add $t3, $t3, $t1			# $t3 = displayAddress + (y * displayUnits + x) * 4
	
	sw $t0, 0($t3)				# draw pixel at unit
	
drawPlayerEnd:
	jr $ra

# drawPlatform(platform) -> draws the platform on the bitmap display
drawPlatform:
	lw $t0, platformColour			# $t0 = platformColour
	lw $t1, 0($sp)				# $t1 = platformAddress (pop from stack)
	addi $sp, $sp, 4			# move stack pointer up
	li $t2, 0				# $t2 = 0
	lw $t3, platformSize			# $t3 = platformSize
	lw $t4, 0($t1)				# $t4 = x
	lw $t5, 4($t1)				# $t5 = y
	lw $t6, displayAddress			# $t6 = displayAddress
	lw $t7, displayUnits			# $t7 = displayUnits
	
	# calculations for starting pixel
	mult $t5, $t7
	mflo $t8
	add $t8, $t8, $t4
	li $t9, 4
	mult $t8, $t9
	mflo $t4
	add $t4, $t4, $t6			# $t4 = displayAddress + (y * displayUnits + x) * 4
	
drawPlatformLoop:				# if (i < platformSize)
	bge $t2, $t3, drawPlatformEnd		# if (i >= platformSize) then exit loop
	sw $t0, 0($t4)				# draw pixel at unit
	addi $t4, $t4, 4			# unit++
	addi $t2, $t2, 1			# i++
	j drawPlatformLoop			# loop
	
drawPlatformEnd:
	jr $ra					# return
	
# drawBackground -> fills in every unit of the bitmap display with the colour blue
drawBackground:
	li $t0, 0				# $t0 = 0
	lw $t1, displayUnits			# $t1 = displayUnits
	lw $t2, displayAddress			# $t2 = displayAddress
	lw $t3, backgroundColour		# $t3 = backgroundColour
	mult $t1, $t1				# $t1 = lastUnit = displayUnits * displayUnits
	mflo $t1
	
drawBackgroundLoop:				# while (i < lastUnit)
	bge $t0, $t1, drawBackgroundEnd		# if (i >= lastUnit) then exit loop
	sw $t3, 0($t2)				# colour unit at displayAddress
	addi $t2, $t2, 4			# displayAddress++
	addi $t0, $t0, 1			# i++
	j drawBackgroundLoop			# loop
	
drawBackgroundEnd:
	jr $ra					# return

# drawGameOver -> draws the text game over on the screen
drawGameOver:
	lw $t0, displayAddress			# $t0 = displayAddress
	lw $t1, textColour 			# $t1 = textColour
	
	# $t2 = displayAddress + (y * displayUnits + x) * 4
	
	# DISPLAYING G
	# (7, 7)
	addi $t2, $t0, 924
	sw $t1, 0($t2)
	# (8, 7)
	addi $t2, $t0, 928
	sw $t1, 0($t2)
	# (9, 7)
	addi $t2, $t0, 932
	sw $t1, 0($t2)
	# (7, 8)
	addi $t2, $t0, 1052
	sw $t1, 0($t2)
	# (9, 8)
	addi $t2, $t0, 1060
	sw $t1, 0($t2)
	# (7, 9)
	addi $t2, $t0, 1180
	sw $t1, 0($t2)
	# (8, 9)
	addi $t2, $t0, 1184
	sw $t1, 0($t2)
	# (9, 9)
	addi $t2, $t0, 1188
	sw $t1, 0($t2)
	# (9, 10)
	addi $t2, $t0, 1316
	sw $t1, 0($t2)
	# (7, 11)
	addi $t2, $t0, 1436
	sw $t1, 0($t2)
	# (8, 11)
	addi $t2, $t0, 1440
	sw $t1, 0($t2)
	# (9, 11)
	addi $t2, $t0, 1444
	sw $t1, 0($t2)
	
	# DISPLAYING A
	# (11, 7)
	addi $t2, $t0, 940
	sw $t1, 0($t2)
	# (12, 7)
	addi $t2, $t0, 944
	sw $t1, 0($t2)
	# (13, 7)
	addi $t2, $t0, 948
	sw $t1, 0($t2)
	# (11, 8)
	addi $t2, $t0, 1068
	sw $t1, 0($t2)
	# (13, 8)
	addi $t2, $t0, 1076
	sw $t1, 0($t2)
	# (11, 9)
	addi $t2, $t0, 1196
	sw $t1, 0($t2)
	# (12, 9)
	addi $t2, $t0, 1200
	sw $t1, 0($t2)
	# (13, 9)
	addi $t2, $t0, 1204
	sw $t1, 0($t2)
	# (11, 10)
	addi $t2, $t0, 1324
	sw $t1, 0($t2)
	# (13, 10)
	addi $t2, $t0, 1332
	sw $t1, 0($t2)
	# (11, 11)
	addi $t2, $t0, 1452
	sw $t1, 0($t2)
	# (13, 11)
	addi $t2, $t0, 1460
	sw $t1, 0($t2)
	
	# DISPLAYING M
	# (15, 7)
	addi $t2, $t0, 956
	sw $t1, 0($t2)
	# (16, 7)
	addi $t2, $t0, 960
	sw $t1, 0($t2)
	# (18, 7)
	addi $t2, $t0, 968
	sw $t1, 0($t2)
	# (19, 7)
	addi $t2, $t0, 972
	sw $t1, 0($t2)
	# (15, 8)
	addi $t2, $t0, 1084
	sw $t1, 0($t2)
	# (17, 8)
	addi $t2, $t0, 1092
	sw $t1, 0($t2)
	# (19, 8)
	addi $t2, $t0, 1100
	sw $t1, 0($t2)
	# (15, 9)
	addi $t2, $t0, 1212
	sw $t1, 0($t2)
	# (19, 9)
	addi $t2, $t0, 1228
	sw $t1, 0($t2)
	# (15, 9)
	addi $t2, $t0, 1340
	sw $t1, 0($t2)
	# (19, 9)
	addi $t2, $t0, 1356
	sw $t1, 0($t2)
	# (15, 10)
	addi $t2, $t0, 1468
	sw $t1, 0($t2)
	# (19, 10)
	addi $t2, $t0, 1484
	sw $t1, 0($t2)
	
	# DISPLAYING M
	# (21, 7)
	addi $t2, $t0, 980
	sw $t1, 0($t2)
	# (22, 7)
	addi $t2, $t0, 984
	sw $t1, 0($t2)
	# (23, 7)
	addi $t2, $t0, 988
	sw $t1, 0($t2)
	# (24, 7)
	addi $t2, $t0, 992
	sw $t1, 0($t2)
	# (21, 8)
	addi $t2, $t0, 1108
	sw $t1, 0($t2)
	# (21, 9)
	addi $t2, $t0, 1236
	sw $t1, 0($t2)
	# (22, 9)
	addi $t2, $t0, 1240
	sw $t1, 0($t2)
	# (23, 9)
	addi $t2, $t0, 1244
	sw $t1, 0($t2)
	# (24, 9)
	addi $t2, $t0, 1248
	sw $t1, 0($t2)
	# (21, 10)
	addi $t2, $t0, 1364
	sw $t1, 0($t2)
	# (21, 10)
	addi $t2, $t0, 1492
	sw $t1, 0($t2)
	# (22, 10)
	addi $t2, $t0, 1496
	sw $t1, 0($t2)
	# (23, 10)
	addi $t2, $t0, 1500
	sw $t1, 0($t2)
	# (24, 10)
	addi $t2, $t0, 1504
	sw $t1, 0($t2)
	
	# DISPLAYING O
	# (7, 20)
	addi $t2, $t0, 2588
	sw $t1, 0($t2)
	# (8, 20)
	addi $t2, $t0, 2592
	sw $t1, 0($t2)
	# (9, 20)
	addi $t2, $t0, 2596
	sw $t1, 0($t2)
	# (7, 21)
	addi $t2, $t0, 2716
	sw $t1, 0($t2)
	# (9, 21)
	addi $t2, $t0, 2724
	sw $t1, 0($t2)
	# (7, 22)
	addi $t2, $t0, 2844
	sw $t1, 0($t2)
	# (9, 22)
	addi $t2, $t0, 2852
	sw $t1, 0($t2)
	# (7, 23)
	addi $t2, $t0, 2972
	sw $t1, 0($t2)
	# (9, 23)
	addi $t2, $t0, 2980
	sw $t1, 0($t2)
	# (7, 24)
	addi $t2, $t0, 3100
	sw $t1, 0($t2)
	# (8, 24)
	addi $t2, $t0, 3104
	sw $t1, 0($t2)
	# (9, 24)
	addi $t2, $t0, 3108
	sw $t1, 0($t2)
	
	# DISPLAYING V
	# (11, 20)
	addi $t2, $t0, 2604
	sw $t1, 0($t2)
	# (15, 20)
	addi $t2, $t0, 2620
	sw $t1, 0($t2)
	# (11, 21)
	addi $t2, $t0, 2732
	sw $t1, 0($t2)
	# (15, 21)
	addi $t2, $t0, 2748
	sw $t1, 0($t2)
	# (11, 22)
	addi $t2, $t0, 2860
	sw $t1, 0($t2)
	# (15, 22)
	addi $t2, $t0, 2876
	sw $t1, 0($t2)
	# (12, 23)
	addi $t2, $t0, 2992
	sw $t1, 0($t2)
	# (14, 23)
	addi $t2, $t0, 3000
	sw $t1, 0($t2)
	# (13, 24)
	addi $t2, $t0, 3124
	sw $t1, 0($t2)
	
	# DISPLAYING E
	# (17, 20)
	addi $t2, $t0, 2628
	sw $t1, 0($t2)
	# (18, 20)
	addi $t2, $t0, 2632
	sw $t1, 0($t2)
	# (19, 20)
	addi $t2, $t0, 2636
	sw $t1, 0($t2)
	# (17, 21)
	addi $t2, $t0, 2756
	sw $t1, 0($t2)
	# (17, 22)
	addi $t2, $t0, 2884
	sw $t1, 0($t2)
	# (18, 22)
	addi $t2, $t0, 2888
	sw $t1, 0($t2)
	# (19, 22)
	addi $t2, $t0, 2892
	sw $t1, 0($t2)
	# (17, 23)
	addi $t2, $t0, 3012
	sw $t1, 0($t2)
	# (17, 24)
	addi $t2, $t0, 3140
	sw $t1, 0($t2)
	# (18, 24)
	addi $t2, $t0, 3144
	sw $t1, 0($t2)
	# (19, 24)
	addi $t2, $t0, 3148
	sw $t1, 0($t2)
	
	# DISPLAYING R
	# (21, 20)
	addi $t2, $t0, 2644
	sw $t1, 0($t2)
	# (22, 20)
	addi $t2, $t0, 2648
	sw $t1, 0($t2)
	# (23, 20)
	addi $t2, $t0, 2652
	sw $t1, 0($t2)
	# (21, 21)
	addi $t2, $t0, 2772
	sw $t1, 0($t2)
	# (24, 21)
	addi $t2, $t0, 2784
	sw $t1, 0($t2)
	# (21, 22)
	addi $t2, $t0, 2900
	sw $t1, 0($t2)
	# (22, 22)
	addi $t2, $t0, 2904
	sw $t1, 0($t2)
	# (23, 22)
	addi $t2, $t0, 2908
	sw $t1, 0($t2)
	# (21, 23)
	addi $t2, $t0, 3028
	sw $t1, 0($t2)
	# (24, 23)
	addi $t2, $t0, 3040
	sw $t1, 0($t2)
	# (21, 24)
	addi $t2, $t0, 3156
	sw $t1, 0($t2)
	# (24, 24)
	addi $t2, $t0, 3168
	sw $t1, 0($t2)
	
	jr $ra					# return
