TITLE	lab01
;Programmer:	Marcus Ross
;Due:		21 Feb,  2014
;Description:	This program uses hardcoded values for expenses and sales to calculate profit.

	.MODEL SMALL
	.286
	.STACK 64
;==========================
	.DATA
moSale	DW	785, 842, 518	;monthly sales
moOpExp	DW	268, 304, 243	;monthly operating expenses
moPayExp	DW	179, 254, 97	;monthly payroll expenses
qtInvCst	DW	397		;quarterly inventory costs
qtTotRet	DW	217		;quarterly total returns
grSale	DW	?		;gross sales
totExp	DW	?		;total expenses
netSale	DW	?		;net sales
profit	DW	?		;profit
;==========================
	.CODE
Main	PROC	NEAR
	mov	ax, @data	;init data
	mov	ds, ax		;segment register

	call	GetGross		;compute total gross sales
	call	GetExpen		;compute total expenses
	call	GetNet		;compute net sales
	call	GetProf		;compute profit

	mov	ax, 4c00h	;return code 0
	int	21h		;4c = exit

Main	ENDP
;==========================
GetGross	PROC	NEAR
	mov	ax, moSale	;prepare to add to monthly sales
	add	ax, [moSale + 2]
	add	ax, [moSale + 4]
	mov	grSale, ax	;store sum of sales in gross sales
	ret
GetGross	ENDP
;==========================
GetExpen	PROC	NEAR
	mov	ax, moOpExp		;prepare to add to monthly operating expenses
	add	ax, [moOpExp + 2]
	add	ax, [moOpExp + 4]
	add	ax, moPayExp		;add payroll expenses to sum operating expenses
	add	ax, [moPayExp + 2]
	add	ax, [moPayExp + 4]
	mov	totExp, ax		;store sum of expenses in total expenses 
	ret
GetExpen	ENDP
;==========================
GetNet	PROC	NEAR
	mov	ax, grSale	;prepare to subtract from gross sales
	sub	ax, totExp
	mov	netSale, ax	;store difference between sales and expenses in net sales
	ret
GetNet	ENDP
;==========================
GetProf	PROC	NEAR
	sub	ax, qtInvCst	;ax has net sales still--subtract costs from net sales
	sub	ax, qtTotRet
	mov	profit, ax	;store resultant in profit
	ret
GetProf	ENDP

	END	Main