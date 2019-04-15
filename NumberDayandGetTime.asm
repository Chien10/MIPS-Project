.data
	tb: .asciiz "Nhap ngay thang nam: "
	tb1: .asciiz "\nNgay: "
	tb2: .asciiz "\nThang: "
	tb3: .asciiz "\nNam: "
	tb4: .asciiz "/"
	menuu: .asciiz "Nhap kieu dinh dang 1.DD/MM/YYYY 2.MM/DD/YYYY 3.YYYY/MM/DD 4.Thoat: "

	output1: .asciiz "DD/MM/YYYY: "
	output2: .asciiz "MM/DD/YYYY: "
	output3: .asciiz "YYYY/MM/DD: "
	
	TIME:	.space 1024
	TIME_1:	.space 1024
	TIME_2:	.space 1024
	
	day:	.space 1024
	month:	.space 1024
	year:	.space 1024
.text	
main:
	#nhapchuoi TIME
	li $v0,4
	la $a0,tb
	syscall
		
	li $v0,8
	la $a0,TIME_1
	la $a1,1024
	syscall
	
	li $v0,8
	la $a0,TIME_2
	la $a1,1024
	syscall
	
	jal GetTime
	move $t0,$v0
	
	li $v0,1
	la $a0,($t0)
	syscall
	li $v0,10
	syscall
atoi:
	li $v0, 0
	#Backup
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a0, 4($sp)
	sw $t0, 8($sp)
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
	
	la $a0,TIME_1
	jal NumberDay
	move $t0,$v0
	
	la $a0,TIME_2
	jal NumberDay
	move $t1,$v0
	
	sub $v0,$t1,$t0
	li $t2,365
	div $v0,$t2
	mflo $v0
	
	GetTime.Exit:
	lw $ra,($sp)
	lw $a0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	addi $sp,$sp,16
	jr $ra
	
	
	
	


	



	
	
	
	

	
