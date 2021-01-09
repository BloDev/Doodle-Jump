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
# - Milestone 1 complete: finished (1.a) and (1.b)
# - Milestone 2 complete: finished (2.a) and (2.b)
# - Milestone 3 complete: finished (3.a) and (3.b)
# - Milestone 4 complete (at least two): finished two objectives (4.a) and (4.b)
# - Milestone 5 complete (at least three): finished three objectives (5.b), (5.d), and (5.e)
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)
# 1. Added score counter (4.a)
# 2. Added different levels (4.b)
# 3. Added more platform types, specifically moving platforms and breaking platforms (two hits) (5.b)
# 4. Added start / game over / pause screens with updated graphics (5.d)
# 5. Added dynamic on-screen notifications (5.e)
#
# Link to video demonstration for final submission:
# - https://www.youtube.com/watch?v=3_Xi4JB8Dpk
#
# Any additional information that the TA needs to know:
# - Left Key: j
# - Right Key: k
# - Start/Restart Key: s
# - Pause Key: escape
# - Level One Key: 1
# - Level Two Key: 2
# - Level Three Key: 3
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
bar: .word -1, 4, -1, -1, 132, -1, -1, 260, -1, -1, 388, -1, -1, 516, -1
#####################################################################

# COLOURS
white: .word 0xffffff
red: .word 0xff0000
green: .word 0x00ff00
lightblue: .word 0x87ceeb
blue: .word 0x0000ff
yellow: .word 0xffff00
orange: .word 0xffa500
pink: .word 0xffc0cb
darkpink: .word 0xe75480

# OBJECT COLOURS
backgroundColour: .word 0x008080		# teal
platformColour: .word 0xC19A6B			# brown
textColour: .word 0xffff00			# yellow
playerColour: .word 0x00ff00			# green

# SCREEN
displayAddress:	.word 0x10008000
displayUnits: .word 32

# PLAYER
jumpHeight: .word 12

# KEYS
startKey: .word 0x73
restartKey: .word 0x73
pauseKey: .word 0x1B
leftKey: .word 0x6A
rightKey: .word 0x6B
levelOneKey: .word 0x31
levelTwoKey: .word 0x32
levelThreeKey: .word 0x33

# PLATFORMS
platformSize: .word 12
platformA: .space 12
platformB: .space 12
platformC: .space 12
platformD: .space 12
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
	li $t1, 0
	sw $t1, 8($t0)				# platform.type = 0
	
	la $t0, platformB			# $t0 = B
	li $t1, 23
	sw $t1, 4($t0)				# B.y = 23
	move $a0, $t0				# pass B as argument
	jal randomizeX				# randomize B.x
	li $t1, 0
	sw $t1, 8($t0)				# platform.type = 0
	
	la $t0, platformC			# $t0 = C
	li $t1, 15
	sw $t1, 4($t0)				# C.y = 15
	move $a0, $t0				# pass C as argument
	jal randomizeX				# randomize C.x
	li $t1, 0
	sw $t1, 8($t0)				# platform.type = 0
	
	la $t0, platformD			# $t0 = D
	li $t1, 7
	sw $t1, 4($t0)				# D.y = 7
	move $a0, $t0				# pass D as argument
	jal randomizeX				# randomize D.x
	li $t1, 0
	sw $t1, 8($t0)				# platform.type = 0

initializePlayer:
	li $s0, 14				# player.x
	li $s1, 24				# player.y
	li $s2, 1				# direction (upwards = -1, downwards = 1)
	li $s3, 0				# jumpCounter
	li $s5, -1				# dynamic text number
	li $s6, 0				# score
	li $s7, 0				# scrollCounter

drawDisplay:
	jal drawBackground
	jal drawPlayer
	jal updatePlatforms
	jal drawPlatforms
	jal drawScore
	
checkIfDisplayOnScreenText:
	li $t0, 10
	div $s6, $t0
	mfhi $t0				# $t0 = last digit of score
	
	beqz $t0, checkIfScoreIsNotZero		# if the last digit of score is not zero, then reset dynamic text number
	li $s5, -1
	j idle
	
checkIfScoreIsNotZero:
	beqz $s6, idle				# if score == zero then skip
	
	bne $s5, -1, drawDynamicTextOnScreen	# if dynamic text number has not been generated
	
	li $v0, 42				# generates a random integer within a given range
	li $a0, 0				# using only one random number generator
	li $a1, 6				# random integer ranges from 0 to 6 (exclusive)
	syscall
	move $s5, $a0
	
drawDynamicTextOnScreen:
	jal drawDynamicText
	
idle:
	jal sleep

# --------------------------------------------------
checkIfScrollIsPresent:
	bne $s7, 8, startOfScroll		# if scrollCounter == 8 then
	li $s2, 1				# reset player direction
	li $s3, 0				# reset jumpCounter
	li $s7, 0				# reset scrollCounter
	j movePlayer

startOfScroll:
	bge $s1, 10, getUserInput		# scroll only if player.y < 10
	beqz $s3, getUserInput			# player must not be at the peak of jump

updateNewPlatforms:
	bnez $s7, scrollScreen			# if scrollCounter == 0 then initialize platforms for scrolling
	addi $s6, $s6, 1
	jal createNewPlatforms
	
scrollScreen:
	jal scrollPlatforms			# scroll platforms
	addi $s7, $s7, 1
	
getUserInput:
	jal checkKeypress			# checks for player keypress

endOfScroll:
	beqz $s7, movePlayer			# if scrollCounter != 0 then loop back to start
	j drawDisplay
# --------------------------------------------------

movePlayer:
	add $s1, $s1, $s2			# increment player

updatePlayerJumpCounter:
	jal updateJumpCounter

checkIfPlayerCollided:
	jal checkPlatformCollision

checkIfPlayerLost:
	lw $t0, displayUnits
	addi $t1, $s1, 1
	bge $t1, $t0, endGame			# if player.y + 1 >= displayUnits then end game

loopGame:
	j drawDisplay				# loop

endGame:
	jal drawGameOver			# draw game over screen
	jal checkGameEndKeypress
	j startScreen
	
#####################################################################
#####################################################################
#####################################################################

# updatePlatforms -> updates the platforms if they move
updatePlatforms:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address
	
updatePlatformA:
	la $a0, platformA
	lw $t0, 8($a0)
	beqz $t0, updatePlatformB		# platform.type == 0 means it is normal
	beq $t0, -2, updatePlatformB		# platform.type == -2 means it is broken
	beq $t0, 2, updatePlatformB		# platform.type == 2 means it has two hits
	beq $t0, 3, updatePlatformB		# platform.type == 3 means it has one hit
	jal movePlatform			# platform.type == 1 or platform.type == -1 means that it moves in that direction

updatePlatformB:
	la $a0, platformB
	lw $t0, 8($a0)
	beqz $t0, updatePlatformC
	beq $t0, -2, updatePlatformC
	beq $t0, 2, updatePlatformC
	beq $t0, 3, updatePlatformC
	jal movePlatform

updatePlatformC:
	la $a0, platformC
	lw $t0, 8($a0)
	beqz $t0, updatePlatformD
	beq $t0, -2, updatePlatformD
	beq $t0, 2, updatePlatformD
	beq $t0, 3, updatePlatformD
	jal movePlatform

updatePlatformD:
	la $a0, platformD
	lw $t0, 8($a0)
	beqz $t0, endUpdatePlatforms
	beq $t0, -2, endUpdatePlatforms
	beq $t0, 2, endUpdatePlatforms
	beq $t0, 3, endUpdatePlatforms
	jal movePlatform

endUpdatePlatforms:
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
	jr $ra

# movePlatform -> moves the platform
movePlatform:
	move $t0, $a0				# $t0 = platformAddress
	lw $t1, 0($t0)				# $t1 = platform.x (min-x)
	lw $t2, platformSize			# $t2 = platformSize
	add $t2, $t2, $t1			# $t2 = platform.x + platformSize (max-x exclusive)
	
checkPlatformLeft:				# check platform collision on left
	bnez $t1, checkPlatformRight
	li $t3, 1
	sw $t3, 8($t0)
	j incrementPlatform
	
checkPlatformRight:				# check platform collision on right
	lw $t4, displayUnits
	bne $t2, $t4, incrementPlatform
	li $t3, -1
	sw $t3, 8($t0)
	j incrementPlatform

incrementPlatform:				# increment platform
	lw $t3, 8($t0)
	add $t1, $t1, $t3
	sw $t1, 0($t0)
	
endMovePlatform:
	jr $ra

# drawScore -> displays the score
drawScore:
	li $t0, 10
	div $s6, $t0				# divide score by 10
	
	li $t7, 240				# position of first digit

drawScoreLoop:
	mflo $t8				# upper digits of score
	mfhi $t9				# first digit of score
	
drawZero:
	bne $t9, 0, drawOne
	la $t1, zero
	
drawOne:
	bne $t9, 1, drawTwo
	la $t1, one

drawTwo:
	bne $t9, 2, drawThree
	la $t1, two

drawThree:
	bne $t9, 3, drawFour
	la $t1, three

drawFour:
	bne $t9, 4, drawFive
	la $t1, four

drawFive:
	bne $t9, 5, drawSix
	la $t1, five

drawSix:
	bne $t9, 6, drawSeven
	la $t1, six

drawSeven:
	bne $t9, 7, drawEight
	la $t1, seven

drawEight:
	bne $t9, 8, drawNine
	la $t1, eight

drawNine:
	bne $t9, 9, drawNumber
	la $t1, nine
	
drawNumber:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	move $a0, $t7
	move $a1, $t1
	
	jal drawChar
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4

loopDrawScore:
	li $t0, 10
	div $t8, $t0				# divide upper digits by 10

	addi $t7, $t7, -16			# move digit to the left
	bnez $t8, drawScoreLoop			# draw until quotient is 0

endDrawScore:
	jr $ra

# drawChar(starting position, character) -> draws a character starting at the starting position (1D)
drawChar:
	lw $t0, textColour			# loads colour and displayAddress
	lw $t1, displayAddress
	add $t1, $t1, $a0			# $t1 = textAddress + displayAddress
	li $t2, 0
	
loopDrawChar:
	bge $t2, 15, endDrawChar		# loops through all 15 offsets from textAddress
	lw $t3, 0($a1)
	add $t4, $t1, $t3
	addi $a1, $a1, 4
	addi $t2, $t2, 1
	beq $t3, -1, loopDrawChar		# if offset != -1, then draw at that unit
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

# checkGameResumeKeypress -> checks for valid keypress to resume
checkGameResumeKeypress:
	lw $t0, 0xffff0000			# obtain value to check if input is detected
	bne $t0, 1, checkGameResumeKeypress	# if (no input detected) then keep checking for a keypress

getGameResumeInput:
	lw $t0, 0xffff0004 			# obtain input stored in next byte

checkGameResume:
	lw $t1, pauseKey			# $t1 = pauseKey
	bne $t0, $t1, checkGameResumeKeypress	# if (input != pauseKey) then keep checking for a keypress

endCheckGameResumeKeypress:
	jr $ra					# return
	
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
	sw $t2, platformSize			# change platformSize
	j endCheckLevelKeypress
	
checkLevelTwo:
	lw $t1, levelTwoKey			# $t1 = levelTwoKey
	bne $t0, $t1, checkLevelThree		# if (input != levelTwoKey) then keep checking for a keypress
	li $t2, 10
	sw $t2, platformSize			# change platformSize
	li $t2, 10
	sw $t2, startPlatformX			# change startPlatformX
	j endCheckLevelKeypress
	
checkLevelThree:
	lw $t1, levelThreeKey			# $t1 = levelThreeKey
	bne $t0, $t1, checkLevelKeypress	# if (input != levelThreeKey) then keep checking for a keypress
	li $t2, 8
	sw $t2, platformSize			# change platformSize
	li $t2, 12
	sw $t2, startPlatformX			# change startPlatformX
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

checkPause:
	lw $t1, pauseKey			# $t1 = pauseKey
	bne $t0, $t1, checkLeft			# if (input != pauseKey) then checkLeft
	
pauseScreen:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address
	
	jal drawPauseScreen
	jal checkGameResumeKeypress
	
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	j endCheckKeypress
	
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

# checkPlatformCollision -> checks if there is any collision with the player and the platform
checkPlatformCollision:
	beq $s2, -1, endCheckCollision		# if (direction is upwards) then skip condition
	
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address
	
checkPlatformA:
	la $a0, platformA
	jal checkCollision

checkPlatformB:
	la $a0, platformB
	jal checkCollision

checkPlatformC:
	la $a0, platformC
	jal checkCollision

checkPlatformD:
	la $a0, platformD
	jal checkCollision

endCheckPlatformCollision:
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
	jr $ra
	
# checkCollision(platform) -> checks if the player collides with platform
checkCollision:
	move $t0, $a0				# $t0 = platformAddress
	lw $t1, 0($t0)				# $t1 = platform.x (min-x)
	lw $t2, platformSize			# $t2 = platformSize
	add $t2, $t2, $t1			# $t2 = platform.x + platformSize (max-x exclusive)
	lw $t3, 4($t0)				# $t3 = platform.y
	addi $t3, $t3, -2			# $t3 = platform.y - 2 (to compare with player height)
	move $t4, $s0				# $t4 = player.x (min player.x)
	addi $t5, $s0, 2			# $t5 = player.x + 2 (max player.x)
	
checkPlayerOutOfScreen1:
	bne $t5, 32, checkPlayerOutOfScreen2	# if player.x extends 1 unit off screen, make $t5 = 0
	li $t5, 0
	j checkPlayerY
	
checkPlayerOutOfScreen2:
	bne $t5, 33, checkPlayerY		# if player.x extends 2 units off screen, make $t5 = 1
	li $t5, 1
	j checkPlayerY

checkPlayerY:
	bne $s1, $t3, endCheckCollision		# if (player.y != platform.y - 2) then terminate

checkMinPlayerX:
	blt $t4, $t1, checkMaxPlayerX		# verify that min player.x is within platform bounds
	bge $t4, $t2, checkMaxPlayerX
	li $s2, -1				# change player direction to go upwards
	j checkCollisionBreak
	
checkMaxPlayerX:
	blt $t5, $t1, endCheckCollision		# verify that max player.x is within platform bounds
	bge $t5, $t2, endCheckCollision
	li $s2, -1				# change player direction to go upwards
	j checkCollisionBreak
	
checkCollisionBreak:
	lw $t6, 8($t0)				# load up platform.type

checkFirstCollisionBreak:
	bne $t6, 2, checkSecondCollisionBreak	# if platform.type == 2 then tag it as one hit left
	li $t7, 3
	sw $t7, 8($t0)
	j endCheckCollision
	
checkSecondCollisionBreak:
	bne $t6, 3, endCheckCollision		# if platform.type == 3 then break the platform
	li $t7, -2
	sw $t7, 8($t0)				# set platform.type = -2 (as in broken)
	li $t8, -9999
	sw $t8, 4($t0)				# set platform.y = -9999 (so it does not affect collision)
	j endCheckCollision
	
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
	
# randomizeType(platform) -> randomizes the type of a platform
randomizeType:
	move $t0, $a0				# $t0 = platformAddress
	
	li $v0, 42				# generates a random integer within a given range
	li $a0, 0				# using only one random number generator
	li $t1, 3
	move $a1, $t1				# random integer ranges from 0 to 3 (exclusive)
	syscall
	sw $a0, 8($t0)				# stores random integer as type (0, 1, 2)
	
endRandomizeType:
	jr $ra					# return

# updateNewPlatforms -> updates the platforms where platformA = platformB and platformB = platformC and platformC is now randomized
createNewPlatforms:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address
	
	la $t0, platformA			# $t0 = platformA
	la $t1, platformB			# $t1 = platformB
	la $t2, platformC			# $t2 = platformC
	la $t3, platformD			# $t3 = platformC
	
	lw $t4, 0($t1)				# load up platformB's (x, y)
	lw $t5, 4($t1)
	lw $t6, 8($t1)
	
	sw $t4, 0($t0)				# platformA = platformB
	sw $t5, 4($t0)
	sw $t6, 8($t0)
	
	lw $t4, 0($t2)				# load up platformC's (x, y)		
	lw $t5, 4($t2)
	lw $t6, 8($t2)
	
	sw $t4, 0($t1)				# platformB = platformC
	sw $t5, 4($t1)
	sw $t6, 8($t1)
	
	lw $t4, 0($t3)				# load up platformD's (x, y)		
	lw $t5, 4($t3)
	lw $t6, 8($t3)
	
	sw $t4, 0($t2)				# platformC = platformD
	sw $t5, 4($t2)
	sw $t6, 8($t2)
	
	li $t4, -1
	sw $t4, 4($t3)				# set platformD's y-value to -1
	
	move $a0, $t3				# pass platformD as argument
	jal randomizeX				# randomize platformD's x-value
	
	la $t3, platformD			# $t3 = platformD
	move $a0, $t3				# pass platformD as argument
	jal randomizeType			# randomize platformD's platform type
	
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
endCreateNewPlatforms:
	jr $ra

# scrollPlatforms -> scrolls the platforms down by 1 unit
scrollPlatforms:	
	la $t0, platformA			# $t0 = platformA
	la $t1, platformB			# $t1 = platformB
	la $t2, platformC			# $t2 = platformC
	la $t3, platformD			# $t3 = platformC
	
	lw $t4, 4($t0)				# load all platform y-values
	lw $t5, 4($t1)
	lw $t6, 4($t2)
	lw $t7, 4($t3)
	
	addi $t4, $t4, 1			# increment all platform y-values
	sw $t4, 4($t0)
	
	addi $t5, $t5, 1
	sw $t5, 4($t1)
	
	addi $t6, $t6, 1
	sw $t6, 4($t2)
	
	addi $t7, $t7, 1
	sw $t7, 4($t3)
	
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
	
	la $t0, platformD			# $t0 = platformD
	move $a0, $t0				# pass platformD as argument
	jal drawPlatform			# draw platformD
	
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
	sw $t0, 128($t3)
	
checkOutOfScreen1:
	bne $s0, 30, checkOutOfScreen2		# draw one side of player on left side of screen
	sw $t0, 4($t3)
	sw $t0, -124($t3)
	sw $t0, -120($t3)
	sw $t0, 8($t3)
	j endDrawPlayer
	
checkOutOfScreen2:
	bne $s0, 31, drawIfNotOutOfScreen	# draw two sides of player on left side of screen
	sw $t0, -124($t3)
	sw $t0, -252($t3)
	sw $t0, -120($t3)
	sw $t0, 8($t3)
	j endDrawPlayer

drawIfNotOutOfScreen:
	sw $t0, 4($t3)
	sw $t0, -124($t3)
	sw $t0, 8($t3)
	sw $t0, 136($t3)
	
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
	
	lw $t8, 8($t1)				# load up platform type
	
checkPlatformBroken:				# if platform.type == -2 then it is broken, so do not draw
	beq $t8, -2, endDrawPlatform
	
drawBluePlatform:
	beqz $t8, drawPinkPlatform		# if platform.type != 0 then draw blue initially
	lw $t0, lightblue
	
drawPinkPlatform:
	bne $t8, 2, drawDarkPinkPlatform	# if platform.type == 2 then draw pink
	lw $t0, pink
	
drawDarkPinkPlatform:
	bne $t8, 3, calculatePos		# if platform.type == 3 then draw darkpink
	lw $t0, darkpink
	
calculatePos:
	# calculations for starting pixel
	mult $t5, $t7
	mflo $t8
	add $t8, $t8, $t4
	li $t9, 4
	mult $t8, $t9
	mflo $t4
	add $t4, $t4, $t6			# $t4 = displayAddress + (y * displayUnits + x) * 4
	
	move $t5, $t4				# copy address into $t5 for drawing platform support
	
drawPlatformLoop:				# if (i < platformSize)
	bge $t2, $t3, drawPlatformSupportInit	# if (i >= platformSize) then exit loop
	sw $t0, 0($t4)				# draw pixel at unit
	addi $t4, $t4, 4			# unit++
	addi $t2, $t2, 1			# i++
	j drawPlatformLoop			# loop
	
drawPlatformSupportInit:
	li $t2, 0				# i = 0
	addi $t3, $t3, -4			# platformSize = platformSize - 4
	addi $t0, $t0, 16			# offset 16 to colour (for a different shade)

drawPlatformSupportLoop:
	bge $t2, $t3, endDrawPlatform		# if (i >= platformSize - 4) then exit loop
	sw $t0, 136($t5)			# draw pixel at unit
	addi $t5, $t5, 4			# unit++
	addi $t2, $t2, 1			# i++
	j drawPlatformSupportLoop		# loop
	
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
	
# drawDynamicText -> draws dynamic on-screen notifications
drawDynamicText:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address
	
checkDrawCool:
	bne $s5, 0, checkDrawHot		# random number == 0 means to draw cool
	jal drawCool
	j endDrawDynamicText

checkDrawHot:
	bne $s5, 1, checkDrawWow		# random number == 1 means to draw hot
	jal drawHot
	j endDrawDynamicText

checkDrawWow:
	bne $s5, 2, checkDrawPoggers		# random number == 2 means to draw wow
	jal drawWow
	j endDrawDynamicText
	
checkDrawPoggers:
	bne $s5, 3, checkDrawAwesome		# random number == 3 means to draw poggers
	jal drawPoggers
	j endDrawDynamicText
	
checkDrawAwesome:
	bne $s5, 4, checkDrawAmazing		# random number == 4 means to draw awesome
	jal drawAwesome
	j endDrawDynamicText
	
checkDrawAmazing:				# random number == 5 means to draw amazing
	jal drawAmazing
	j endDrawDynamicText

endDrawDynamicText:
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up

	jr $ra

# drawCool -> draws cool on the screen
drawCool:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address
	
	lw $t0, blue
	sw $t0, textColour
	
	li $a0, 3332
	la $a1, charC
	jal drawChar
	
	li $a0, 3348
	la $a1, charO
	jal drawChar
	
	li $a0, 3364
	la $a1, charO
	jal drawChar
	
	li $a0, 3380
	la $a1, charL
	jal drawChar
	
	li $a0, 3396
	la $a1, exclamation
	jal drawChar
	
	lw $t0, yellow
	sw $t0, textColour
	
endDrawCool:
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
	jr $ra
	
# drawHot -> draws hot on the screen
drawHot:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address
	
	lw $t0, red
	sw $t0, textColour
	
	li $a0, 3332
	la $a1, charH
	jal drawChar
	
	li $a0, 3348
	la $a1, charO
	jal drawChar
	
	li $a0, 3364
	la $a1, charT
	jal drawChar
	
	li $a0, 3380
	la $a1, exclamation
	jal drawChar
	
	lw $t0, yellow
	sw $t0, textColour
	
endDrawHot:	
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
	jr $ra
	
# drawWow -> draws wow on the screen
drawWow:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address
	
	lw $t0, yellow
	sw $t0, textColour
	
	li $a0, 3332
	la $a1, charW
	jal drawChar
	
	li $a0, 3348
	la $a1, charO
	jal drawChar
	
	li $a0, 3364
	la $a1, charW
	jal drawChar
	
	li $a0, 3380
	la $a1, exclamation
	jal drawChar
	
	lw $t0, yellow
	sw $t0, textColour
	
endDrawWow:	
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
	jr $ra
	
# drawPoggers -> draws poggers on the screen
drawPoggers:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address
	
	lw $t0, pink
	sw $t0, textColour
	
	li $a0, 3332
	la $a1, charP
	jal drawChar
	
	li $a0, 3348
	la $a1, charO
	jal drawChar
	
	li $a0, 3364
	la $a1, charG
	jal drawChar
	
	li $a0, 3380
	la $a1, charG
	jal drawChar
	
	li $a0, 3396
	la $a1, charE
	jal drawChar
	
	li $a0, 3412
	la $a1, charR
	jal drawChar
	
	li $a0, 3428
	la $a1, charS
	jal drawChar
	
	li $a0, 3444
	la $a1, exclamation
	jal drawChar
	
	lw $t0, yellow
	sw $t0, textColour
	
endDrawPoggers:
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
	jr $ra
	
# drawAwesome -> draws awesome on the screen
drawAwesome:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address
	
	lw $t0, orange
	sw $t0, textColour
	
	li $a0, 3332
	la $a1, charA
	jal drawChar
	
	li $a0, 3348
	la $a1, charW
	jal drawChar
	
	li $a0, 3364
	la $a1, charE
	jal drawChar
	
	li $a0, 3380
	la $a1, charS
	jal drawChar
	
	li $a0, 3396
	la $a1, charO
	jal drawChar
	
	li $a0, 3412
	la $a1, charM
	jal drawChar
	
	li $a0, 3428
	la $a1, charE
	jal drawChar
	
	li $a0, 3444
	la $a1, exclamation
	jal drawChar
	
	lw $t0, yellow
	sw $t0, textColour
	
endDrawAwesome:
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
	jr $ra
	
# drawAmazing -> draws amazing on the screen
drawAmazing:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address
	
	lw $t0, green
	sw $t0, textColour
	
	li $a0, 3332
	la $a1, charA
	jal drawChar
	
	li $a0, 3348
	la $a1, charM
	jal drawChar
	
	li $a0, 3364
	la $a1, charA
	jal drawChar
	
	li $a0, 3380
	la $a1, charZ
	jal drawChar
	
	li $a0, 3396
	la $a1, charI
	jal drawChar
	
	li $a0, 3412
	la $a1, charN
	jal drawChar
	
	li $a0, 3428
	la $a1, charG
	jal drawChar
	
	li $a0, 3444
	la $a1, exclamation
	jal drawChar
	
	lw $t0, yellow
	sw $t0, textColour
	
endDrawAmazing:
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
	jr $ra

# drawPauseScreen -> draws the pausing screen
drawPauseScreen:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address
	
	lw $t0, orange
	sw $t0, textColour
	
	li $a0, 1680
	la $a1, charP
	jal drawChar
	
	li $a0, 1696
	la $a1, charA
	jal drawChar
	
	li $a0, 1712
	la $a1, charU
	jal drawChar
	
	li $a0, 1728
	la $a1, charS
	jal drawChar
	
	li $a0, 1744
	la $a1, charE
	jal drawChar
	
	li $a0, 1760
	la $a1, charD
	jal drawChar
	
	lw $t0, yellow
	sw $t0, textColour

endDrawPauseScreen:
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
	jr $ra

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
	
	lw $t0, orange
	sw $t0, textColour
	
	li $a0, 2960
	la $a1, charS
	jal drawChar
	
	li $a0, 2976
	la $a1, colon
	jal drawChar
	
	li $a0, 2992
	la $a1, charP
	jal drawChar
	
	li $a0, 3008
	la $a1, charL
	jal drawChar
	
	li $a0, 3024
	la $a1, charA
	jal drawChar
	
	li $a0, 3040
	la $a1, charY
	jal drawChar
	
	lw $t0, yellow
	sw $t0, textColour

endDrawStartScreen:
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up

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

endDrawLevelScreen:
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up
	
	jr $ra
	
# drawGameOver -> draws the text game over on the screen
drawGameOver:
	addi $sp, $sp, -4			# move stack pointer down
	sw $ra, 0($sp)				# push address
	
	lw $t0, orange
	sw $t0, textColour

	li $a0, 1308
	la $a1, charG
	jal drawChar
	
	li $a0, 1328
	la $a1, charA
	jal drawChar
	
	li $a0, 1348
	la $a1, charM
	jal drawChar
	
	li $a0, 1368
	la $a1, charE
	jal drawChar
	
	li $a0, 2204
	la $a1, charO
	jal drawChar
	
	li $a0, 2224
	la $a1, charV
	jal drawChar
	
	li $a0, 2244
	la $a1, charE
	jal drawChar
	
	li $a0, 2264
	la $a1, charR
	jal drawChar
	
	lw $t0, yellow
	sw $t0, textColour
	
endDrawGameOver:
	lw $ra, 0($sp)				# pop address
	addi $sp, $sp, 4			# move stack pointer up

	jr $ra
