# Copyright:	Public domain.
# Filename:	KEYRUPT_UPRUPT.agc
# Purpose:	Part of the source code for Colossus, build 249.
#		It is part of the source code for the Command Module's (CM)
#		Apollo Guidance Computer (AGC), possibly for Apollo 8 and 9.
# Assembler:	yaYUL
# Reference:	Starts on p. 1439 of 1701.pdf.
# Contact:	Ron Burkey <info@sandroid.org>.
# Website:	www.ibiblio.org/apollo.
# Mod history:	08/30/04 RSB.	Adapted from corresponding Luminary131 file.
#
# The contents of the "Colossus249" files, in general, are transcribed 
# from a scanned document obtained from MIT's website,
# http://hrst.mit.edu/hrs/apollo/public/archive/1701.pdf.  Notations on this
# document read, in part:
#
#	Assemble revision 249 of AGC program Colossus by NASA
#	2021111-041.  October 28, 1968.  
#
#	This AGC program shall also be referred to as
#				Colossus 1A
#
#	Prepared by
#			Massachusetts Institute of Technology
#			75 Cambridge Parkway
#			Cambridge, Massachusetts
#	under NASA contract NAS 9-4065.
#
# Refer directly to the online document mentioned above for further information.
# Please report any errors (relative to 1701.pdf) to info@sandroid.org.
#
# In some cases, where the source code for Luminary 131 overlaps that of 
# Colossus 249, this code is instead copied from the corresponding Luminary 131
# source file, and then is proofed to incorporate any changes.

# Page 1439
		BANK	14
		SETLOC	KEYRUPT
		BANK
		COUNT*	$$/KEYUP

KEYRUPT1	TS	BANKRUPT
		XCH	Q
		TS	QRUPT
		TC	LODSAMPT	# TIME IS SNATCHED IN RUPT FOR NOUN 65.
		CAF	LOW5
		EXTEND
		RAND	MNKEYIN		# CHECK IF KEYS 5M-1M ON
KEYCOM		TS	RUPTREG4
		CS	FLAGWRD5
		MASK	BIT15
		ADS	FLAGWRD5

ACCEPTUP	CAF	CHRPRIO		# (NOTE: RUPTREG4 = KEYTEMP1)
		TC	NOVAC
		EBANK=	DSPCOUNT
		2CADR	CHARIN

		CA	RUPTREG4
		INDEX	LOCCTR
		TS	MPAC		# LEAVE 5 BIT KEY CODE IN MPAC FOR CHARIN
		TC	RESUME

# Page 1440
# UPRUPT PROGRAM

UPRUPT		TS	BANKRUPT
		XCH	Q
		TS	QRUPT
		TC	LODSAMPT	# TIME IS SNATCHED IN RUPT FOR NOUN 65.
		CAF	ZERO
		XCH	INLINK
		TS	KEYTEMP1
		CAF	BIT3		# TURN ON UPACT LIGHT
		EXTEND			# (BIT 3 OF CHANNEL 11)
		WOR	DSALMOUT
UPRPT1		CAF	LOW5		# TEST FOR TRIPLE CHAR REDUNDANCY
		MASK	KEYTEMP1	# LOW5 OF WORD
		XCH	KEYTEMP1	# LOW5 INTO KEYTEMP1
		EXTEND
		MP	BIT10		# SHIFT RIGHT 5
		TS	KEYTEMP2
		MASK	LOW5		# MID 5
		AD	HI10
		TC	UPTEST
		CAF	BIT10
		EXTEND
		MP	KEYTEMP2	# SHIFT RIGHT 5
		MASK	LOW5		# HIGH 5
		COM
		TC	UPTEST

UPCK		CS	ELRCODE		# CODE IS GOOD.  IF CODE = `ERROR RESET',
		AD	KEYTEMP1	# CLEAR UPLOCKFL (SET BIT4 OF FLAGWRD7 = 0)
		EXTEND			# IF CODE DOES NOT = `ERROR RESET', ACCEPT
		BZF	CLUPLOCK	# CODE ONLY IF UPLOCKFL IS CLEAR (=0).

		CAF	BIT4		# TEST UPLOCKFL FOR 0 OR 1
		MASK	FLAGWRD7
		CCS	A
		TC	RESUME		# UPLOCKFL = 1
		TC	ACCEPTUP	# UPLOCKFL = 0

CLUPLOCK	CS	BIT4		# CLEAR UPLOCKFL (I.E., SET BIT 4 OF
		MASK	FLAGWRD7	# FLAGWRD7 = 0)
		TS	FLAGWRD7
		TC	ACCEPTUP

					# CODE IS BAD
TMFAIL2		CS	FLAGWRD7	# LOCK OUT FURTHER UPLINK ACTIVITY
		MASK	BIT4		# (BY SETTING UPLOCKFL = 1) UNTIL
		ADS	FLAGWRD7	# `ERROR RESET' IS SENT VIA UPLINK.
		TC	RESUME
UPTEST		AD	KEYTEMP1
# Page 1441
		CCS	A
		TC	TMFAIL2
HI10		OCT	77740
		TC	TMFAIL2
		TC	Q

ELRCODE		OCT	22

# `UPLINK ACTIVITY LIGHT' IS TURNED OFF BY .....
#	1.	VBRELDSP
#	2.	ERROR RESET
#	3.	UPDATE PROGRAM (P27) ENTERED BY V70,V71,V72, AND V73.
#
# THE RECEPTION OF A BAD CODE (I.E., CCC FAILURE) LOCKS OUT FURTHER UPLINK ACTIVITY BY SETTING BIT4 OF FLAGWRD7 = 1.
# THIS INDICATION WILL BE TRANSFERRED TO THE GROUND BY THE DOWNLINK WHICH DOWNLINKS ALL FLAGWORDS.
# WHEN UPLINK ACTIVITY IS LOCKED OUT, IT CAN BE ALLOWED WHEN THE GROUND UPLINS AND `ERROR RESET' CODE.
# (IT IS RECOMMENDED THAT THE `ERROR LIGHT RESET' CODE IS PRECEEDED BY 16 BITS THE FIRST OF WHICH IS 1 FOLLOWED
# BY 15 ZEROS.  THIS WILL ELIMINATE EXTRANEOUS BITS FROM INLINK WHICH MAY HAVE BEEN LEFT OVER FROM THE ORIGINAL
# FAILURE).
#
# UPLINK ACTIVITY IS ALSO ALLOWED (UNLOCKED) DURING FRECH START WHEN FRESH START SETS BIT4 OF FLAGWRD7 = 0.


