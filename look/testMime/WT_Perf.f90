PROGRAM WT_Perf


! This program is a variable speed version of a much-modified
! version of the original PROP code by Aerovironment Inc.


USE                                NWTC_Output
USE                                NWTC_Subs
USE                                Parameters
USE                                ProgGen
USE                                ProgMod
USE                                Precision
USE                                SysSubs
USE                                WTP_Data
USE                                WTP_Subs

IMPLICIT                           NONE


! Local declarations.

REAL(ReKi)                      :: TimerBeg                                        ! Timer start time.
REAL(ReKi)                      :: TimerEnd                                        ! Timer end time.



! Get date and time.

DateNow = CurDate()
TimeNow = CurTime()


! Reopen the console for FORTRAN carriage control.

CALL OpenCon


! Print out program name, version, and date.

CALL SetProg
CALL DispNVD


! Initialize file system.

CALL IOInit


! Get input data.

CALL GetData


! If appropriate, open the blade-element data file and generatte the header.

IF ( WriteBED )  THEN
    CALL OpenFOutFile ( UnBE, TRIM( RootName )//'.bed' )

    WRITE (UnBE,'(A)')  'Blade-element data generated by '//TRIM( ProgName )//TRIM( ProgVer )//' for input file "' &
    //TRIM( InpFile )//'".'
    WRITE (UnBE,'(A)')  'Generated on '//TRIM( DateNow )//' at '//TRIM( TimeNow )//'.'
    WRITE (UnBE,'(A)')  'Input file title:'
    WRITE (UnBE,'(A)')  '  '//TRIM( RunTitle )
    WRITE (UnBE,'(A)')  ' '
ENDIF


! Calculate some constants.

SweptRad = RotorRad*CosCone
SwpRadIn = 1.0/SweptRad
SwptArea = Pi*SweptRad*SweptRad
HalfRho  = 0.5*Rho

CALL WrScr ( ' ' )


! Start timer.

TimerBeg = UserTime()


! What type of analysis do we do?

IF ( NumCases == 0 )  THEN            ! Do old-style parametric analysis if number of combined cases is zero.
    CALL ParmAnal
ELSE                                  ! Do new-style combined cases.

    CALL CombCase

ENDIF


! Stop timer

TimerEnd = UserTime()


! Close the output files.

CLOSE ( UnOu )

IF ( WriteBED )  CLOSE ( UnBE )


! Display timer if non-zero.

IF ( TimerEnd > 0.0 )  CALL WrScr1 ( 'Main loop used '//TRIM( Flt2LStr( TimerEnd ) )//' seconds of User CPU time.' )


! Display the number of iteration failures.

IF ( NmItFail == 1 )  THEN
    CALL WrScr ( ' ' )
    CALL Abort ( 'There was one case that failed to converge.' )
    ELSEIF ( NmItFail > 1 )  THEN
    CALL WrScr ( ' ' )
    CALL Abort ( 'There were '//TRIM( Int2LStr( NmItFail ) )//' cases that failed to converge.' )
ENDIF


! Normal termination.

CALL NormStop


STOP
END PROGRAM WT_Perf