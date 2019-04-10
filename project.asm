				.data

choice:			.word 		0
result:			.word 		0

can:			.space		"Giap", "At", "Binh", "Dinh", "Mau", "Ky", "Canh", "Tan", "Nham", "Quy"
chi:			.space		"Ty", "Suu", "Dan", "Meo", "Thin", "Ty", "Ngo", "Mao", "Than", "Dau", "Tuat", "Hoi"

TIME:			.space		40		
TIME_1:			.space		40
TIME_2:			.space		40

new_line:		.asciiz		"\n"

input_day: 		.asciiz		"Nhap ngay DAY: "
input_month: 	.asciiz		"Nhap thang MONTH: "
input_year:		.asciiz		"Nhap nam YEAR: "

intro_string: 	.asciiz		"----------Ban hay chon 1 trong cac thao tac duoi day----------\n"

first_choice:	.asciiz		"1. Xuat chuoi TIME theo dinh dang DD/MM/YYYY\n"

second_choice:	.asciiz		"2. Chuyen doi chuoi TIME thanh mot trong cac dinh dang sau:\n"
sec_choice_a:	.asciiz		"			A. MM/DD/YYYY\n"
sec_choice_b:	.asciiz		"			B. Month DD, YYYY\n"
sec_choice_c:	.asciiz		"			C. DD Month, YYYY\n"

third_choice:	.asciiz		"3. Kiem tra nam trong chuoi TIME co phai la nam nhuan khong.\n"
output_leap_yr:	.asciiz		"Nam nhap vao la nam nhuan.\n"
output_n_lp_yr:	.asciiz		"Nam nhap vao khong phai la nam nhuan.\n"

fourth_choice: .asciiz		"4. Cho biet ngay vua nhap la ngay thu may trong tuan.\n"
monday:						.asciiz		"Mon.\n"
tuesday:					.asciiz		"Tues.\n"
wednesday:					.asciiz		"Wed.\n"
thursday:					.asciiz		"Thurs.\n"
friday:						.asciiz		"Fri.\n"
saturday:					.asciiz		"Sat.\n"
sunday:						.asciiz		"Sun.\n"

fifth_choice:	.asciiz		"5. Cho biet ngay vua nhap la ngay thu may ke tu ngay 1/1/1.\n"
sub_fifth_choice:			.asciiz		"Ngay vua nhap la ngay thu "

sixth_choice:	.asciiz		"6. Cho biet can chi cua nam vua nhap.\n"

seventh_choice:	.asciiz		"7. Cho biet khoang thoi gian giua chuoi TIME_1 va TIME_2.\n"
sub_seventh_choice:			.asciiz		"Khoang thoi gian giua hai chuoi la: "

eighth_choice:	.asciiz		"8. Cho biet 2 nam nhuan gan nhat voi nam trong chuoi TIME.\n"
sub_eighth_choice1:			.asciiz		"Hai nam nhuan gan nhat la "
sub_eighth_choice2:			.asciiz		" va "

ninth_choice:	.asciiz		"9. Nhap input tu file input.txt xuat ket qua toan bo cac chuc nang tren ra file output.txt.\n"

input_choice:	.asciiz		"			Lua chon: "
invalid_choice:	.asciiz		"Lua chon khong hop le. Vui long nhap lai.\n"

output_result:	.asciiz		"			Ket qua: "

				.text
main:			

print_tasks:
			addi $v0, $0, 4
			la $a0, intro_string
			syscall

			li $v0, 4
			la $a0, first_choice
			syscall

			addi $v0, $zero, 4
			la $a0, second_choice
			syscall
			li $v0, 4
			la $a0, sec_choice_a
			syscall
			addi $v0, $0, 4
			la $a0, sec_choice_b
			syscall
			li $v0, 4
			la $a0, sec_choice_c
			syscall

			addi $v0, $zero, 4
			la $a0, third_choice
			syscall

			li $v0, 4
			la $a0, fourth_choice
			syscall

			addi $v0, $zero, 4
			la $a0, sixth_choice
			syscall

			li $v0, 4
			la $a0, seventh_choice
			syscall

			addi $v0, $zero, 4
			la $a0, eighth_choice
			syscall

			li $v0, 4
			la $a0, seventh_choice
			syscall

exit:
	li $v0, 10
	syscall