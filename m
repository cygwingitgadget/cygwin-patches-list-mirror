Return-Path: <cygwin-patches-return-9462-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16602 invoked by alias); 25 Jun 2019 11:40:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16292 invoked by uid 89); 25 Jun 2019 11:40:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_SHORT,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Jun 2019 11:40:07 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MsIbU-1iYNvb0NQY-00tkfK for <cygwin-patches@cygwin.com>; Tue, 25 Jun 2019 13:40:05 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 427AEA807D0; Tue, 25 Jun 2019 13:40:04 +0200 (CEST)
Date: Tue, 25 Jun 2019 11:40:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix return value of sched_getaffinity
Message-ID: <20190625114004.GI5738@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190625052523.1927-1-mark@maxrnd.com> <20190625073133.GE5738@calimero.vinschen.de> <2cf19e65-3248-b25a-7983-e73094482285@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Content-Disposition: inline
In-Reply-To: <2cf19e65-3248-b25a-7983-e73094482285@maxrnd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00169.txt.bz2


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3055

On Jun 25 01:17, Mark Geisert wrote:
> Corinna Vinschen wrote:
> > Hi Mark,
> >=20
> > On Jun 24 22:25, Mark Geisert wrote:
> > > Return what the documentation says, instead of a misreading of it.
> > > ---
> > >   winsup/cygwin/sched.cc | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/winsup/cygwin/sched.cc b/winsup/cygwin/sched.cc
> > > index e7b44d319..8f24bf80d 100644
> > > --- a/winsup/cygwin/sched.cc
> > > +++ b/winsup/cygwin/sched.cc
> > > @@ -608,7 +608,7 @@ done:
> > >     else
> > >       {
> > >         /* Emulate documented Linux kernel behavior on successful ret=
urn */
> > > -      status =3D wincap.cpu_count ();
> > > +      status =3D sizeof (cpu_set_t);
> >=20
> > Wait... what docs are you referring to?  The Linux man page in Fedora 29
> > says
> >=20
> >   On success, sched_setaffinity() and sched_getaffinity() return  0.   =
On
> >   error, -1 is returned, and errno is set appropriately.
>=20
> I've been using http://man7.org/linux/man-pages/man2/sched_setaffinity.2.=
html
> which has the text you quoted under the RETURN VALUE heading, but has the
> following further down the page under the heading "C library/kernel
> differences":
> |        This manual page describes the glibc interface for the CPU affin=
ity
> |        calls.  The actual system call interface is slightly different, =
with
> |        the mask being typed as unsigned long *, reflecting the fact tha=
t the
> |        underlying implementation of CPU sets is a simple bit mask.
> |
> |        On success, the raw sched_getaffinity() system call returns the
> |        number of bytes placed copied into the mask buffer; this will be=
 the
> |        minimum of cpusetsize and the size (in bytes) of the cpumask_t d=
ata
> |        type that is used internally by the kernel to represent the CPU =
set
> |        bit mask.
>=20
> I see now that that 2nd paragraph has actually been updated since I print=
ed
> it out in April so I'll need to update the patch yet again.
>=20
> The taskset(1) utility in util-linux actually depends on the kernel return
> value that glibc doesn't return.  On Cygwin there is only one "syscall"
> interface so I have to have sched_getaffinity() return a nonzero value on
> success like the Linux kernel does.

That's very unfortunate.  Keep in mind that applications usually link
against the C lib, so the expectation of developers is usually that the
API follows the C lib definitions.  The kernel API should only be
considered if there's no equivalent/documented C lib API.  And even
then, the call is typically just a SYSCALL wrapper, something we don't
support at all.

The API of sched_getaffinity should definitely follow glibc.  If you
need the kernel API as well, create another function like, say,
__sched_getaffinity_raw() (leading underscores) and export this as well.
You can simply add a cpp macro in your application to support this.
Make sure to document the differences in the source, lest we forget.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0SCBQACgkQ9TYGna5E
T6Blyw/7ByFPtYKxyENKjpWL9vrT3tNB+dW8rCcQWybiQxyeqqn82gHs35/vkjrE
jBy1kw+QMxaHsfC6oinwZftJ608b8jG8fpE7dEPqKd2sFFg0odx2GpiUXHlFZqKC
+JQhepc2lr1VC960C62evk/9d1d0NTDn5ydOF7MNCO0XOeh9fIVQUsS9gxz4JOp6
HyiXmtPHtMStNKQlHahqj443Zrzs6hLnKCgX+WdJzvQZDAPcsQA8LLWfeHPPTcze
8GTWq6xZSy6eE8muPTrxaPqAF0wTTi5y6bNE7wIdfl/dwOeO47BASXVX02ufvjAC
4cgJm5f0ihgq1vzwTf/iDsYgDe1gZwAWlQOBraHgQVmMd5hGZ/+/9lsTF1GtgUxp
5oxhX3IPARNvxkzbL4x4lbrZ91miI7PNErA8r1pUWAHYFW0dRXtcw9Sy+4OVzBc/
7O9VX6AOSq6YmjJSPyP1tcdyE1A4H4GoYBoAxX4Pmu4gusHV16AI15LDKV5qCZqy
kmDDq8oGSx98sUSFYOOKQhswfI2bGP7M9zcdUbw61zVq1RX6TWzCK/SnZavhynra
/5q8r3qEK8J1fXPGpH2qo4cX66INa1k/8KI1PsgFZ94ALr8vpLnQt0buAd71EWWQ
K6agRtsvsc63DmlARNozqbQ2TCI9YEN9xwW4RYm1auCtd9rnPBM=
=2pUG
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--
