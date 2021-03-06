.data
	TIME:	.space 1024
	day:	.space 1024
	month:	.space 1024
	year:	.space 1024
	option:	.space	4
	comma:	.word	','
	slash:	.word	'/'
	space:	.word	' '
	MM_1:	.asciiz	"01"
	MM_2:	.asciiz	"02"
	MM_3:	.asciiz	"03"
	MM_4:	.asciiz	"04"
	MM_5:	.asciiz	"05"
	MM_6:	.asciiz	"06"
	MM_7:	.asciiz	"07"
	MM_8:	.asciiz	"08"
	MM_9:	.asciiz	"09"
	MM_10:	.asciiz	"10"
	MM_11:	.asciiz	"11"
	MM_12:	.asciiz	"12"
	Month_1:	.asciiz	"January"
	Month_2:	.asciiz	"Febuaray"
	Month_3:	.asciiz	"March"
	Month_4:	.asciiz	"April"
	Month_5:	.asciiz	"May"
	Month_6:	.asciiz	"June"
	Month_7:	.asciiz	"July"
	Month_8:	.asciiz	"August"
	Month_9:	.asciiz	"September"
	Month_10:	.asciiz	"October"
	Month_11:	.asciiz	"November"
	Month_12:	.asciiz	"December"
	ntf_2:	.asciiz	"Chuyen chuoi thanh 1 trong cac dinh dang sau:\n\tA. MM/DD/YYYY\n\tB. Month DD, YYYY\n\tC. DD Month, YYYY\n"
.text
main:
	#Input string time (default format)
	li $v0, 8
	la $a0, TIME
	la $a1, 1024
	syscall
	
	jal NumberDay
	move $t0,$v0
	#Print converted time string
	li $v0, 1
	la $a0,($t0)
	syscall
	
	#Exit program
	li $v0, 10
	syscall


#LIST FUNCTIONS:
#	+ fill_blank_string(): fill blank string
#	+ atoi():	convert string to int
#	+ convert_MM_to_Month():	convert MM to Month
#	+ push_string_to_string(): str1 = str1 + str2
#	+ convert_format_string(): FEATURE 2 OF PROJECT



#Function to fill blank string
#INPUT:	$a0: save address of string need to fill blank
#OUTPUT:	$a0: save address of string after filling blank
fill_blank_string:
	#Backup
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a0, 4($sp)
	sw $t0, 8($sp)
	#Loop fill '\0'
	fill_blank_string.loop:
	lb $t0, ($a0)
	beq $t0, '\n', fill_blank_string.exit
	beq $t0, '\0', fill_blank_string.exit
	li $t0, 0
	sb $t0, ($a0)
	addi $a0, $a0, 1
	j fill_blank_string.loop
	#Exit loop
	fill_blank_string.exit:
	#Restore
	lw $ra, ($sp)
	lw $a0, 4($sp)
	lw $t0, 8($sp)
	addi $sp, $sp, 12
	#Back
	jr $ra
#End function fill_blank_string()


#Function to convert string to number
#INPUT: $a0: save address of string
#OUTPUT: $v0: save value into int
atoi:
#Backup
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a0, 4($sp)
	sw $t0, 8($sp)
	li $v0, 0
atoi_loop:
	
	lb $t0, ($a0)
	beq $t0, '\n', atoi_finish
	beq $t0, '\0', atoi_finish
		
	mul $v0, $v0, 10
	addi $t0, $t0, -48	
	add $v0, $v0, $t0
	addi $a0, $a0, 1
	j atoi_loop
atoi_finish:
	#Restore
	lw $ra, ($sp)
	lw $a0, 4($sp)
	lw $t0, 8($sp)
	addi $sp, $sp, 12
	jr $ra
#End function atoi()


#Convert string month "DD" format to "Month" format
#INUPPUT:	$a0: save address of string month
#OUTPUT:	$a0: save address of string month after convert
convert_MM_to_Month:
	#Backup
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a0, 4($sp)
	sw $t0, 8($sp)
	#Covert string month to int
	la $a0, month
	jal atoi
	#Empty string month before call function push_string_to_string()
	la $a0, month
	jal fill_blank_string
	#Branch month value to convert
	beq $v0, 1, convert_MM_to_Month.convert_01
	beq $v0, 2, convert_MM_to_Month.convert_02
	beq $v0, 3, convert_MM_to_Month.convert_03
	beq $v0, 4, convert_MM_to_Month.convert_04
	beq $v0, 5, convert_MM_to_Month.convert_05
	beq $v0, 6, convert_MM_to_Month.convert_06
	beq $v0, 7, convert_MM_to_Month.convert_07
	beq $v0, 8, convert_MM_to_Month.convert_08
	beq $v0, 9, convert_MM_to_Month.convert_09
	beq $v0, 10, convert_MM_to_Month.convert_10
	beq $v0, 11, convert_MM_to_Month.convert_11
	beq $v0, 12, convert_MM_to_Month.convert_12
	convert_MM_to_Month.convert_01:
		la $a1, Month_1
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_02:
		la $a1, Month_2
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_03:
		la $a1, Month_3
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_04:
		la $a1, Month_4
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_05:
		la $a1, Month_5
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_06:
		la $a1, Month_6
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_07:
		la $a1, Month_7
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_08:
		la $a1, Month_8
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_09:
		la $a1, Month_9
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_10:
		la $a1, Month_10
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_11:
		la $a1, Month_11
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_12:
		la $a1, Month_12
		j convert_MM_to_Month.exit
	convert_MM_to_Month.exit:
	jal push_string_to_string
	#Restore
	lw $ra, ($sp)
	lw $a0, 4($sp)
	lw $t0, 8($sp)
	addi $sp, $sp, 12
	#Back
	jr $ra
#End function convert_MM_to_Month()
	
	
#Pushing string 2 to end-of-line of string 1	(Code C: str1 = str1 + str2)
#INPUT:
#	$a0 save address of string 1
#	$a1 save address of string 2
#OUTPUT:	$a0 save address of string 1 after pushing string 2
push_string_to_string:
	#Backup
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a0, 4($sp)
	sw $t0, 8($sp)
	#Moving index of string 1 to end-of-line
	push_string_to_string.string1.moveEOL.loop:
	lb $t0, ($a0)
	beq $t0, '\0', push_string_to_string.string1.moveEOL.exit
	beq $t0, '\n', push_string_to_string.string1.moveEOL.exit
	addi $a0, $a0, 1	#Increase index
	j push_string_to_string.string1.moveEOL.loop
	push_string_to_string.string1.moveEOL.exit:
	#Pushing 
	push_string_to_string.string2.push.loop:
	lb $t0, ($a1)
	beq $t0, '\0', push_string_to_string.string2.push.exit
	beq $t0, '\n', push_string_to_string.string2.push.exit
	sb $t0, ($a0)	#push letter
	addi $a0, $a0, 1	# address str_1 ++
	addi $a1, $a1, 1	# address str_2 ++
	j push_string_to_string.string2.push.loop
	push_string_to_string.string2.push.exit:
	#Restore
	lw $ra, ($sp)
	lw $a0, 4($sp)
	lw $t0, 8($sp)
	addi $sp, $sp, 12
	#Back
	jr $ra
#End function push_string_to_string()


#Function to format string time
#INPUT: $a0: save address of string time
#OUTPUT: $a0: save address of string time after coverting
convert_format_time:
	#Backup
	addi $sp, $sp, -16
	sw $ra, ($sp)
	sw $t0, 4($sp)
	sw $a0, 8($sp)
	sw $a1, 12($sp)
	#Get day string (to string 'day')
	lb $t0, ($a0)
	sb $t0, day+0
	lb $t0, 1($a0)
	sb $t0, day+1
	li $t0, '\n'
	sb $t0, day+2
	#Get month string (to string 'month')
	lb $t0, 3($a0)
	sb $t0, month+0
	lb $t0, 4($a0)
	sb $t0, month+1
	li $t0, '\n'
	sb $t0, month+2
	#Get year string (to string 'year')
	lb $t0, 6($a0)
	sb $t0, year+0
	lb $t0, 7($a0)
	sb $t0, year+1
	lb $t0, 8($a0)
	sb $t0, year+2
	lb $t0, 9($a0)
	sb $t0, year+3
	li $t0, '\n'
	sb $t0, year+4
	#Show notification of feature 2
	li $v0, 4
	la $a0, ntf_2
	syscall
	#Read option convert
	li $v0, 8
	la $a0, option
	la $a1, 4
	syscall
	#Branch option format
	lb $t0, option
	beq $t0, 'A', convert_format_time.format_A
	beq $t0, 'B', convert_format_time.format_B
	beq $t0, 'C', convert_format_time.format_C
	#Convert to format A
	convert_format_time.format_A:
		la $a0, TIME
		jal fill_blank_string
		la $a1, month
		jal push_string_to_string
		la $a1, slash
		jal push_string_to_string
		la $a1, day
		jal push_string_to_string
		la $a1, slash
		jal push_string_to_string
		la $a1, year
		jal push_string_to_string
		#Exit
		j convert_format_time.exit
	#Convert to format B
	convert_format_time.format_B:
		la $a0, month
		jal convert_MM_to_Month
		move $a1, $a0
		la $a0, TIME
		jal fill_blank_string
		jal push_string_to_string
		la $a1, space
		jal push_string_to_string
		la $a1, day
		jal push_string_to_string
		la $a1, comma
		jal push_string_to_string
		la $a1, space
		jal push_string_to_string
		la $a1, year
		jal push_string_to_string
		#Exit
		j convert_format_time.exit
	#Convert to format C
	convert_format_time.format_C:
		la $a0, TIME
		jal fill_blank_string
		la $a1, day
		jal push_string_to_string
		la $a1, space
		jal push_string_to_string
		la $a0, month
		jal convert_MM_to_Month
		move $a1, $a0
		la $a0, TIME
		jal push_string_to_string
		la $a1, comma
		jal push_string_to_string
		la $a1, space
		jal push_string_to_string
		la $a1, year
		jal push_string_to_string
		#Exit
		j convert_format_time.exit
	#Exit function convert_format_time()
	convert_format_time.exit:
	#Restore
	lw $ra, ($sp)
	lw $t0, 4($sp)
	lw $a0, 8($sp)
	lw $a1, 12($sp)
	addi $sp, $sp, 16
	#Back
	jr $ra
#End function convert_format_time()


Convert_Time_To_DMY:
	#backup
	addi $sp,$sp,-4
	sw $ra,($sp)
	#Get day string (to string 'day')
	lb $t6, ($a0)
	sb $t6, day+0
	lb $t6, 1($a0)
	sb $t6, day+1
	li $t6, '\n'
	sb $t6, day+2
	
	#Get month string (to string 'month')
	lb $t6, 3($a0)
	sb $t6, month+0
	lb $t6, 4($a0)
	sb $t6, month+1
	li $t6, '\n'
	sb $t6, month+2
	
	#Get year string (to string 'year')
	lb $t6, 6($a0)
	sb $t6, year+0
	lb $t6, 7($a0)
	sb $t6, year+1
	lb $t6, 8($a0)
	sb $t6, year+2
	lb $t6, 9($a0)
	sb $t6, year+3
	li $t6, '\n'
	sb $t6, year+4
Convert_Time_To_DMY.Exit:
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
DMY_To_Int:
	#Retore s0=day(int),s1=month(int),s2(year)
	#backup
	addi $sp,$sp,-4
	sw $ra,($sp)
	
	la $a0,day
	jal atoi
	move $s0,$v0
	
	la $a0,month
	jal atoi
	move $s1,$v0
	
	la $a0,year
	jal atoi
	move $s2,$v0
DMY.Exit:
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
	
#End function atoi()
NumberDay:
#Input a0<-TIME
#Output SoNgay t? 1/1/1
	#backup
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $t0,16($sp)
	sw $t4,20($sp)
	sw $t5,24($sp)
	sw $t6,28($sp)
	jal Convert_Time_To_DMY
	jal DMY_To_Int
	

	bge $s1,3,NumberDay.Do #thang >=3
	addi $s2,$s2,-1
	addi $s1,$s1,12 
	NumberDay.Do:
	li $t5,365
	mul $t0,$s2,$t5 #t0=year *365
	mflo $t0
	li $t5,4
	div $s2,$t5 #year/4
	mflo $t1 #t1=year/4
	li $t5,100
	div $s2,$t5
	mflo $t2 #t2=year/100
	li $t5,400
	div $s2,$t5
	mflo $t3 #t3=year/400
	li $t5,153
	mul $s1,$s1,$t5
	mflo $s1
	subi $t4,$s1,457
	li $t5,5
	div $t4,$t5
	mflo $t4 #t4=(153*month-4457)/5
	####Tong ngay
	add $t0,$t0,$t1
	sub $t0,$t0,$t2
	add $t0,$t0,$t3
	add $t0,$t0,$t4
	add $t0,$t0,$s0
	subi $t0,$t0,306
	addi $t0,$t0,-1	
	move $v0,$t0
	j NumberDay.Exit
	#exit
	NumberDay.Exit:
	lw $t4,20($sp)
	lw $t5,24($sp)
	lw $t6,28($sp)
	lw $t0,16($sp)	
	lw $s0,12($sp)
	lw $s1,8($sp)
	lw $s2,4($sp)
	lw $ra,($sp)
	addi $sp,$sp,32
	jr $ra
	
GetTime:
	#backup
	addi $sp,$sp,-16
	sw $ra,($sp)
	sw $a0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	
	#la $a0,TIME_1
	#jal NumberDay
	#move $t0,$v0
	
	#la $a0,TIME_2
	#jal NumberDay
	#move $t1,$v0
	
	sub $v0,$t1,$t0
	
	GetTime.Exit:
	lw $ra,($sp)
	lw $a0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	addi $sp,$sp,16
	jr $ra
	
	
