ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      real*8 function dectim(ind)
c
c     Unit     : Collision Term
c     Author   : Steffen A. Bass, adapted from urqmd dectim
c     Date     : 06/08/98
c     Revision : 1.0
C
cinput ind : ID of particle
couput dectim: time of decay
c
c     This function computes a random choice for the time at which
c     a resonance will decay and transformes it to the computational
c     frame.
c
c
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC 
      implicit none
      include 'ucoms.f'   

      integer ind
      real*8 gg,wid,tau,ranf,widit
c
cspez
      if(ityp(ind).eq.99) then
         dectim=1d34
         return
      endif

c first determine width of resonace
c     fixed width
         wid=widit(ityp(ind))*CTParam(1)

C  ...  REST FRAME DECAY TIME
      if(WID .GT. 1.d-10) then
c     "normal" life time tau=1/gamma
            TAU=-(dLOG(1.d0-RANF(0))/WID)
      ELSE          
c     stable particle
         DECTIM=1.d34
         RETURN
      END IF
C  ...  APPLY TIME DILATION
C  ...  GAMMA FOR THE RESONANCE RESTFRAME <-> COMP. FRAME TRAFO  
      gg=p0(ind)/fmass(ind)
      DECTIM=TAU*GG*hqc

      RETURN
      END
