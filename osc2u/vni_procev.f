cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      subroutine procevent(tstep)
c
c     Author   : Steffen A. Bass
c     Date     : 06/08/98
c     Revision : 1.0
c
c processes OSCAR event for UrQMD conversion
c
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

      implicit none

      include 'ucoms.f'
      include 'comres.f'

      real*8 pcm,eb,embeam,emtarget
      real*8 gaeq,beeq,galab,belab,ppeq,pteq

      real*8 gam,betx,bety,betz

      real*8 emnuc
      parameter (emnuc = 0.938)

      integer i,pdgid,it,i3,fchg,tstep,nbar_old
      real*8 tmin,deltat,energ,dectim

c set extended output option
      CTOption(41)=1
c set scaling of decay widths to 1
      CTParam(1)=1d0

c fix masses of projectile and target for calculation of pbeam,ecm,pcm
      embeam=Ap*EMNUC
      emtarget=At*EMNUC
c         
      ebeam=Ap*ebeam
      eb=ebeam+embeam
      pbeam=sqrt(ebeam*(ebeam+2.0d0*embeam))
c now do the calculation of equal_speed quantities

      galab=eb/embeam           ! gamma_lab
      belab=pbeam/eb            ! beta_lab
      gaeq=sqrt(0.5*(1+galab))  ! gamma_equal_speed
      beeq=belab*galab/(1+galab) ! beta_equal_speed
      ppeq=gaeq*beeq*embeam     ! p_projectile(eq)
      pteq=-(gaeq*beeq*emtarget) ! p_target(eq)

c reduce to per particle quantities
      ppeq=ppeq/dble(Ap)
      if(At.ne.0) then
         pteq=pteq/dble(At)
         emtarget=emtarget/dble(At)
      endif
      embeam=embeam/dble(Ap)
      pbeam=pbeam/dble(Ap)
      ebeam=ebeam/dble(Ap)
c the following is the NN sqrt(s)
      ecm=sqrt(embeam**2+2*eb/dble(Ap)*emtarget+emtarget**2) 
ccccccccccccccccccccccccccccccccccccccccccccc
c compute transformation betas for output

      pcm=max(1d-10,pbeam*emtarget/ecm)

      if(CTOption(27).eq.0) then
         betann=0.d0
         betatar=pcm/sqrt(pcm**2+emtarget**2)
         betapro=-(1.*pcm/sqrt(pcm**2+embeam**2))
      elseif(CTOption(27).eq.1) then
         betann=-(1*pcm/sqrt(pcm**2+emtarget**2))
         betatar=0.d0
         betapro=-(1*pbeam/sqrt(pbeam**2+embeam**2))
      elseif(CTOption(27).eq.2) then
         betann=pcm/sqrt(pcm**2+emtarget**2)
         betatar=pbeam/sqrt(pbeam**2+embeam**2)
         betapro=0.d0
      endif

cccccccccccccccccccccccccccccccccccccccc

      nbar=0

      do 10 i=1,npart

c convert particle ID
         pdgid=t_ityp(i)
         call pdg2id(it,i3,pdgid)
         t_ityp(i)=it
         t_iso3(i)=i3
c fill baryon slots
         if(abs(t_ityp(i)).le.maxbar) then
            nbar=nbar+1
            ityp(nbar)=t_ityp(i)
            iso3(nbar)=t_iso3(i)
            r0(nbar)=t_r0(i)
            rx(nbar)=t_rx(i)
            ry(nbar)=t_ry(i)
            rz(nbar)=t_rz(i)
            p0(nbar)=t_p0(i)
            px(nbar)=t_px(i)
            py(nbar)=t_py(i)
            pz(nbar)=t_pz(i)
            fmass(nbar)=t_fmass(i)
            tform(nbar)=t_tform(i)
         endif
 10   continue

      nbar_old=nbar

c now fill meson slots
      do 11 i=1,npart
         if(abs(t_ityp(i)).gt.maxbar) then
            nbar=nbar+1
            ityp(nbar)=t_ityp(i)
            iso3(nbar)=t_iso3(i)
            r0(nbar)=t_r0(i)
            rx(nbar)=t_rx(i)
            ry(nbar)=t_ry(i)
            rz(nbar)=t_rz(i)
            p0(nbar)=t_p0(i)
            px(nbar)=t_px(i)
            py(nbar)=t_py(i)
            pz(nbar)=t_pz(i)
            fmass(nbar)=t_fmass(i)
            tform(nbar)=t_tform(i)
         endif
 11   continue
            

      if(nbar.ne.npart) then
         write(0,*) 'bookkeeping error in procev!!!!'
         write(0,*) 'nbar,nmes,npart ',nbar_old,nbar-nbar_old,npart
         stop
      endif

      nmes=nbar-nbar_old
      nbar=nbar_old

      tmin=1d10

c now process urqmd-vectors
      do 101 i=1,npart
         charge(i)=fchg(iso3(i),ityp(i))

c tag particles as input
         origin(i)=99
 
c set decay time for resonances
         dectime(i) = r0(i)+dectim(i)

c set hadronization time 
         thad(i) = r0(i)

c determine earliest freeze-out time
         if(r0(i).lt.tmin) tmin=r0(i)

         betx=px(i)/p0(i)
         bety=py(i)/p0(i)
         betz=pz(i)/p0(i)
         gam=1/sqrt(1d0-(betx**2+bety**2+betz**2))
         

c      write(21,*) (tform(i)-r0(i))*betz+rz(i),tform(i)

c     initialize freeze-out slots
         frr0(i)=r0(i)
         frrx(i)=rx(i)
         frry(i)=ry(i)
         frrz(i)=rz(i)
         frp0(i)=p0(i)
         frpx(i)=px(i)
         frpy(i)=py(i)
         frpz(i)=pz(i)

 101  continue

c      tstep=int(tmin)
      tstep=0

c backpropagate particles
      do 102 i=1,npart

c set special info for prehad. cluster, unformed and formed hadron
c currently available: r0(i)    : hadronization time (absolute)
c                      tform(i) : formation time (absolute)
c                      tmin     : system time (absolute)


c     check for different hadronization times
         deltat   = r0(i)-dble(tstep)
         if(deltat.gt.1d-5) then
c     set formation time to hadronization time
c            tform(i)   = max(r0(i),tform(i))
            xtotfac(i) = 0d0
c     propagate backwards to earliest hadronization time
            energ    = p0(i)
            r0(i)    = dble(tstep)
            rx(i)    = rx(i) - px(i)/energ*deltat
            rz(i)    = rz(i) - pz(i)/energ*deltat
            ry(i)    = ry(i) - py(i)/energ*deltat
         endif


         

 102  continue

      return
      end

