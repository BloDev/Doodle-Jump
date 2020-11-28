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

#####################################################################
# CHARACTERS
charA: .word 0,	4, 8, 128, -1, 136, 256, 260, 264, 384, -1, 392, 512, -1, 520
charB: .word 0, 4, -1, 128, -1, 136, 256, 260, -1, 384, -1, 392, 512, 516, -1
charC: .word -1, 4, 8, 128, -1, -1, 256, -1, -1, 384, -1, -1, -1, 516, 520
charD: .word 0, 4, -1, 128, -1, 136, 256, -1, 264, 384, -1, 392, 512, 516, -1
charE: .word 0, 4, 8, 128, -1, -1, 256, 260, 264, 384, -1, -1, 512, 516, 520
charF: .word 0, 4, 8, 128, -1, -1, 256, 260, 264, 384, -1, -1, 512, -1, -1
charG: .word -1, 4, 8, 128, -1, -1, 256, -1, 264, 384, -1, 392, -1, 516, 520
charH: .word 0, -1, 8, 128, -1, 136, 256, 260, 264, 384, -1, 392, 512, -1, 520
charI: .word 0, 4, 8, -1, 132, -1, -1, 260, -1, -1, 388, -1, 512, 516, 520
charJ: .word -1, -1, 8, -1, -1, 136, -1, -1, 264, 384, -1, 392, 512, 516, 520
charK: .word 0, -1, 8, 128, -1, 136, 256, 260, -1, 384, -1, 392, 512, -1, 520
charL: .word 0, -1, -1, 128, -1, -1, 256, -1, -1, 384, -1, -1, 512, 516, 520
charM: .word 0, -1, 8, 128, 132, 136, 256, -1, 264, 384, -1, 392, 512, -1, 520
charN: .word 0, 4, 8, 128, -1, 136, 256, -1, 264, 384, -1, 392, 512, -1, 520
charO: .word 0, 4, 8, 128, -1, 136, 256, -1, 264, 384, -1, 392, 512, 516, 520
charP: .word 0, 4, 8, 128, -1, 136, 256, 260, 264, 384, -1, -1, 512, -1, -1
charQ: .word 0, 4, 8, 128, -1, 136, 256, -1, 264, 384, 388, 392, -1, 516, -1
charR: .word 0, 4, -1, 128, -1, 136, 256, 260, -1, 384, -1, 392, 512, -1, 520
charS: .word -1, 4, 8, 128, -1, -1, -1, 260, -1, -1, -1, 392, 512, 516, -1
charT: .word 0, 4, 8, -1, 132, -1, -1, 260, -1, -1, 388, -1, -1, 516, -1
charU: .word 0, -1, 8, 128, -1, 136, 256, -1, 264, 384, -1, 392, 512, 516, 520
charV: .word 0, -1, 8, 128, -1, 136, 256, -1, 264, 384, -1, 392, -1, 516, -1
charW: .word 0, -1, 8, 128, -1, 136, 256, -1, 264, 384, 388, 392, 512, -1, 520
charX: .word 0, -1, 8, 128, -1, 136, -1, 260, -1, 384, -1, 392, 512, -1, 520
charY: .word 0, -1, 8, 128, -1, 136, 256, 260, 264, -1, 388, -1, -1, 516, -1
charZ: .word 0, 4, 8, -1, -1, 136, -1, 260, -1, 384, -1, -1, 512, 516, 520
one: .word 0, 4, -1, -1, 132, -1, -1, 260, -1, -1, 388, -1, -1, 516, -1
two: .word 0, 4, 8, -1, -1, 136, 256, 260, 264, 384, -1, -1, 512, 516, 520
three: .word 0, 4, 8, -1, -1, 136, 256, 260, 264, -1, -1, 392, 512, 516, 520
four: .word 0, -1, 8, 128, -1, 136, 256, 260, 264, -1, -1, 392, -1, -1, 520
five: .word 0, 4, 8, 128, -1, -1, 256, 260, 264, -1, -1, 392, 512, 516, 520
six: .word 0, 4, 8, 128, -1, -1, 256, 260, 264, 384, -1, 392, 512, 516, 520
seven: .word 0, 4, 8, 128, -1, 136, -1, -1, 264, -1, -1, 392, -1, -1, 520
eight: .word 0, 4, 8, 128, -1, 136, 256, 260, 264, 384, -1, 392, 512, 516, 520
nine: .word 0, 4, 8, 128, -1, 136, 256, 260, 264, -1, -1, 392, 512, 516, 520
zero: .word 0, 4, 8, 128, -1, 136, 256, -1, 264, 384, -1, 392, 512, 516, 520
exclamation: .word -1, 4, -1, -1, 132, -1, -1, 260, -1, -1, -1, -1, -1, 516, -1
question: .word 0, 4, 8, -1, -1, 136, -1, 260, 264, -1, -1, -1, -1, 516, -1
colon: .word -1, -1, -1, -1, 132, -1, -1, -1, -1, -1, 388, -1, -1, -1, -1
#####################################################################

# COLOURS
white: .word 0xffffff
red: .word 0xff0000
green: .word 0x00ff00
blue: .word 0x0000ff
yellow: 0xffff00

# OBJECT COLOURS
backgroundColour: .word 0x008080		# teal
platformColour: .word 0xC19A6B			# brown
textColour: .word 0xffff00			# yellow
playerColour: .word 0x00ff00			# green

# SCREEN
displayAddress:	.word 0x10008000
displayUnits: .word 32

# PLAYER
jumpHeight: .word 16

# KEYS
startKey: .word 0x20
restartKey: .word 0x73
leftKey: .word 0x6A
rightKey: .word 0x6B
levelOneKey: .word 0x31
levelTwoKey: .word 0x32
levelThreeKey: .word 0x33

# PLATFORMS
platformSize: .word 12
platformA: .space 8
platformB: .space 8
platformC: .space 8
startPlatformX: .word 10

# SLEEP DELAY
sleepDelay: .word 30

.globl main
.text

#####################################################################
#####################################################################
#####################################################################

main:

startScreen:
	jal drawBackground
	jal drawStartScreen
	jal checkGameStartKeypress

levelScreen:
	jal drawBackground
	jal drawLevelScreen
	jal checkLevelKeypress

initializePlatforms:
	la $t0, platformA			# $t0 = A
	lw $t1, startPlatformX
	sw $t1, 0($t0)				# A.x = startPlatformX
	li $t1, 31
	sw $t1, 4($t0)				# A.y = 31
	
	la $t0, platformB			# $t0 = B
	li $t1, 20
	sw $t1, 4($t0)				# B.y = 20
	move $a0, $t0				# pass B as argument
	jal randomizeX				# randomize B.x
	
	la $t0, platformC			# $t0 = C
	li $t1, 9
	sw $t1, 4($t0)				# C.y = 9
	move $a0, $t0				# pass C as argument
	jal randomizeX				# randomize C.x

initializePlayer:
	li $s0, 16				# player.x
	li $s1, 24				# player.y
	li $s2, 1				# direction (upwards = -1, downwards = 1)
	li $s3, 0				# jumpCounter
	li $s6, 0				# score
	li $s7, 0				# platformScroll

drawDisplay:
	jal drawBackground
	jal drawPlayer
	jal drawPlatforms
	jal drawScore
	
idle:
	jal sleep

# --------------------------------------------------
checkIfScrollIsPresent:
	bne $s7, 11, startOfScroll
	li $s2, 1
	li $s3, 0
	li $s7, 0
	j movePlayer

startOfScroll:
	bgt $s1, 14, getUserInput
	beqz $s3, getUserInput

updateNewPlatforms:
	bnez $s7, scrollScreen
	addi $s6, $s6, 1
	jal createNewPlatforms
	
scrollScreen:
	jal scrollPlatforms
	addi $s7, $s7, 1
	
getUserInput:
	jal checkKeypress

endOfScroll:
	beqz $s7, movePlayer
	j drawDisplay
# --------------------------------------------------

movePlayer:
	add $s1, $s1, $s2

updatePlayerJumpCounter:
	jal updateJumpCounter

checkIfPlayerCollided:
	jal checkCollision

checkIfPlayerLost:
	lw $t0, displayUnits
	bge $s1, $t0, endGame			# if player.y >= displayUnits then end game

loopGame:
	j drawDisplay				# loop

endGame:
	jal drawGameOver			# draw game over screen
	jal checkGameEndKeypress
	j startScreen
	
#####################################################################
#####################################################################
#####################################################################

# drawScore -> displays the score
drawScore:
	li $t0, 10
	div $s6, $t0
	
	mflo $t1				# first digit
	mfhi $t8				# second digit
	
	li $t3, 132

	bnez $t1, drawZero
	move $t1, $t8
	li $t9, -1

drawZero:
	bne $t1, 0, drawOne
	la $t4, zero
	
drawOne:
	bne $t1, 1, drawTwo
	la $t4, one

drawTwo:
	bne $t1, 2, drawThree
	la $t4, two

drawThree:
	bne $t1, 3, drawFour
	la $t4, three

drawFour:
	bne $t1, 4, drawFive
	la $t4, four

drawFive:
	bne $t1, 5, drawSix
	la $t4, five

drawSix:
	bne $t1, 6, drawSeven
	la $t4, six

drawSeven:
	bne $t1, 7, drawEight
	la $t4, seven

drawEight:
	bne $t1, 8, drawNine
	la $t4, eight

drawNine:
	bne $t1, 9, drawNumber
	la $t4, nine
	
drawNumber:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	move $a0, $t3
	move $a1, $t4
	
	jal drawChar
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
checkForSecondNumber:
	beq $t9, -1, endDrawScore
	move $t1, $t8
	li $t3, 148
	li $t9, -1
	j drawZero
	
endDrawScore:
	jr $ra

# drawChar(starting position, character) -> draws a character starting at the starting position (1D)
drawChar:
	lw $t0, textColour
	lw $t1, displayAddress
	add $t1, $t1, $a0
	li $t2, 0
	
loopDrawChar:
	bge $t2, 15, endDrawChar
	lw $t3, 0($a1)
	add $t4, $t1, $t3
	addi $a1, $a1, 4
	addi $t2, $t2, 1
	beq $t3, -1, loopDrawChar
	sw $t0, 0($t4)
	j loopDrawChar

endDrawChar:
	jr $ra

# sleep -> pause
sleep:
	lw $t0, sleepDelay
	li $v0, 32
	move $a0, $t0
	syscall					# sleep
	
	jr $ra
	
# checkGameStartKeypress -> checks for valid keypress at the start of the game
checkGameStartKeypress:
	lw $t0, 0xffff0000			# obtain value to check if input is detected
	bne $t0, 1, checkGameStartKeypress	# if (no input detected) then keep checking for a keypress

getGameStartInput:
	lw $t0, 0xffff0004 			# obtain input stored in next byte

checkGameStart:
	lw $t1, startKey			# $t1 = startKey
	bne $t0, $t1, checkGameStartKeypress	# if (input != startKey) then keep checking for a keypress

endCheckGameStartKeypress:
	jr $ra					# return
	
# checkLevelKeypress -> checks for valid keypress at the start of the game for levels
checkLevelKeypress:
	lw $t0, 0xffff0000			# obtain value to check if input is detected
	bne $t0, 1, checkLevelKeypress		# if (no input detected) then keep checking for a keypress

getLevelInput:
	lw $t0, 0xffff0004 			# obtain input stored in next byte

checkLevelOne:
	lw $t1, levelOneKey			# $t1 = levelOneKey
	bne $t0, $t1, checkLevelTwo		# if (input != levelOneKey) then keep checking for a keypress
	li $t2, 12
	sw $t2, platformSize
	j endCheckLevelKeypress
	
checkLevelTwo:
	lw $t1, levelTwoKey			# $t1 = levelTwoKey
	bne $t0, $t1, checkLevelThree		# if (input != levelTwoKey) then keep checking for a keypress
	li $t2, 8
	sw $t2, platformSize
	li $t2, 12
	sw $t2, startPlatformX
	j endCheckLevelKeypress
	
checkLevelThree:
	lw $t1, levelThreeKey			# $t1 = levelThreeKey
	bne $t0, $t1, checkLevelKeypress	# if (input != levelThreeKey) then keep checking for a keypress
	li $t2, 4
	sw $t2, platformSize
	li $t2, 14
	sw $t2, startPlatformX
	j endCheckLevelKeypress

endCheckLevelKeypress:
	jr $ra					# return

# checkGameEndKeypress -> checks for valid keypress at the end of the game for restart
checkGameEndKeypress:
	lw $t0, 0xffff0000			# obtain value to check if input is detected
	bne $t0, 1, checkGameEndKeypress	# if (no input detected) then keep checking for a keypress

getGameEndInput:
	lw $t0, 0xffff0004 			# obtain input stored in next byte

checkGameEndRestart:
	lw $t1, restartKey			# $t1 = restartKey
	bne $t0, $t1, checkGameEndKeypress	# if (input != restartKey) then keep checking for a keypress

endCheckGameEndKeypress:
	jr $ra					# return

# checkKeypress -> checks for valid keypress for moving the player left or right
checkKeypress:
	lw $t0, 0xffff0000			# obtain value to check if input is detected
	bne $t0, 1, endCheckKeypress		# if (no input detected) then exit

getInput:
	lw $t0, 0xffff0004 			# obtain input stored in next byte
	
checkLeft:
	lw $t1, leftKey				# $t1 = leftKey
	bne $t0, $t1, checkRight		# if (input != leftKey) then checkRight

moveLeft:
	addi $s0, $s0, -1			# move 1 unit left
	j checkOutOfScreen			# jump to checkOutOfScreen

checkRight:
	lw $t1, rightKey			# $t1 = rightKey
	bne $t0, $t1, endCheckKeypress		# if (input != rightKey) then exit

moveRight:
	addi $s0, $s0, 1			# move 1 unit right
	j checkOutOfScreen			# jump to checkOutOfScreen

checkOutOfScreen:
	lw $t1, displayUnits			# load displayUnits
	bge $s0, $t1, wrapLeft			# if (x >= displayUnits) then wrapLeft
	bltz $s0, wrapRight			# if (x < 0) then wrapRight
	j endCheckKeypress			# otherwise, jump to exit
	
wrapLeft:
	li $s0, 0				# set player's x-coordinate to 0
	j endCheckKeypress			# jump to exit

wrapRight:
	addi $t1, $t1, -1			# $t1 = displayUnits - 1
	move $s0, $t1				# set player's x-coordinate to displayUnits - 1
	j endCheckKeypress			# jump to exit

endCheckKeypress:
	jr $ra

# updateJumpCounter -> increments the jumpCounter if the player is going upwards, and if at max jumping height, then switches player direction downwards
updateJumpCounter:
	beq $s2, 1, endUpdateJumpCounter	# if (direction is downwards) then skip condition
	addi $s3, $s3, 1			# jumpCounter++
	lw $t0, jumpHeight			# $t0 = jumpHeight
	blt $s3, $t0, endUpdateJumpCounter	# if (jumpCounter < jumpHeight) then skip condition
	li $s2, 1				# set player direction downwards
	li $s3, 0				# jumpCounter = 0

endUpdateJumpCounter:
	jr $ra

# checkCollision -> checks if there is any collision with the player and the platform
checkCollision:
	beq $s2, -1, endCheckCollision		# if (direction is upwards) then skip condition
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
	blt $s0, $t3, endCheckCollision		# if (player.x < C.x) then endCollisionCheck
	bge $s0, $t4, endCheckCollision		# if (player.x >= C.x + platformSize) then endCollisionCheck
	bne $s1, $t5, endCheckCollision		# if (player.y != C.y - 1) then endCollisionCheck
	li $s2, -1				# change player direction to go upwards
	
endCheckCollision:
	jr $ra

# randomizeX(platform) -> randomizes the x-coordinate of a platform
randomizeX:
	move $t0, $a0				# $t0 = platformAddress
	lw $t1, displayUnits			# $t1 = displayUnits
	lw $t2, platformSize			# $t2 = platformSize
	sub $t3, $t1, $t2			# $t3 = displayUnits - platformSize (max x-value)
	
	li $v0, 42				# generates a random integer within a given range
	li $a0, 0				# using only one random number generator
	move $a1, $t3				# random integer ranges from 0 to displayUnits - platformSize (exclusive)
	syscall
	sw $a0, 0($t0)				# stores random integer as x-coordinate of platform
	
endRandomizeX:
	jr $ra					# return

# updateNewPlatforms -> updates the platforms where platformA = platformB and platformB = platformC and platformC is now randomized
createNewPlatforms:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address
	
	la $t0, platformA			# $t0 = platformA
	la $t1, platformB			# $t0 = platformB
	la $t2, platformC			# $t0 = platformC
	
	lw $t3, 0($t1)				# load up platformB's (x, y)
	lw $t4, 4($t1)
	
	sw $t3, 0($t0)				# platformA = platformB
	sw $t4, 4($t0)
	
	lw $t3, 0($t2)				# load up platformC's (x, y)		
	lw $t4, 4($t2)
	
	sw $t3, 0($t1)				# platformB = platformC
	sw $t4, 4($t1)
	
	li $t3, -2
	sw $t3, 4($t2)				# set platformC's y-value to -2
	
	move $a0, $t2				# pass platformC as argument
	jal randomizeX				# randomize platformC's x-value
	
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
endCreateNewPlatforms:
	jr $ra

# scrollPlatforms -> scrolls the platforms down by 1 unit
scrollPlatforms:	
	la $t0, platformA			# $t0 = platformA
	la $t1, platformB			# $t0 = platformB
	la $t2, platformC			# $t0 = platformC
	
	lw $t4, 4($t0)				# load all platform y-values
	lw $t5, 4($t1)
	lw $t6, 4($t2)
	
	addi $t4, $t4, 1			# increment all platform y-values
	sw $t4, 4($t0)
	
	addi $t5, $t5, 1
	sw $t5, 4($t1)
	
	addi $t6, $t6, 1
	sw $t6, 4($t2)
	
endScrollPlatforms:
	jr $ra

# drawPlatforms -> draws all the platforms on the screen
drawPlatforms:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address

	la $t0, platformA			# $t0 = platformA
	move $a0, $t0				# pass platformA as argument
	jal drawPlatform			# draw platformA
	
	la $t0, platformB			# $t0 = platformB
	move $a0, $t0				# pass platformB as argument
	jal drawPlatform			# draw platformB
	
	la $t0, platformC			# $t0 = platformC
	move $a0, $t0				# pass platformC as argument
	jal drawPlatform			# draw platformC
	
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
endDrawPlatforms:
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
	
endDrawPlayer:
	jr $ra

# drawPlatform(platform) -> draws the platform on the bitmap display
drawPlatform:
	lw $t0, platformColour			# $t0 = platformColour
	move $t1, $a0				# $t1 = platformAddress
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
	bge $t2, $t3, endDrawPlatform		# if (i >= platformSize) then exit loop
	sw $t0, 0($t4)				# draw pixel at unit
	addi $t4, $t4, 4			# unit++
	addi $t2, $t2, 1			# i++
	j drawPlatformLoop			# loop
	
endDrawPlatform:
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
	bge $t0, $t1, endDrawBackground		# if (i >= lastUnit) then exit loop
	sw $t3, 0($t2)				# colour unit at displayAddress
	addi $t2, $t2, 4			# displayAddress++
	addi $t0, $t0, 1			# i++
	j drawBackgroundLoop			# loop
	
endDrawBackground:
	jr $ra					# return
	
# drawStartScreen -> draws the starting screen
drawStartScreen:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address

	li $a0, 528
	la $a1, charD
	jal drawChar
	
	li $a0, 544
	la $a1, charO
	jal drawChar
	
	li $a0, 560
	la $a1, charO
	jal drawChar
	
	li $a0, 576
	la $a1, charD
	jal drawChar
	
	li $a0, 592
	la $a1, charL
	jal drawChar
	
	li $a0, 608
	la $a1, charE
	jal drawChar
	
	lw $t0, green
	sw $t0, textColour
	
	li $a0, 1424
	la $a1, charJ
	jal drawChar
	
	li $a0, 1440
	la $a1, charU
	jal drawChar
	
	li $a0, 1456
	la $a1, charM
	jal drawChar
	
	li $a0, 1472
	la $a1, charP
	jal drawChar
	
	lw $t0, yellow
	sw $t0, textColour
	
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
endDrawStartScreen:
	jr $ra

# drawLevelScreen -> draws the level screen
drawLevelScreen:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address
	
	li $a0, 528
	la $a1, charL
	jal drawChar
	
	li $a0, 544
	la $a1, charE
	jal drawChar
	
	li $a0, 560
	la $a1, charV
	jal drawChar
	
	li $a0, 576
	la $a1, charE
	jal drawChar
	
	li $a0, 592
	la $a1, charL
	jal drawChar
	
	li $a0, 608
	la $a1, charS
	jal drawChar
	
	lw $t0, green
	sw $t0, textColour
	
	li $a0, 1424
	la $a1, one
	jal drawChar
	
	li $a0, 1440
	la $a1, colon
	jal drawChar
	
	li $a0, 1456
	la $a1, charE
	jal drawChar
	
	li $a0, 1472
	la $a1, charZ
	jal drawChar
	
	li $a0, 2192
	la $a1, two
	jal drawChar
	
	li $a0, 2208
	la $a1, colon
	jal drawChar
	
	li $a0, 2224
	la $a1, charM
	jal drawChar
	
	li $a0, 2240
	la $a1, charE
	jal drawChar
	
	li $a0, 2256
	la $a1, charH
	jal drawChar
	
	li $a0, 2960
	la $a1, three
	jal drawChar
	
	li $a0, 2976
	la $a1, colon
	jal drawChar
	
	li $a0, 2992
	la $a1, charH
	jal drawChar
	
	li $a0, 3008
	la $a1, charA
	jal drawChar
	
	li $a0, 3024
	la $a1, charR
	jal drawChar
	
	li $a0, 3040
	la $a1, charD
	jal drawChar
	
	lw $t0, yellow
	sw $t0, textColour
	
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
endDrawLevelScreen:
	jr $ra
	
# drawGameOver -> draws the text game over on the screen
drawGameOver:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address

	li $a0, 924
	la $a1, charG
	jal drawChar
	
	li $a0, 944
	la $a1, charA
	jal drawChar
	
	li $a0, 964
	la $a1, charM
	jal drawChar
	
	li $a0, 984
	la $a1, charE
	jal drawChar
	
	li $a0, 2588
	la $a1, charO
	jal drawChar
	
	li $a0, 2608
	la $a1, charV
	jal drawChar
	
	li $a0, 2628
	la $a1, charE
	jal drawChar
	
	li $a0, 2648
	la $a1, charR
	jal drawChar
	
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
endDrawGameOver:
	jr $ra
