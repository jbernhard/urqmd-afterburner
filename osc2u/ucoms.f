c $Id: coms.f,v 1.7 1997/08/26 13:18:46 bass Exp $
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

      integer nmax
      parameter (nmax = 200000)


      integer Ap, At, Zp, Zt, npart, nbar, nmes, ctag
      integer nsteps,ranseed,event,eos,dectag
      integer NHardRes,NSoftRes,NDecRes,NElColl,NBlColl
      real*8  time,  acttime, bdist, ebeam, bimp,bmin,ecm
c 7 integer

      common /sys/ npart, nbar, nmes, ctag,nsteps,
     +             ranseed,event,Ap,At,Zp,Zt,eos,dectag,
     +             NHardRes,NSoftRes,NDecRes,NElColl,NBlColl
      common /rsys/ time,acttime,bdist,bimp,bmin,ebeam,ecm



      integer spin(nmax),ncoll(nmax),charge(nmax),strid(nmax),
     +        ityp(nmax),lstcoll(nmax),iso3(nmax),origin(nmax),
     +        t_ityp(nmax),t_iso3(nmax)

c 6*nmax integer

      real*8 eps, er0, pi, rho0,hqc
      parameter (eps  = 1.0E-12,
     +           er0  = 1.128379167,
     +           pi   = 3.1415926535,
     +           rho0 = 0.16,
     +           hqc  = 0.197327)

      integer version, laires
      parameter ( version = 10000,
     +            laires  = 10001)


      real*8 
     +     r0(nmax), rx(nmax), ry(nmax), rz(nmax),
     +     p0(nmax), px(nmax), py(nmax), pz(nmax),
     +     fmass(nmax), 
     +     t_r0(nmax), t_rx(nmax), t_ry(nmax), t_rz(nmax),
     +     t_p0(nmax), t_px(nmax), t_py(nmax), t_pz(nmax),
     +     t_fmass(nmax), t_tform(nmax),
     +     dectime(nmax), tform(nmax), xtotfac(nmax), thad(nmax)

c 8*nmax*nmax + 40*nmax real*8        
      
      common/isys/spin,ncoll,charge,ityp,lstcoll,iso3,origin,strid,
     &            t_ityp,t_iso3
      common /coor/ r0, rx, ry, rz, p0, px, py, pz, fmass, dectime,
     &              t_r0,t_rx,t_ry,t_rz,t_p0,t_px,t_py,t_pz,t_fmass
      common /frag/ tform, xtotfac, t_tform, thad

      integer numcto,numctp
      parameter(numcto=400,numctp=400)
c...
      integer   CTOption(numcto)
      character ctodc(numcto)*2
c...
      real*8    CTParam(numctp)
      character ctpdc(numctp)*2

      common /options/CTOption,CTParam
      common /optstrings/ctodc,ctpdc

      real*8  pbeam,betann,betatar,betapro

      common /input2/ pbeam,betann,betatar,betapro


      real*8 frr0(nmax), frrx(nmax), frry(nmax), frrz(nmax),
     +     frp0(nmax), frpx(nmax), frpy(nmax), frpz(nmax)

c 8*nmax*nmax + 40*nmax real*8        
      
      common /frcoor/ frr0, frrx, frry, frrz, frp0, frpx, frpy, frpz




      
