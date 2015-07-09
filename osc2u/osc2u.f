Ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      program o2u
c
c     Author   : Steffen A. Bass
c     Date     : 06/05/98
c
c     oscar to urqmd file14 converter
c                    
c     input : oscar file (stdin)
c             
c
c     output: urqmd file14 (fort.14)
c
c
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
c
      implicit none
      include 'ucoms.f'

      integer iret,tstep,procev,i



      character*1 echar
      

      procev=0

      write(6,*)
      write(6,*)' OSCAR to UrQMD converter    (c) Steffen A. Bass 1998'
      write(6,*)

cccccccc array initializations  ccccccccccccccccc

      call sseed(123987)

      do 111 i=1,numcto
         CTOdc(i)='  '
 111  continue
      do 112 i=1,numctp
         CTPdc(i)='  '
 112  continue

c default settings for CTParam and CTOption cccccccccccccccccccccccccccccc
      CTParam(1)=1.d0  
      CTParam(2)=0.52d0 
      CTParam(3)=.5d0 
      CTParam(4)=0.3d0 
      CTParam(5)=0d0 
      CTParam(6)=0.37d0    
      CTParam(7)=0.d0 
      CTParam(8)=0.093d0 
      CTParam(9)=0.35d0 
      CTParam(10)=0.25d0 
      CTParam(11)=0.d0 
      CTParam(12)=.5d0  
      CTParam(13)=.27d0 
      CTParam(14)=.49d0 
      CTParam(15)=.27d0 
      CTParam(16)=1.0d0 
      CTParam(17)=1.6d0 
      CTParam(18)=.85d0 
      CTParam(19)=1.55d0
      CTParam(22)=1.0d0
      CTParam(25)=.9d0 
      CTParam(26)=50d0 
      CTParam(27)=1d0 
      CTParam(28)=1d0 
      CTParam(29)=0.4 
      CTParam(30)=1.5 
      CTParam(31)=1.6d0 
      CTParam(32)=0d0
      CTParam(33)=2.5d0
      CTParam(34)=0.1
      CTParam(35)=3.0
      CTParam(36)=0.275d0
      CTParam(37)=0.42d0
      CTParam(38)=1.08d0
      CTParam(39)=0.8d0
      CTParam(40)=0.5d0
      CTParam(41)=0.0
      CTParam(42)=0.55d0
      CTParam(43)=5.d0
      CTParam(44)=.8d0
      CTParam(45)=0.5
      CTParam(46)=800000
      CTParam(47)=1.0
      CTParam(48)=2.0

      CTParam(50)=1d0 
      CTParam(51)=1d0 
      CTParam(52)=1d0
      CTParam(53)=1d0
      CTParam(54)=1d0 
      CTParam(55)=1d0
      CTParam(56)=1d0
      CTParam(57)=1d0
      CTParam(58)=1.d0
      CTOption(1)=0  
      CTOption(2)=0
      CTOption(3)=0  
      CTOption(4)=0  
      CTOption(5)=0  
      CTOption(6)=0  
      CTOption(7)=0  
      CTOption(8)=0  
      CToption(9)=0  
      CTOption(10)=0 
      CTOption(11)=0 
      CTOption(12)=0 
      CTOption(13)=0 
      CTOption(14)=0 
      CTOption(15)=0 
      CTOption(16)=0 
      CTOption(17)=0 
      CTOption(18)=0 
      CTOption(19)=0  
      CTOption(20)=0
      CTOption(21)=0
      CTOption(22)=1
      CTOption(23)=0
      CTOption(24)=1
      CTOption(25)=0
      CTOption(26)=0
      CTOption(27)=0 
      CTOption(28)=0
      CTOption(29)=2
      CTOption(30)=1
      CTOption(31)=0
      CTOption(32)=0
      CTOption(33)=0
      CTOption(34)=1
      CTOption(35)=1
      CTOption(36)=0
      CTOption(37)=0
      CTOption(38)=0
      CTOption(39)=0
      CTOption(40)=0
      CTOption(41)=0
      CTOption(42)=0
      CTOption(43)=0

ccccccccccccccccccccccccccccccccccccccccccccccccc

      call read_osc_header(iret)
      if(iret.eq.0) stop

 1    continue

      call read_osc_event(iret)
      if(iret.eq.0) stop

cdebug
c      if(procev.gt.100) stop

      procev=procev+1

cdebug
c      if(procev.le.101) goto 1


c     process the event
      call procevent(tstep)




      call write_uheader(14)
      call file14out(tstep)

      write(6,*) 'processing event # ',procev


      goto 1

      stop
      end

ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      subroutine write_uheader(iunit)

      implicit none

      include 'ucoms.f'
      include 'comres.f'

c
      integer iunit,i,ttime,out_time
      integer id
      integer itotcoll,iinelcoll
      real*8 sigmatot,otime


      character*20 aa,ah,ai,ak
      character*36 ae,abt
      character*31 aee
      character*15 ab,aj,al,am
      character*13 ac,ag,pds,tds
      character*12 ad
      character*7 af
      character*9 ag2
      character*1 add
      character*171 apav
      character*2 apa,aop


     
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c              output formats
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c
c fileheader
 101  format(a20,3i7,a15,i2)
 301  format(a13,a13,i4,i4,a12,a13,i4,i4,a1)
c 305  format(a36,3f10.7)
 304  format(a36,3f6.2,a31,1f9.2)
 302  format (a7,i9,a13,i12,a9,a20,i7,a20,f11.3)
c 303  format(a20,i3,a15,e10.4,a15,e10.4,a15,e10.4)
 102  format(a2,15(i3,a2))
c 103  format(a2,12(e10.4,a2))
 306  format(a171)

 305  format(a36,3f11.7)
 303  format(a20,i3,a15,e11.4,a15,e11.4,a15,e11.4)
 103  format(a2,12(e11.4,a2))


csab changed e16.8 to D24.16
c standard particle information vector
 201  format(9e16.8,i11,2i3,i9,i5,i4)
cLHC 201  format(9e24.16,i11,2i3,i9,i5,i4)

c special output for cto40 (restart of old event)
 210  format(9e16.8,i11,2i3,i9,i5,i10,3e16.8,i8)

c collsision stats for file14
 202  format(8i8)
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c

c
      aa='UQMD   version:     '
      ab='  output_file '
      abt='transformation betas (NN,lab,pro) '
      ac='projectile:  '
      ad='   target: '
      add=' '
      ae='impact_parameter_real/min/max(fm):  '
      aee='  total_cross_section(mbarn):  '
      af='event# '
      ag=' random seed:' 
      ah='equation_of_state: '
      ai=' total_time(fm/c): '
      aj='  E_lab(GeV/u):'
      ak=' Delta(t)_O(fm/c): '
      al='  sqrt(s)(GeV):'
      am='  p_lab(GeV/u):'
      apa='pa'
      aop='op'

      apav='pvec: '//
     & 'r0              rx              ry              rz          '//
     & '    p0              px              py              pz      '//
     & '        m          ityp 2i3 chg lcl#  ncl or'    
      

      ag2=' readin  '
         
      pds='(mass, char) '
      tds='(mass, char) '


c cross section of the projectile-target system not given in oscar
      sigmatot = 0d0
ccccccccccccccccccccccccccccccccccccccccccccccccccccc

      otime=0.d0
      ttime=0

      write(14,101) aa,version, sigver, laires, ab,iunit
      write(14,301) ac,pds, Ap, Zp, ad,tds, At, Zt,add       
      write(14,305) abt,betann,betatar,betapro
      write(14,304) ae,bimp,bmin,bdist,aee,sigmatot
      write(14,303) ah,eos,aj,ebeam,al,ecm,am,pbeam
      write(14,302) af,event,ag,ranseed,ag2,ai,ttime,ak,otime
      write(14,102) aop,(CTOption(i),CTOdc(i),i=1,15)
      write(14,102) aop,(CTOption(i),CTOdc(i),i=16,30)
      write(14,102) aop,(CTOption(i),CTOdc(i),i=31,45)
      write(14,103) apa,(CTParam(i),CTPdc(i),i=1,12)
      write(14,103) apa,(CTParam(i),CTPdc(i),i=13,24)
      write(14,103) apa,(CTParam(i),CTPdc(i),i=25,36)
      write(14,103) apa,(CTParam(i),CTPdc(i),i=37,48)
      write(14,306) apav
c 
      return

cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      entry file14out(out_time)
c
c     Unit     : Collision Term
c     Author   : Steffen A. Bass (new source)
c     Date     : 01/09/95
c     Revision : 0.1 beta - uncompleted
c
c     This subroutine writes the standard output-file (unit 14)
c                    
c     input : 
c             timestep  : timestep of output
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
c

c

      itotcoll=ctag-dectag
      iinelcoll=itotcoll-NBlColl-NElColl
      write(14,*) npart,out_time
      write(14,202) itotcoll,NElColl,iinelcoll,NBlColl,dectag,
     @     NHardRes,NSoftRes,NDecRes

c now write particle-output

      do 31 i=1,npart
         write(14,210) r0(i),rx(i),ry(i),rz(i),p0(i),
     @        px(i),py(i),
     @        pz(i),fmass(i),
     @        ityp(i),iso3(i),charge(i),
     @        lstcoll(i),ncoll(i),origin(i),
     @        dectime(i),thad(i),xtotfac(i)

 31   continue

c 
      return
      end
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      subroutine read_osc_header(iret)

      implicit none
      include 'ucoms.f'

      character*12 oscar_tag, file_tag
      character*8 model_tag, version_tag
      character*1 cdummy1
      character*3 cdummy3
      character*4 reffram
      integer ntestp,iret
      
      iret=1

      read (unit=5,fmt=901,err=199,end=199) oscar_tag
      read (unit=5,fmt=901,err=199,end=199) file_tag

 901  format (a12)


      read (unit=5,fmt=902,err=199,end=199) 
     &             model_tag, version_tag, cdummy1, Ap, cdummy1, 
     &             Zp, cdummy3, At, cdummy1, Zt, cdummy1,
     &             reffram, ebeam, ntestp

      if (reffram .eq. 'eqsp') then
         CTOption(27)=0
      elseif (reffram .eq. 'tar') then
         CTOption(27)=1
      elseif (reffram .eq. 'pro') then
         CTOption(27)=2
      endif


 902  format (2(a8,2x),a1,i3,a1,i6,a3,i3,a1,i6,a1,2x,a4,2x,
     &     e10.4,2x,i8)

      return
 199  continue
      iret=0
      write(6,*) 'ERROR/EOF encountered while reading OSCAR fileheader'
      write(6,*) '   ... terminating  '
      return

      end

cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      subroutine read_osc_event(iret)

      implicit none
      include 'ucoms.f'

      integer i,j,iret
      real*8 dummy

      iret=1
      
      read (unit=5,fmt=903,err=299,end=299) event, npart, bimp, dummy

 903  format (i10,2x,i10,2x,f8.3,2x,f8.3)

c particles

      do 99 i=1,npart
         read(5,904) j, t_ityp(i), 
     .        t_px(i), t_py(i), t_pz(i), t_p0(i), t_fmass(i),     
     .        t_rx(i), t_ry(i), t_rz(i), t_r0(i), t_tform(i)
 99   continue

 904  format (i10,2x,i10,2x,10(D24.16,2x))

c      here now id to ityp/iso3/charge conversion must take place

      return

 299  continue
      iret=0
      write(6,*) 'ERROR/EOF encountered while reading OSCAR event'
      write(6,*) '   ... terminating  '
      return

      end



