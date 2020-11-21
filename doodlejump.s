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
red: .word 0xff0000
green: .word 0x00ff00
blue: .word 0x008080
yellow: .word 0xffff00
leftKey: .word 0x6A
rightKey: .word 0x6B
restartKey: .word 0x73
platformSize: .word 8
platformA: .space 8
platformB: .space 8
platformC: .space 8

.globl main
.text

main:
	jal drawBackground
	jal drawGameOver

end:
	li $v0, 10				# end program
	syscall
	
# drawBackground -> fills in every unit of the bitmap display with the colour blue
drawBackground:
	li $t0, 0				# i = 0
	lw $t1, displayUnits			# $t1 = displayUnits
	lw $t2, displayAddress			# $t2 = displayAddress
	lw $t3, blue				# $t3 = blue
	mult $t1, $t1				# lastUnit = displayUnits * displayUnits
	mflo $t1
	
drawBackgroundLoop:				# while (i < endAddress)
	bge $t0, $t1, drawBackgroundEnd		# if (i >= endAddress) then exit loop
	sw $t3, 0($t2)				# colour unit at displayAddress
	addi $t2, $t2, 4			# displayAddress++
	addi $t0, $t0, 1			# i++
	j drawBackgroundLoop			# loop
	
drawBackgroundEnd:
	jr $ra					# return

# drawGameOver -> draws the text game over on the screen
drawGameOver:
	lw $t0, displayAddress			# $t0 = displayAddress
	lw $t1, yellow 				# $t1 = yellow
	
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