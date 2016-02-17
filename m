Return-Path: <cygwin-patches-return-8322-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12322 invoked by alias); 17 Feb 2016 10:42:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 12305 invoked by uid 89); 17 Feb 2016 10:42:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=behavioral, 1526, 496, XXX
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Feb 2016 10:42:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EB559A805A7; Wed, 17 Feb 2016 11:42:41 +0100 (CET)
Date: Wed, 17 Feb 2016 10:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: gprof profiling of multi-threaded Cygwin programs
Message-ID: <20160217104241.GA31536@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56C404FF.502@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <56C404FF.502@maxrnd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00028.txt.bz2


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3527

Hi Mark,


thanks for the patch.  Generally the patch is fine, I have just a few
nits.

On Feb 16 21:28, Mark Geisert wrote:
> I've attached a patch set modifying Cygwin's profiling support to sample =
PC
> values of all an application's threads, not just the main thread.  There =
is
> no change to how profiling is requested: just compile and link the app wi=
th
> "-pg" as usual.  The profiling info is dumped into file gmon.out as usual.
>=20
> There is a behavioral change that ought to be documented somewhere:  If a

If it ought to be documented, what about providing the doc patch, too?
Any chance you could come up with a short section about profiling in the
context of winsup/doc/programming.xml?  Otherwise there's basically only
the description of the ssp tool in winsup/doc/utils.xml yet, which is a
bit ... disappointing.

> diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
> index 9584d09..243fd01 100644
> --- a/winsup/cygwin/common.din
> +++ b/winsup/cygwin/common.din
> @@ -269,6 +269,7 @@ ctime SIGFE
>  ctime_r SIGFE
>  cuserid NOSIGFE
>  cwait SIGFE
> +cygheap_profthr_all NOSIGFE

I would like to avoid exporting new cygwin-internal symbols.  Could you
please wrap the new functionality in a call to cygwin_internal?  Just
add a new CW_xxx symbol to include/sys/cygwin.h and use that from
profthr_func.

> +extern "C" void
> +cygheap_profthr_all (void (*profthr_byhandle) (HANDLE))
> +{
> +  int ix =3D -1;
> +  while (++ix < (int) nthreads)

Why the cast?  Why not stick to the type of nthreads, e.g.

     for (uint32_t ix =3D 0; ix < nthreads; ++ix)

> +    {
> +      _cygtls *tls =3D cygheap->threadlist[ix].thread;
> +      if (tls->tid)
> +	profthr_byhandle (tls->tid->win32_obj_id);
> +    }
> +}
> @@ -49,6 +50,7 @@ static char rcsid[] =3D "$OpenBSD: gmon.c,v 1.8 1997/07=
/23 21:11:27 kstailey Exp $
>=20=20
>  /* XXX needed? */
>  //extern char *minbrk __asm ("minbrk");
> +extern int _setmode(int, int);
>=20=20
>  #ifdef _WIN64
>  #define MINUS_ONE_P (-1LL)
> @@ -152,6 +154,7 @@ void
>  _mcleanup(void)
>  {
>  	static char gmon_out[] =3D "gmon.out";
> +	static char gmon_template[] =3D "gmon.outXXXXXX";
>  	int fd;
>  	int hz;
>  	int fromindex;
> @@ -222,7 +225,14 @@ _mcleanup(void)
>  	proffile =3D gmon_out;
>  #endif
>=20=20
> -	fd =3D open(proffile , O_CREAT|O_TRUNC|O_WRONLY|O_BINARY, 0666);
> +	fd =3D open(proffile, O_CREAT|O_EXCL|O_TRUNC|O_WRONLY|O_BINARY, 0666);
> +	if (fd < 0 && errno =3D=3D EEXIST) {
> +		fd =3D mkstemp(gmon_template);
> +		if (fd >=3D 0) {
> +			_setmode(fd, O_BINARY);

You don't have to call _setmode here.  Files created with mkstemp are
O_BINARY anyway.  And if you don't trust it, use mkostemp with an
explicit O_BINARY flag.

>  static void CALLBACK
>  profthr_func (LPVOID arg)
>  {
>    struct profinfo *p =3D (struct profinfo *) arg;
> -  size_t pc, idx;
>=20=20
>    for (;;)
>      {
> -      pc =3D (size_t) get_thrpc (p->targthr);
> -      if (pc >=3D p->lowpc && pc < p->highpc)
> -	{
> -	  idx =3D PROFIDX (pc, p->lowpc, p->scale);
> -	  p->counter[idx]++;
> -	}
> +      // record profiling sample for main thread
> +      profthr_byhandle (p->targthr);
> +
> +      // record profiling samples for other pthreads, if any
> +      cygheap_profthr_all (profthr_byhandle);

As outlined above, please call `cygwin_internal (CW_foo, profthr_byhandle)'
from here.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxE6hAAoJEPU2Bp2uRE+gxtAP/1I2R8nSqN23DbHqoNqhZYq3
QYSPCFp69Asnz3KFZkr/6XZMRoUB71iNgX6DplMs+/a0wZ3SFhUmNIKMNd7KfWvf
LDeEaqd0cmbtSzBnVNrKhY1L0EpQOEM3HvU+qx05h4iJt4xVzb7QH9PVFLV+4XqB
rb/dRC4N3rVWcDkopWWLn0UClB1CKaEqNp3kH8ZUTLVJw/oi11ydCFAQ/2fmJ3eh
aPas7vvS7PusrFu4hYRmXc47OIm35y4rc1BRU4MGZQwCSplcPqBuTWhwOcsjOTzu
s6BYYw+omkY0A2kshF6COvM6ydqUCmB0RctWPlRc7OaVMF4JEtnpIs5mBZ1F+VKT
tNoVNdvhB5kqMHPb4FRr+wBa4p+qwNb9ny0wg4QFem+FWCrbN6rjcmXRCXkHiXDe
daGnsAoA4kXCKma4x97rcl1xAfCKmW589NueQFzssb7pX7P9LL4iVUVYBmwlAXWo
7na4LXOOC6PQMHy0YhkYBwVvrc8P5lYNTxvgUg0cHuWysbVNNOtTH/xSyDPmtAo4
m3fGrhm8aMgQvePhKPa028C88TGz/TaZQ7ueGGUeVpwLkrZRJoMOQqYEUxgaY/md
Wq0l2qlUADFd0zLwgMpH/EVUPH01jMDUIqNOF90ULqpY4D3YUX/NzAvM8VplTzBB
6JM0LDTzbVA2M9I1Xta4
=yMCU
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
