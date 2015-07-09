c $Id: comres.f,v 1.9 1997/08/26 13:18:44 bass Exp $
      integer maxbar,maxbra,minbar
      integer offmeson,maxmeson,pimeson,maxbrm,minnuc,mindel
      integer maxbrs1,maxbrs2
      integer numnuc,numdel,nucleon,maxnuc,maxdel
      integer minmes,maxmes


      parameter (minnuc=1)
      parameter (minmes=100,maxmes=132)

c number of resonances of a kind
      parameter (numnuc=16,numdel=10)
c indices of minimal & maximal itype of a kind (redundant but nice)
      parameter (maxnuc=minnuc+numnuc-1)
      parameter (mindel=minnuc+maxnuc)
      parameter (maxdel=mindel+numdel-1)

c minres & maxres define the range of nonstable & nonstrange baryons
      integer minres,maxres
      parameter (minres=minnuc+1,maxres=maxdel)

c strangenes.ne.0 baryon resonances
      integer minlam,minsig,mincas,minome
      integer numlam,numsig,numcas,numome
      integer maxlam,maxsig,maxcas,maxome
      parameter (numlam=13,numsig=9,numcas=6,numome=1)
      parameter (minlam=mindel+numdel)
      parameter (maxlam=minlam+numlam-1)
      parameter (minsig=minlam+numlam)
      parameter (maxsig=minsig+numsig-1)
      parameter (mincas=minsig+numsig)
      parameter (maxcas=mincas+numcas-1)
      parameter (minome=mincas+numcas)
      parameter (maxome=minome+numome-1)

c minbar & maxbar define the range of all baryons
      parameter (minbar=minnuc,maxbar=maxome)

      parameter (offmeson=minmes,maxmeson=maxmes)
c... these variables are in principal obsolete and should be exchanged were 
c referenced 

c... avoid hard coded itypes
      integer itrho,itome,iteta,itkaon,itphi,itetapr
      parameter (itkaon=106,itrho=104,itome=103,iteta=102)
      parameter (itphi=109,itetapr=107)
      parameter (pimeson=101)
      parameter (nucleon=minnuc)

      integer itmin,itmax
      parameter (itmin=minnuc,itmax=maxmes)
c!!!!!
      parameter (maxbra=8,maxbrm=25,maxbrs1=10,maxbrs2=3)

c meson itypes sorted by multipletts
c 4=number of mesons without multiplett
c      integer mlt2it(maxmes-4-minmes)
       integer mlt2it(maxmes-minmes)

c maxbrs1,maxbrs2
count the number of branches for strange baryon decays
      real*8 massoff,mresmin,mresmax
      parameter (massoff=1d-4,mresmin=1.0765d0,mresmax=5d0)


      real*8 massres(minbar:maxbar),widres(minbar:maxbar)
      real*8 branmes(0:maxbrm,minmes+1:maxmes)
      real*8 branres(0:maxbra,minnuc+1:maxdel)
      real*8 branbs1(0:maxbrs1,minlam+1:maxsig)
      real*8 branbs2(0:maxbrs2,mincas+1:maxcas)
      integer Jres(minbar:maxbar)
      integer Jmes(minmes:maxmes)
      integer pares(minbar:maxbar),pames(minmes:maxmes)
      integer Isores(minbar:maxbar), Isomes(minmes:maxmes)
      integer brtype(4,0:maxbra),bmtype(4,0:maxbrm)
      integer bs1type(4,0:maxbrs1),bs2type(4,0:maxbrs2)
      real*8 massmes(minmes:maxmes)
      real*8 mmesmn(minmes:maxmes)
      real*8 widmes(minmes:maxmes)
      integer strres(minbar:maxbar),strmes(minmes:maxmes)

      integer lbr(0:maxbra,minnuc+1:maxdel)
      integer lbs1(0:maxbrs1,minlam+1:maxsig)
      integer lbs2(0:maxbrs2,mincas+1:maxcas)
      integer lbm(0:maxbrm,minmes+1:maxmes)

claw itype classifications
      integer ittocl(itmin:itmax)


      common /resonances/ massres,widres,massmes,widmes,mmesmn,
     ,                    branres,branmes,branbs1,branbs2,
     ,                    bs1type,bs2type,lbs1,lbs2,lbm,
     ,                    jres,jmes,lbr,brtype,pares,pames,
     ,                    bmtype,
     ,                    Isores,Isomes,strres,strmes,ittocl,mlt2it


ccccccccccccccccccccc sigtab-declarations cccccccccccccccccccccccccccccccccc

      integer itblsz,nsigs,maxreac,maxpsig,sigver
c     VERSION NUMBER of SIGTAB
      parameter (sigver = 1000)
ccccccccccccccccccccccccccccccccccccccc
c
c ICLTP  : maximum possible number of reaction-itypes
c PSIGS  : maximum possible number of pointer-entries to sigmainf and sigmascal
c IBRNCH : maximum possible number of reaction-branches
c NSIGS  : maximum possible number of tabulated cross sections
c ITBLSZ : number of data-points per cross section in the table
c

      parameter (maxreac = 13)
      parameter (maxpsig = 12)
      parameter (nsigs = 10)

      PARAMETER (ITBLSZ= 100)


c
      integer sigmaLN(maxpsig,2,maxreac)
      integer sigmainf(nsigs,20)
      real*8 sigmascal(nsigs,5), sigmas(nsigs,itblsz)
c
      common/sigtabi/sigmaln,sigmainf
      common/sigtabr/sigmas,sigmascal


