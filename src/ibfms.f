	INTEGER FUNCTION IBFMS ( R8VAL )

C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C
C SUBPROGRAM:    IBFMS
C   PRGMMR: J. ATOR          ORG: NP12       DATE: 2007-01-19
C
C ABSTRACT: THIS FUNCTION TESTS WHETHER THE INPUT VALUE IS EQUIVALENT
C   TO THE BUFR ARCHIVE LIBRARY "MISSING" VALUE.  THE USE OF INTEGER
C   RETURN CODES ALLOWS THIS FUNCTION TO BE CALLED IN A LOGICAL
C   CONTEXT FROM A CALLING PROGRAM WRITTEN IN C.
C
C PROGRAM HISTORY LOG:
C 2007-01-19  J. ATOR    -- ORIGINAL AUTHOR
C 2009-03-23  J. ATOR    -- INCREASED VALUE OF BDIFD FOR BETTER 
C                           TEST ACCURACY
C 2012-10-05  J. ATOR    -- MODIFIED TO REFLECT THE FACT THAT THE
C                           "MISSING" VALUE IS NOW CONFIGURABLE BY
C                           USERS (MAY BE SOMETHING OTHER THAN 10E10)
C
C USAGE:    IBFMS ( R8VAL )
C   INPUT ARGUMENT LIST:
C     R8VAL    - REAL*8: VALUE TO BE TESTED FOR EQUIVALENCE TO 
C                BUFR ARCHIVE LIBRARY "MISSING" VALUE
C
C   OUTPUT ARGUMENT LIST:
C     IBFMS    - INTEGER: RETURN CODE:
C                0 - R8VAL IS NOT EQUIVALENT TO "MISSING"
C                1 - R8VAL IS EQUIVALENT TO "MISSING"
C
C REMARKS:
C    THIS ROUTINE CALLS:        None
C    THIS ROUTINE IS CALLED BY: INVMRG   STRBTM   UFBDMP   UFBRW
C                               UFDUMP   WRTREE
C                               Also called by application programs.
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 77
C   MACHINE:  PORTABLE TO ALL PLATFORMS
C
C$$$

	INCLUDE	'bufrlib.prm'

	REAL*8		R8VAL

C----------------------------------------------------------------------
C----------------------------------------------------------------------

	IF ( R8VAL .EQ. BMISS ) THEN
	    IBFMS = 1
	ELSE
	    IBFMS = 0
	ENDIF

	RETURN
	END
