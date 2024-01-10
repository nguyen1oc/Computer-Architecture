

#####################################################
#						    #
#	BATTLE SHIP VER 2.0                         #
#		made by: nguyen1oc		    #
#					            #
#####################################################

.data
name1: .space 256
name2: .space 256
map1:  .space 196
map2:  .space 196
map1_blind: .space 196
map2_blind: .space 196
datacheck: .space 256 
#-1,p1,s5
#-2,p2,s6
#t5 sw
#t7,data
#t6,count
.text
tracking:
	li $s5,-1
	li $s6,-2
	la $t7,datacheck
	li $t6,0
making_map:
	data1: 
	la $t0,map1
	li $t1,49
	
	input1:
	li $t2,0
	beqz $t1,data2
	
	sw $t2,($t0)
	addi $t0,$t0,4
	subi $t1,$t1,1
	
	j input1
	
	data2: 
	la $t0,map1
	li $t1,49
	input2:
	
	li $t2,0
	beqz $t1,data3
	
	sw $t2,($t0)
	addi $t0,$t0,4
	subi $t1,$t1,1
	
	j input2
	
	data3:
	la $t0,map1_blind
	li $t1,49
	input3:
	li $t2,0
	beqz $t1,data4
	
	sw $t2,($t0)
	addi $t0,$t0,4
	subi $t1,$t1,1
	
	j input3
	
	data4:
	la $t0,map2_blind
	li $t1,49
	input4:
	li $t2,0
	beqz $t1,main
	
	sw $t2,($t0)
	addi $t0,$t0,4
	subi $t1,$t1,1
	
	j input4
main:
	#la $t1,map1
	#la $t2,map2
opening:

	li $v0,4
	la $a0,welcome
	syscall
	
	li $v0,4
	la $a0,line
	syscall
	
selection:	

	li $v0,4
	la $a0,chose_mode1
	syscall
	
	li $v0,4
	la $a0,chose_mode2
	syscall
	
	li $v0,4
	la $a0,chose_mode3
	syscall
	
	li $v0,4
	la $a0,choice
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	beq $t0,1,start1
	beq $t0,2,tutorial
	beq $t0,0,bye
	bgt $t0,2,invalid
	blt $t0,0,invalid
	
start1:	
	#player1
	li $v0,4
	la $a0,msg1
	syscall
	
	li $v0,4
	la $a0,line
	syscall
	
	li $v0,4
	la $a0,input_name1
	syscall
	
	li $v0,8
	la $a0,name1
	li $a1,256
	syscall
	
	li $v0,4
	la $a0,intput_name2
	syscall
	
	li $v0,8
	la $a0,name2
	li $a1,256
	syscall
	
	li $v0,4
	la $a0,turn
	syscall
	
	li $v0,4
	la $a0,name1
	syscall
	
	jal setupship4
	
	jal setupship3
	jal setupship3
	
	jal setupship2
	jal setupship2
	jal setupship2
	
	j start2
start2:
	#player2
	li $v0,4
	la $a0,turn
	syscall
	
	li $v0,4
	la $a0,name2
	syscall
	
	jal setupship4.1
	
	jal setupship3.1
	jal setupship3.1
	
	jal setupship2.1
	jal setupship2.1
	jal setupship2.1
	
	j chooseP
	
chooseP:
	li $v0,4
	la $a0,msg2
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	beq $t0,1,P1
	beq $t0,2,P2
	j chooseP
	
P1:	
	li $v0,4
	la $a0,turn
	syscall
	
	li $v0,4
	la $a0,name1
	syscall
	
place_hit.1: #ktra co thang k
	winning:
		windata:
			la $t0,map2
			li $t1,0
			li $s7,1
		win_loop:
			lw $t2,($t0)
			beq $t1,49,ifW
			beq $t2,1,notyet
			j win_conti
				notyet:
					move $s7,$zero
		win_conti:
			addi $t1,$t1,1
			addi $t0,$t0,4
			j win_loop
		ifW:
			beq $s7,1,player1w
setup: #p1 shoot
	move $t5,$s5
	sw $t5,($t7)
	addi $t7,$t7,4
	addi $t6,$t6,1
	
	li $v0,4
	la $a0,shoot1
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	bgt $t0,6,setup
	blt $t0,0,setup
	
	move $t5,$t0
	sw $t5,($t7)
	addi $t7,$t7,4
	addi $t6,$t6,1
	
	li $v0,4
	la $a0,shoot2
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0
	
	bgt $t1,6,setup
	blt $t1,0,setup
	
	move $t5,$t1
	sw $t5,($t7)
	addi $t7,$t7,4
	addi $t6,$t6,1
	
	mul $s1,$t0,7
	add $s1,$s1,$t1
	
	data_hit.1:
		la $t0,map2
		li $t1,0
		
		la $t4,map2_blind
		li $t5,0
	loop_hit.1:
		lw $t2,($t0)
		lw $t3,($t4)
		beq $t1,$s1,check_hit.1
		j hit_cont.1
			check_hit.1:
				beq $t2,1,change_hit.1
				
				li $v0,4
				la $a0,miss
				syscall
				
				move $t3,$s5
				sw $t3,($t4)
				
				jal print_blindmap2
				
				j P2
			change_hit.1:
				move $t2,$zero
				sw $t2,($t0)
				
				move $t3,$s5
				sw $t3,($t4)
				
				li $v0,4
				la $a0,hit
				syscall
				
				jal print_blindmap2
				
				j place_hit.1	
	hit_cont.1:	
		addi $t1,$t1,1
		addi $t0,$t0,4
		
		addi  $t5,$t5,1
		addi $t4,$t4,4
		j loop_hit.1
P2:	
	li $v0,4
	la $a0,turn
	syscall
	
	li $v0,4
	la $a0,name2
	syscall
place_hit: #kiem tra map
	winning.1:
		windata.1:
			la $t0,map1
			li $t1,0
			li $s7,1
		win_loop.1:
			lw $t2,($t0)
			beq $t1,49,ifW.1
			beq $t2,1,notyet.1
			j win_conti.1
				notyet.1:
					move $s7,$zero
		win_conti.1:
			addi $t1,$t1,1
			addi $t0,$t0,4
			j win_loop.1
		ifW.1:
			beq $s7,1,player2w
setup.1:#p2 shoot
	move $t5,$s6
	sw $t5,($t7)
	addi $t7,$t7,4
	addi $t6,$t6,1
	
	li $v0,4
	la $a0,shoot1
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	bgt $t0,6,setup.1
	blt $t0,0,setup.1
	
	move $t5,$t0
	sw $t5,($t7)
	addi $t7,$t7,4
	addi $t6,$t6,1
	
	li $v0,4
	la $a0,shoot2
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0
	
	bgt $t1,6,setup.1
	blt $t1,0,setup.1
	
	move $t5,$t1
	sw $t5,($t7)
	addi $t7,$t7,4
	addi $t6,$t6,1
	
	mul $s1,$t0,7
	add $s1,$s1,$t1
	
	data_hit:
		la $t0,map1
		li $t1,0
		
		la $t4,map1_blind
		li $t5,0
	loop_hit:
		lw $t2,($t0)
		lw $t3,($t4)
		beq $t1,$s1,check_hit
		j hit_cont
			check_hit:
				beq $t2,1,change_hit
				
				move $t3,$s5
				sw $t3,($t4)
				
				li $v0,4
				la $a0,miss
				syscall
				
				jal print_blindmap1
				
				j P1
			change_hit:
				move $t2,$zero
				sw $t2,($t0)
				
				move $t3,$s5
				sw $t3,($t4)
				
				li $v0,4
				la $a0,hit
				syscall
				
				jal print_blindmap1
				
				j place_hit	
	hit_cont:	
		addi $t1,$t1,1
		add $t0,$t0,4
		
		addi  $t5,$t5,1
		addi $t4,$t4,4
		j loop_hit
player1w:
	li $v0,4
	la $a0,msg3
	syscall
	
	li $v0,4
	la $a0,name1
	syscall
	
	j exit
player2w:
	li $v0,4
	la $a0,msg3
	syscall
	
	li $v0,4
	la $a0,name2
	syscall
	
	j exit
tutorial:
	li $v0,4
	la $a0,explain1
	syscall
	
	li $v0,4
	la $a0,explain1.1
	syscall

	li $v0,4
	la $a0,explain1.2
	syscall
	
	li $v0,4
	la $a0,explain1.3
	syscall
	
	li $v0,4
	la $a0,explain1.4
	syscall
	
	li $v0,4
	la $a0,explain1.5
	syscall
	
	li $v0,4
	la $a0,explain1.6
	syscall
	
	li $v0,4
	la $a0,explain1.7
	syscall
	
	li $v0,4
	la $a0,explain1.8
	syscall
	
	li $v0,4
	la $a0,explain2
	syscall
	
	li $v0,4
	la $a0,explain2.1
	syscall
	
	li $v0,4
	la $a0,explain3
	syscall
	
	j selection
invalid:

	li $v0,4
	la $a0,inval
	syscall
	
	j selection
exit:	
	#file data
	open:
	li $v0,13
	la $a0,file
	la $a1,1
	li $a2,0
	syscall
	move $t9, $v0
	
	li $v0,15
	move $a0,$t9
	la $a1,msg4
	li $a2,15
	syscall
	
	li $v0,15
	move $a0,$t9
	la $a1,enter
	li $a2,1
	syscall
		data_move:
		la $t7,datacheck
		loop_data:
			beqz $t6,rerun
			lw $t5,($t7)
			beq $t5,-1,player1turn
			beq $t5,-2,player2turn
				player1turn:
					li $v0,15
					move $a0,$t9
					la $a1,msg5
					li $a2,8
					syscall
	
					li $v0,15
					move $a0,$t9
					la $a1,name1
					li $a2,10
					syscall
					
					li $v0,15
					move $a0,$t9
					la $a1,enter
					li $a2,1
					syscall
					
					li $v0,15
					move $a0,$t9
					la $a1,space
					li $a2,1
					syscall
	
					stillminus:
					subi $t6,$t6,1
					addi $t7,$t7,4
					
					lw $t5,($t7)
					addi $t5,$t5,'0'
					sb $t5,datainfo
					
					li $v0,15
					move $a0,$t9
					la $a1,datainfo
					li $a2,1
					syscall
					
					li $v0,15
					move $a0,$t9
					la $a1,space
					li $a2,1
					syscall
					
					subi $t6,$t6,1
					addi $t7,$t7,4
					
					lw $t5,($t7)
					addi $t5,$t5,'0'
					sb $t5,datainfo
					
					li $v0,15
					move $a0,$t9
					la $a1,datainfo
					li $a2,1
					syscall
					
					subi $t6,$t6,1
					addi $t7,$t7,4
									
					li $v0,15
					move $a0,$t9
					la $a1,enter
					li $a2,2
					syscall
						
					lw $t5,($t7)
					beq $t5,-1,stillminus
																																	
					j loop_data
				player2turn:
					li $v0,15
					move $a0,$t9
					la $a1,msg5
					li $a2,8
					syscall
	
					li $v0,15
					move $a0,$t9
					la $a1,name2
					li $a2,10
					syscall
					
					li $v0,15
					move $a0,$t9
					la $a1,enter
					li $a2,1
					syscall
					
					li $v0,15
					move $a0,$t9
					la $a1,space
					li $a2,1
					syscall
					
					stillminus.1:
					
					subi $t6,$t6,1
					addi $t7,$t7,4
					
					lw $t5,($t7)
					addi $t5,$t5,'0'
					sb $t5,datainfo
					
					li $v0,15
					move $a0,$t9
					la $a1,datainfo
					li $a2,1
					syscall
					
					li $v0,15
					move $a0,$t9
					la $a1,space
					li $a2,1
					syscall
					
					subi $t6,$t6,1
					addi $t7,$t7,4
					
					lw $t5,($t7)
					addi $t5,$t5,'0'
					sb $t5,datainfo
					
					li $v0,15
					move $a0,$t9
					la $a1,datainfo
					li $a2,1
					syscall
					
					subi $t6,$t6,1
					addi $t7,$t7,4
									
					li $v0,15
					move $a0,$t9
					la $a1,enter
					li $a2,2
					syscall
						
					lw $t5,($t7)
					beq $t5,-2,stillminus.1
																																																											
					j loop_data
	
	rerun:
	#close
	li $v0,16
	move $a0,$t9
	syscall
	
	li $v0,4
	la $a0,end
	syscall
	
	li $v0,4
	la $a0,enter
	syscall
	
	j tracking
	
	bye:
	li $v0,4
	la $a0,end
	syscall
	
	li $v0,4
	la $a0,msg6
	syscall
	
	li $v0,10
	syscall
	
	
##################################################3
setupship2.1:
	li $v0,4
	la $a0,x2x1
	syscall
	
	li $v0,5
	syscall 
	move $t0,$v0
	
	bgt $t0,6,setupship2.1
	blt $t0,0,setupship2.1
	
	li $v0,4
	la $a0,y2x1
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0
	
	bgt $t1,6,setupship2.1
	blt $t1,0,setupship2.1
	
	li $v0,4
	la $a0,t2x1
	syscall
	
	li $v0,5
	syscall 
	move $t2,$v0
	
	bgt $t2,6,setupship2.1
	blt $t2,0,setupship2.1
	
	li $v0,4
	la $a0,z2x1
	syscall
	
	li $v0,5
	syscall 
	move $t3,$v0
	
	bgt $t3,6,setupship2.1
	blt $t3,0,setupship2.1
	caculate2.1:
		mul $s1,$t0,7
		add $s1,$s1,$t1
	
		mul $s2,$t2,7
		add $s2,$s2,$t3
		
		move $t8,$s2
			bgt $s1,$s2,swap2.1
			j ship2.1
			swap2.1:
				move $s2,$s1
				move $s1,$t8
		ship2.1:
		beq $t0,$t2,checkR2.1 #equal row
		beq $t1,$t3,checkC2.1 #qual column
		j invalid2.1
setupship3.1:

	li $v0,4
	la $a0,x3x1
	syscall
	
	li $v0,5
	syscall 
	move $t0,$v0
	
	bgt $t0,6,setupship3.1
	blt $t0,0,setupship3.1
	
	li $v0,4
	la $a0,y3x1
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0
	
	bgt $t1,6,setupship3.1
	blt $t1,0,setupship3.1
	
	li $v0,4
	la $a0,t3x1
	syscall
	
	li $v0,5
	syscall 
	move $t2,$v0
	
	bgt $t2,6,setupship3.1
	blt $t2,0,setupship3.1
	
	li $v0,4
	la $a0,z3x1
	syscall
	
	li $v0,5
	syscall 
	move $t3,$v0
	
	bgt $t3,6,setupship3.1
	blt $t3,0,setupship3.1
	caculate1.1:
		mul $s1,$t0,7
		add $s1,$s1,$t1
	
		mul $s2,$t2,7
		add $s2,$s2,$t3
		
		move $t8,$s2
			bgt $s1,$s2,swap3.1
			j ship3.1
			swap3.1:
				move $s2,$s1
				move $s1,$t8
		ship3.1:
		beq $t0,$t2,checkR3.1 #equal row
		beq $t1,$t3,checkC3.1 #qual column
		j invalid3.1	
setupship4.1:
	li $v0,4
	la $a0,x4x1
	syscall
	
	li $v0,5
	syscall 
	move $t0,$v0
	
	bgt $t0,6,setupship4.1
	blt $t0,0,setupship4.1
	
	li $v0,4
	la $a0,y4x1
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0
	
	bgt $t1,6,setupship4.1
	blt $t1,0,setupship4.1
	
	li $v0,4
	la $a0,t4x1
	syscall
	
	li $v0,5
	syscall 
	move $t2,$v0
	
	bgt $t2,6,setupship4.1
	blt $t2,0,setupship4.1
	
	li $v0,4
	la $a0,z4x1
	syscall
	
	li $v0,5
	syscall 
	move $t3,$v0
	
	bgt $t3,6,setupship4.1
	blt $t3,0,setupship4.1
	caculate.1:
		mul $s1,$t0,7
		add $s1,$s1,$t1
	
		mul $s2,$t2,7
		add $s2,$s2,$t3
		
		move $t8,$s2
			bgt $s1,$s2,swap4.1
			j ship4.1
			swap4.1:
				move $s2,$s1
				move $s1,$t8
		ship4.1:
		beq $t0,$t2,checkR4.1 #equal row
		beq $t1,$t3,checkC4.1 #qual column
		j invalid4.1
			checkR4.1:
				sub $s4,$s2,$s1
				beq $s4,3,add4r.1
				j invalid4.1
			checkC4.1:
				real4c.1:
				sub $s4,$s2,$s1
				beq $s4,21,add4c.1
				j invalid4.1
			checkR3.1:
				sub $s4,$s2,$s1
				beq $s4,2,add3r.1
				j invalid3.1
			checkC3.1:
				sub $s4,$s2,$s1
				beq $s4,14,add3c.1
				j invalid3.1
			checkR2.1:
				sub $s4,$s2,$s1
				beq $s4,1,add2r.1
				j invalid2.1
			checkC2.1:
				sub $s4,$s2,$s1
				beq $s4,7,add2c.1
				j invalid2.1
			invalid4.1:
				li $v0,4
				la $a0,inval
				syscall
	
				j setupship4.1
			invalid3.1:
				li $v0,4
				la $a0,inval
				syscall
	
				j setupship3.1
			invalid2.1:
				li $v0,4
				la $a0,inval
				syscall
	
				j setupship2.1
add2c.1:
	data2shipc.1:
		move $s7,$s1
		checking2c.1:
			la $t0,map2
			li $t1,0
			loopCC2.1:
			beq $t1,49,adding2c.1
			li $t3,7
				loop3CC.1:
					lw $t2,($t0)
					beq $t1,$s7,changeCC2.1
				continue2cc.1:
					addi $t0,$t0,4
					subi $t3,$t3,1
					addi $t1,$t1,1
					beqz $t3,part_loopCC2.1
					j loop3CC.1
						changeCC2.1:
							bgt $s7,$s2,continue2cc.1
							beq $t2,1,invalid2.1
							addi $s7,$s7,7
							j continue2cc.1
				part_loopCC2.1:
					j loopCC2.1
		adding2c.1:
			la $t0,map2
			li $t1,0
			loopC2.1:
			lw $t2,($t0)
			beq $t1,49,print_again.1
			li $t3,7
				loop3C.1:
					beq $t1,$s1,changeC2.1
				continue2c.1:
					addi $t0,$t0,4
					subi $t3,$t3,1
					addi $t1,$t1,1
					beqz $t3,part_loopC2.1
					j loop3C.1
						changeC2.1:
							bgt $s1,$s2,continue2c.1
							li $s3,1
							move $t2,$s3
							sw $t2,($t0)
							addi $s1,$s1,7
							j continue2c.1
				part_loopC2.1:
					j loopC2.1
add2r.1:
	data2shipr.1:
		checking2r.1:
			la $t0,map2
			li $t1,0
			loopRR2.1:
			lw $t2,($t0)
			beq $t1,49,adding2r.1
			li $t3,7
				loop3RR.1:
				lw $t2,($t0)
					eeeqqq1.1:bge $t1,$s1,eeeqqq2.1
					j continue2rr.1
					eeeqqq2.1: ble $t1,$s2,changeRR2.1
				continue2rr.1:
				addi $t0,$t0,4
	        		subi $t3,$t3,1
	        		addi $t1,$t1,1
				beqz $t3,part_loopRR2.1
				j loop3RR.1
					changeRR2.1:
						beq $t2,1,invalid2.1
						j continue2rr.1
				part_loopRR2.1:
		        	j loopRR2.1
		adding2r.1:
			la $t0,map2
			li $t1,0
			loopR2.1:
			lw $t2,($t0)
			beq $t1,49,print_again.1
			li $t3,7
				loop3R.1:
					eqqq1.1: bge $t1,$s1,eqqq2.1
					j continue2r.1
					eqqq2.1: ble $t1,$s2,changeR2.1
				continue2r.1:
				addi $t0,$t0,4
	        		subi $t3,$t3,1
	        		addi $t1,$t1,1
				beqz $t3,part_loopR2.1
				j loop3R.1
					changeR2.1:
						li $s3,1
						move $t2,$s3
						sw $t2,($t0)
						j continue2r.1
				part_loopR2.1:
		        	j loopR2.1
add3c.1:
	data3shipc.1:
		move $s7,$s1
		checking3c.1:
			la $t0,map2
			li $t1,0
			loopCC3.1:
			beq $t1,49,adding3c.1
			li $t3,7
				loop2CC.1:
					lw $t2,($t0)
					beq $t1,$s7,changeCC3.1
				continue3cc.1:
					addi $t0,$t0,4
					subi $t3,$t3,1
					addi $t1,$t1,1
					beqz $t3,part_loopCC3.1
					j loop2CC.1
						changeCC3.1:
							bgt $s7,$s2,continue3cc.1
							beq $t2,1,invalid3.1
							addi $s7,$s7,7
							j continue3cc.1
				part_loopCC3.1:
					j loopCC3.1
		adding3c.1:
			la $t0,map2
			li $t1,0
			loopC3.1:
			lw $t2,($t0)
			beq $t1,49,print_again.1
			li $t3,7
				loop2C.1:
					beq $t1,$s1,changeC3.1
				continue3c.1:
					addi $t0,$t0,4
					subi $t3,$t3,1
					addi $t1,$t1,1
					beqz $t3,part_loopC3.1
					j loop2C.1
						changeC3.1:
							bgt $s1,$s2,continue3c.1
							li $s3,1
							move $t2,$s3
							sw $t2,($t0)
							addi $s1,$s1,7
							j continue3c.1
				part_loopC3.1:
					j loopC3.1
add3r.1:
	data3shipr.1:
		checking3r.1:
			la $t0,map2
			li $t1,0
			loopRR3.1:
			lw $t2,($t0)
			beq $t1,49,adding3r.1
			li $t3,7
				loop2RR.1:
				lw $t2,($t0)
					eeqq1.1:bge $t1,$s1,eeqq2.1
					j continue3rr.1
					eeqq2.1: ble $t1,$s2,changeRR3.1
				continue3rr.1:
				addi $t0,$t0,4
	        		subi $t3,$t3,1
	        		addi $t1,$t1,1
				beqz $t3,part_loopRR3.1
				j loop2RR.1
					changeRR3.1:
						beq $t2,1,invalid3.1
						j continue3rr.1
				part_loopRR3.1:
		        	j loopRR3.1
		adding3r.1:
			la $t0,map2
			li $t1,0
			loopR3.1:
			lw $t2,($t0)
			beq $t1,49,print_again.1
			li $t3,7
				loop2R.1:
					eqq.1: bge $t1,$s1,eqq.2
					j continue3r.1
					eqq.2: ble $t1,$s2,changeR3.1
				continue3r.1:
				addi $t0,$t0,4
	        		subi $t3,$t3,1
	        		addi $t1,$t1,1
				beqz $t3,part_loopR3.1
				j loop2R.1
					changeR3.1:
						li $s3,1
						move $t2,$s3
						sw $t2,($t0)
						j continue3r.1
				part_loopR3.1:
		        	j loopR3.1
add4c.1:
	data4shipc.1:
		adding4c.1:
			la $t0,map2
			li $t1,0
			loopC.1:
			lw $t2,($t0)
			beq $t1,49,print_again.1
			li $t3,7
				loop1C.1:
					beq $t1,$s1,changeC.1
				continue4c.1:
					addi $t0,$t0,4
	        			subi $t3,$t3,1
	        			addi $t1,$t1,1
					beqz $t3,part_loopC.1
					j loop1C.1
						changeC.1:
							bgt $s1,$s2,continue4c.1
							li $s3,1
							move $t2,$s3
							sw $t2,($t0)
							addi $s1,$s1,7
							j continue4c.1
				part_loopC.1:
					j loopC.1
add4r.1:
	data4shipr.1:
		#check trung`
		adding4r.1:
			la $t0,map2
			li $t1,0
			loopR.1:
			lw $t2,($t0)
			beq $t1,49,print_again.1
			li $t3,7
				loop1R.1:
					eq1.1: bge $t1,$s1,eq2.1
					j continue4r.1
					eq2.1: ble $t1,$s2,changeR.1
				continue4r.1:
				addi $t0,$t0,4
	        		subi $t3,$t3,1
	        		addi $t1,$t1,1
				beqz $t3,part_loopR.1
				j loop1R.1
					changeR.1:
						li $s3,1
						move $t2,$s3
						sw $t2,($t0)
						j continue4r.1
				part_loopR.1:
		        	j loopR.1
setupship2:

	li $v0,4
	la $a0,x2x1
	syscall
	
	li $v0,5
	syscall 
	move $t0,$v0
	
	bgt $t0,6,setupship2
	blt $t0,0,setupship2
	
	li $v0,4
	la $a0,y2x1
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0
	
	bgt $t1,6,setupship2
	blt $t1,0,setupship2
	
	li $v0,4
	la $a0,t2x1
	syscall
	
	li $v0,5
	syscall 
	move $t2,$v0
	
	bgt $t2,6,setupship2
	blt $t2,0,setupship2
	
	li $v0,4
	la $a0,z2x1
	syscall
	
	li $v0,5
	syscall 
	move $t3,$v0
	
	bgt $t3,6,setupship2
	blt $t3,0,setupship2
	caculate2:
		mul $s1,$t0,7
		add $s1,$s1,$t1
	
		mul $s2,$t2,7
		add $s2,$s2,$t3
		
		move $t8,$s2
			bgt $s1,$s2,swap2
			j ship2
			swap2:
				move $s2,$s1
				move $s1,$t8
		ship2:
		beq $t0,$t2,checkR2 #equal row
		beq $t1,$t3,checkC2 #qual column
		j invalid2
setupship3:

	li $v0,4
	la $a0,x3x1
	syscall
	
	li $v0,5
	syscall 
	move $t0,$v0
	
	bgt $t0,6,setupship3
	blt $t0,0,setupship3
	
	li $v0,4
	la $a0,y3x1
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0
	
	bgt $t1,6,setupship3
	blt $t1,0,setupship3
	
	li $v0,4
	la $a0,t3x1
	syscall
	
	li $v0,5
	syscall 
	move $t2,$v0
	
	bgt $t2,6,setupship3
	blt $t2,0,setupship3
	
	li $v0,4
	la $a0,z3x1
	syscall
	
	li $v0,5
	syscall 
	move $t3,$v0
	
	bgt $t3,6,setupship3
	blt $t3,0,setupship3
	caculate1:
		mul $s1,$t0,7
		add $s1,$s1,$t1
	
		mul $s2,$t2,7
		add $s2,$s2,$t3
		
		move $t8,$s2
			bgt $s1,$s2,swap3
			j ship3
			swap3:
				move $s2,$s1
				move $s1,$t8
		ship3:
		beq $t0,$t2,checkR3 #equal row
		beq $t1,$t3,checkC3 #qual column
		j invalid3	
	
setupship4:

	li $v0,4
	la $a0,x4x1
	syscall
	
	li $v0,5
	syscall 
	move $t0,$v0
	
	bgt $t0,6,setupship4
	blt $t0,0,setupship4
	
	li $v0,4
	la $a0,y4x1
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0
	
	bgt $t1,6,setupship4
	blt $t1,0,setupship4
	
	li $v0,4
	la $a0,t4x1
	syscall
	
	li $v0,5
	syscall 
	move $t2,$v0
	
	bgt $t2,6,setupship4
	blt $t2,0,setupship4
	
	li $v0,4
	la $a0,z4x1
	syscall
	
	li $v0,5
	syscall 
	move $t3,$v0
	
	bgt $t3,6,setupship4
	blt $t3,0,setupship4
	caculate:
		mul $s1,$t0,7
		add $s1,$s1,$t1
	
		mul $s2,$t2,7
		add $s2,$s2,$t3
		
		move $t8,$s2
			bgt $s1,$s2,swap4
			j ship4
			swap4:
				move $s2,$s1
				move $s1,$t8
		ship4:					
		beq $t0,$t2,checkR4 #equal row
		beq $t1,$t3,checkC4 #qual column
		j invalid4
			
			checkR4:
				sub $s4,$s2,$s1
				beq $s4,3,add4r
				j invalid4
			checkC4:
				sub $s4,$s2,$s1
				beq $s4,21,add4c
				j invalid4
			checkR3:
				sub $s4,$s2,$s1
				beq $s4,2,add3r
				j invalid3
			checkC3:
				sub $s4,$s2,$s1
				beq $s4,14,add3c
				j invalid3
			checkR2:
				sub $s4,$s2,$s1
				beq $s4,1,add2r
				j invalid2
			checkC2:
				sub $s4,$s2,$s1
				beq $s4,7,add2c
				j invalid2
			invalid4:
				li $v0,4
				la $a0,inval
				syscall
	
				j setupship4
			invalid3:
				li $v0,4
				la $a0,inval
				syscall
	
				j setupship3
			invalid2:
				li $v0,4
				la $a0,inval
				syscall
	
				j setupship2
add2c:
	data2shipc:
		move $s7,$s1
		checking2c:
			la $t0,map1
			li $t1,0
			loopCC2:
			beq $t1,49,adding3c
			li $t3,7
				loop3CC:
					lw $t2,($t0)
					beq $t1,$s7,changeCC2
				continue2cc:
					addi $t0,$t0,4
					subi $t3,$t3,1
					addi $t1,$t1,1
					beqz $t3,part_loopCC2
					j loop3CC
						changeCC2:
							bgt $s7,$s2,continue2cc
							beq $t2,1,invalid2
							addi $s7,$s7,7
							j continue2cc
				part_loopCC2:
					j loopCC2
		adding2c:
			la $t0,map1
			li $t1,0
			loopC2:
			lw $t2,($t0)
			beq $t1,49,print_again
			li $t3,7
				loop3C:
					beq $t1,$s1,changeC2
				continue2c:
					addi $t0,$t0,4
					subi $t3,$t3,1
					addi $t1,$t1,1
					beqz $t3,part_loopC2
					j loop3C
						changeC2:
							bgt $s1,$s2,continue2c
							li $s3,1
							move $t2,$s3
							sw $t2,($t0)
							addi $s1,$s1,7
							j continue2c
				part_loopC2:
					j loopC2
add2r:

	data2shipr:
		checking2r:
			la $t0,map1
			li $t1,0
			loopRR2:
			lw $t2,($t0)
			beq $t1,49,adding2r
			li $t3,7
				loop3RR:
				lw $t2,($t0)
					eeeqqq1:bge $t1,$s1,eeeqqq2
					j continue2rr
					eeeqqq2: ble $t1,$s2,changeRR2
				continue2rr:
				addi $t0,$t0,4
	        		subi $t3,$t3,1
	        		addi $t1,$t1,1
				beqz $t3,part_loopRR2
				j loop3RR
					changeRR2:
						beq $t2,1,invalid2
						j continue2rr
				part_loopRR2:
		        	j loopRR2
		adding2r:
		
			la $t0,map1
			li $t1,0
			loopR2:
			lw $t2,($t0)
			beq $t1,49,print_again
			li $t3,7
				loop3R:
					eqqq1: bge $t1,$s1,eqqq2
					j continue2r
					eqqq2: ble $t1,$s2,changeR2
				continue2r:
				addi $t0,$t0,4
	        		subi $t3,$t3,1
	        		addi $t1,$t1,1
				beqz $t3,part_loopR2
				j loop3R
					changeR2:
						li $s3,1
						move $t2,$s3
						sw $t2,($t0)
						j continue2r
				part_loopR2:
		        	j loopR2
add3c:

	data3shipc:
		move $s7,$s1
		checking3c:
			la $t0,map1
			li $t1,0
			loopCC3:
			beq $t1,49,adding3c
			li $t3,7
				loop2CC:
					lw $t2,($t0)
					beq $t1,$s7,changeCC3
				continue3cc:
					addi $t0,$t0,4
					subi $t3,$t3,1
					addi $t1,$t1,1
					beqz $t3,part_loopCC3
					j loop2CC
						changeCC3:
							bgt $s7,$s2,continue3cc
							beq $t2,1,invalid3
							addi $s7,$s7,7
							j continue3cc
				part_loopCC3:
					j loopCC3
		adding3c:
			la $t0,map1
			li $t1,0
			loopC3:
			lw $t2,($t0)
			beq $t1,49,print_again
			li $t3,7
				loop2C:	
					beq $t1,$s1,changeC3
				continue3c:
					addi $t0,$t0,4
					subi $t3,$t3,1
					addi $t1,$t1,1
					beqz $t3,part_loopC3
					j loop2C
						changeC3:
							bgt $s1,$s2,continue3c
							li $s3,1
							move $t2,$s3
							sw $t2,($t0)
							addi $s1,$s1,7
							j continue3c
				part_loopC3:
					j loopC3
add3r:

	data3shipr:
		checking3r:
			la $t0,map1
			li $t1,0
			loopRR3:
			lw $t2,($t0)
			beq $t1,49,adding3r
			li $t3,7
				loop2RR:
				lw $t2,($t0)
					eeqq1:bge $t1,$s1,eeqq2
					j continue3rr
					eeqq2: ble $t1,$s2,changeRR3
				continue3rr:
				addi $t0,$t0,4
	        		subi $t3,$t3,1
	        		addi $t1,$t1,1
				beqz $t3,part_loopRR3
				j loop2RR
					changeRR3:
						beq $t2,1,invalid3
						j continue3rr
				part_loopRR3:
		        	j loopRR3
		adding3r:
			la $t0,map1
			li $t1,0
			loopR3:
			lw $t2,($t0)
			beq $t1,49,print_again
			li $t3,7
				loop2R:
					eqq1: bge $t1,$s1,eqq2
					j continue3r
					eqq2: ble $t1,$s2,changeR3
				continue3r:
				addi $t0,$t0,4
	        		subi $t3,$t3,1
	        		addi $t1,$t1,1
				beqz $t3,part_loopR3
				j loop2R
					changeR3:
						li $s3,1
						move $t2,$s3
						sw $t2,($t0)
						j continue3r
				part_loopR3:
		        	j loopR3
add4c:

	data4shipc:
		adding4c:
			la $t0,map1
			li $t1,0
			loopC:
			lw $t2,($t0)
			beq $t1,49,print_again
			li $t3,7
				loop1C:
					beq $t1,$s1,changeC
				continue4c:
					addi $t0,$t0,4
	        			subi $t3,$t3,1
	        			addi $t1,$t1,1
					beqz $t3,part_loopC
					j loop1C
						changeC:
							bgt $s1,$s2,continue4c
							li $s3,1
							move $t2,$s3
							sw $t2,($t0)
							addi $s1,$s1,7
							j continue4c
				part_loopC:
					j loopC
add4r:
	data4shipr:	
		adding4r:
			la $t0,map1
			li $t1,0
			loopR:
			lw $t2,($t0)
			beq $t1,49,print_again
			li $t3,7
				loop1R:
					eq1: bge $t1,$s1,eq2
					j continue4r
					eq2: ble $t1,$s2,changeR
				continue4r:
				addi $t0,$t0,4
	        		subi $t3,$t3,1
	        		addi $t1,$t1,1
				beqz $t3,part_loopR
				j loop1R
					changeR:
						li $s3,1
						move $t2,$s3
						sw $t2,($t0)
						j continue4r
				part_loopR:
		        	j loopR
print_again:
	li $t4,0
	
	li $v0,4
	la $a0,msg7
	syscall
	
	li $v0,4
	la $a0,line1
	syscall
	
	la $t0,map1
	li $t1,0
	loopM:
	lw $t2,($t0)
	beq $t1,49,exit_func
	li $t3,7
	loopM2:
		lw $t2,($t0)	
		li $v0,4
		la $a0,tab
		syscall
		
		li $v0,1
		move $a0,$t2
		syscall
		
		li $v0,4
		la $a0,space
		syscall	
		
		addi $t0,$t0,4
	        subi $t3,$t3,1
	        addi $t1,$t1,1
		beqz $t3,part_loopM
		j loopM2
	part_loopM:
	li $v0,4
	la $a0,line2
	syscall
	
	li $v0,1
	move $a0,$t4
	syscall
	
	add $t4,$t4,1
	
	li $v0,4
	la $a0,enter
	syscall	
	j loopM
	
print_again.1:
	li $t4,0
	
	li $v0,4
	la $a0,msg7
	syscall
	
	li $v0,4
	la $a0,line1
	syscall
	
	la $t0,map2
	li $t1,0
	loopM.1:
	lw $t2,($t0)
	beq $t1,49,exit_func
	li $t3,7
	loopM2.1:
	
		lw $t2,($t0)	
		li $v0,4
		la $a0,tab
		syscall
		
		li $v0,1
		move $a0,$t2
		syscall
		
		li $v0,4
		la $a0,space
		syscall	
		
		addi $t0,$t0,4
	        subi $t3,$t3,1
	        addi $t1,$t1,1
		beqz $t3,part_loopM.1
		j loopM2.1
	part_loopM.1:
	li $v0,4
	la $a0,line2
	syscall
	
	li $v0,1
	move $a0,$t4
	syscall
	
	add $t4,$t4,1
	
	li $v0,4
	la $a0,enter
	syscall	
	j loopM.1
	
print_blindmap2:
	li $t4,0
	
	li $v0,4
	la $a0,msg7
	syscall
	
	li $v0,4
	la $a0,line1
	syscall
	
	la $t0,map2_blind
	li $t1,0
	loop_blind2:
	lw $t2,($t0)
	beq $t1,49,exit_func
	li $t3,7
	loop_blind22:
		lw $t2,($t0)	
		li $v0,4
		la $a0,tab
		syscall
		
		li $v0,1
		move $a0,$t2
		syscall
		
		li $v0,4
		la $a0,space
		syscall	
		
		addi $t0,$t0,4
	        subi $t3,$t3,1
	        addi $t1,$t1,1
		beqz $t3,part_loopBlind2
		j loop_blind22
	part_loopBlind2:
	li $v0,4
	la $a0,line2
	syscall
	
	li $v0,1
	move $a0,$t4
	syscall
	
	add $t4,$t4,1
	
	li $v0,4
	la $a0,enter
	syscall	
	j loop_blind2
	
print_blindmap1:
	li $t4,0
	
	li $v0,4
	la $a0,msg7
	syscall
	
	li $v0,4
	la $a0,line1
	syscall
	
	la $t0,map1_blind
	li $t1,0
	loop_blind1:
	lw $t2,($t0)
	beq $t1,49,exit_func
	li $t3,7
	loop_blind11:
		lw $t2,($t0)	
		li $v0,4
		la $a0,tab
		syscall
		
		li $v0,1
		move $a0,$t2
		syscall
		
		li $v0,4
		la $a0,space
		syscall	
		
		addi $t0,$t0,4
	        subi $t3,$t3,1
	        addi $t1,$t1,1
		beqz $t3,part_loopBlind1
		j loop_blind11
	part_loopBlind1:
	li $v0,4
	la $a0,line2
	syscall
	
	li $v0,1
	move $a0,$t4
	syscall
	
	add $t4,$t4,1
	
	li $v0,4
	la $a0,enter
	syscall	
	j loop_blind1
exit_func:
	jr $ra
.data 

#BackGround
welcome: .asciiz"WELCOME TO BATTLE SHIP GAMEEEEEEE!!!!!" 
line: .asciiz "\n--------------------------------------"
end: .asciiz"Thank for trying Battle Ship"
inval: .asciiz"INVALID VALUEEEEEEEE\n"
chose_mode1: .asciiz"\nPress 1 to start the game"
chose_mode2: .asciiz"\nPress 2 to read tutorial" 
chose_mode3: .asciiz"\nPress 0 to exit" 	
choice: .asciiz"\nYour seclection: " 
msg1: .asciiz"Hope you enjoy the game!! "
msg2: .asciiz"Chose who play first(1:player1, 2:player2): "
msg3: .asciiz"The winner is: "
msg4: .asciiz"Tracking moves: "
msg5: .asciiz"Turn of " 
msg6: .asciiz"\nSee you again next time !!"
msg7: .asciiz  "	   0	   1	   2	   3	   4	   5	   6\n"
line1: .asciiz "	   --------------------------------------------------\n" 
line2: .asciiz "|	"
space: .asciiz " "
tab: .asciiz "	   "
enter: .asciiz "\n"
##########################################
#Tutorial
explain1:  .asciiz"1. Each player sets up a fleet of battle ships on their map (7x7). A fleet of ships consists of 3 2x1 ships, 2 3x1 ships and 1 4x1 ships."
explain1.1:.asciiz"\n   A map look like this:"
explain1.2:.asciiz"\n          0 0 0 0 0 0 0"
explain1.3:.asciiz"\n          0 0 0 0 0 0 0"
explain1.4:.asciiz"\n          0 0 0 0 0 0 0"
explain1.5:.asciiz"\n          0 0 0 0 0 0 0"
explain1.6:.asciiz"\n          0 0 0 0 0 0 0"
explain1.7:.asciiz"\n          0 0 0 0 0 0 0"
explain1.8:.asciiz"\n          0 0 0 0 0 0 0"
explain2: .asciiz"\n2. After the ships have been postioned, the game proceeds in a series of rounds. In each round, each player takes aturn to choose a place to shoot."
explain2.1:.asciiz"\n   Computuer will annouces if its correct or not by sending message HIT"
explain3: .asciiz"\n3. If all ships of players have been sunk, the game is over and their opponent wins."
#########################################
#PLaying
input_name1: .asciiz"\nEnter name of player1: "
intput_name2: .asciiz"Enter name of player2: "
shoot1: .asciiz"Choose where to shoot (row): "
shoot2: .asciiz"Choose where to shoot (column: "
hit: .asciiz"HITTTTTTTTTTTTT\n"
miss: .asciiz"MISS!!\n"
turn: .asciiz "Your turn, "
x4x1:.asciiz "Enter cordinates row (bow) of the 4x1 ship: "
y4x1:.asciiz "Enter cordinates column(bow) of the 4x1 ship: "
t4x1:.asciiz "Enter cordinates row (stern) of the 4x1 ship: "
z4x1:.asciiz "Enter cordinates column(stern) of the 4x1 ship: "
###
x3x1:.asciiz "Enter cordinates row (bow) of the 3x1 ship: "
y3x1:.asciiz "Enter cordinates column(bow) of the 3x1 ship: "
t3x1:.asciiz "Enter cordinates row (stern) of the 3x1 ship: "
z3x1:.asciiz "Enter cordinates column(stern) of the 3x1 ship: "
###
x2x1:.asciiz "Enter cordinates row (bow) of the 2x1 ship: "
y2x1:.asciiz "Enter cordinates column(bow) of the 2x1 ship: "
t2x1:.asciiz "Enter cordinates row (stern) of the 2x1 ship: "
z2x1:.asciiz "Enter cordinates column(stern) of the 2x1 ship: "
#data_tracking
file: .asciiz "C:/data/datamovement.txt"
datainfo: .word 1
