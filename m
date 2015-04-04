Return-Path: <cygwin-patches-return-8118-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6981 invoked by alias); 4 Apr 2015 08:40:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6966 invoked by uid 89); 4 Apr 2015 08:40:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 04 Apr 2015 08:40:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3D26DA80959; Sat,  4 Apr 2015 10:40:14 +0200 (CEST)
Date: Sat, 04 Apr 2015 08:40:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Provide ucontext to signal handlers
Message-ID: <20150404084014.GW13285@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1427894373-2576-1-git-send-email-jon.turney@dronecode.org.uk> <1427894373-2576-3-git-send-email-jon.turney@dronecode.org.uk> <20150401142219.GY13285@calimero.vinschen.de> <551F0FA2.2020304@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="53t+yOlxgLCdk6tE"
Content-Disposition: inline
In-Reply-To: <551F0FA2.2020304@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00019.txt.bz2


--53t+yOlxgLCdk6tE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2579

On Apr  3 23:09, Jon TURNEY wrote:
> On 01/04/2015 15:22, Corinna Vinschen wrote:
> >On Apr  1 14:19, Jon TURNEY wrote:
> >>Add ucontext.h header, defining ucontext_t and mcontext_t types.
> >>
> >>Provide sigaction sighandlers with a ucontext_t parameter, containing s=
tack and
> >>context information.
> >>
> >>	* include/sys/ucontext.h : New header.
> >>	* include/ucontext.h : Ditto.
> >>	* exceptions.cc (call_signal_handler): Provide ucontext_t
> >>	parameter to signal handler function.
> >
> >Patch is ok with a single change:  Please add a "FIXME?" comment to:
> >
> >   else
> >     RtlCaptureContext();
> >
> >On second thought, calling RtlCaptureContext here is probably wrong.
>=20
> Wrong and also dangerous.
>=20
> This causes random crashes on x86.
>=20
> It seems that RtlCaptureContext requires the framepointer of the calling
> function in ebp, which it uses to report the rip and rsp of it's caller.
>=20
> It also seems that gcc can decide to optimize the setting of the
> framepointer away, irrespective of the fact that -fomit-frame-pointer is =
not
> used when building exceptions.cc
>=20
> If _cygtls::call_signal_handler() happens to get called with ebp pointing=
 to
> an invalid memory address, as seems to happen occasionally, we will fault=
 in
> RtlCaptureContext.  (in all cases, the eip and ebp in the returned context
> are incorrect)
>=20
> I wrote the attached patch, which fakes a callframe for RtlCaptureContext=
 to
> avoid these possible crashes, but this needs more work to correctly report
> eip and ebp

Maybe it's simpler than that?  Looking into the GCC info pages, I found
this:

     Starting with GCC version 4.6, the default setting (when not
     optimizing for size) for 32-bit GNU/Linux x86 and 32-bit Darwin x86
     targets has been changed to '-fomit-frame-pointer'.  The default
     can be reverted to '-fno-omit-frame-pointer' by configuring GCC
     with the '--enable-frame-pointer' configure option.

     Enabled at levels '-O', '-O2', '-O3', '-Os'.
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

So it seems adding -fomit-frame-pointer file by file in Makefile.in
(when building with -O2) is moot and only has an effect when building
unoptimized, otherwise all files are built with -fomit-frame-pointer
anyway.

So, what if we drop all the -fomit-frame-pointer from Makefile.in and
add an

  exceptions_CFLAGS:=3D-fno-omit-frame-pointer

Does that help?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--53t+yOlxgLCdk6tE
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVH6NuAAoJEPU2Bp2uRE+g5/4QAJPk1DXmvxxeuLJBpHfgaiBn
KvKz0l0EtqalW3AX2RFm54t6jVaLOwIc4+4V6w0mBOleTTLtHfDoCNh4+1Iquar0
fGofU3FqVgdh3/l7em0TuQRlSytWAgiR2/L3xMsdb/hGM0n3D5/8qM7+WaGdkaNx
e5wGL7MQd1d4GEGDApRif9340rL3MOnkDIH2O9bpOz24jDD5HncXdxPKO04mXxpT
5eCA0mlFT3vhUGbKbxkcemTDnxbU3p1EPa5tBsFWCH9YijaUJS2Af760ypWGdmdW
4SWeE8ORJC38sKg7dlZEflcHV7etyFSBXGOlPWoPrqOSg8zJqG6+vrE+sRwzAJ3c
tGJi6zGv/Sf6JrIrg//QAxG4OQocwKzf0lQFnM4s9EwRv2xy8ByOO4JfKOm3DhUW
K5z7YuZ4r3ghmRK8hByZNRyA8+DnaxKH2debdn49jyWWXfDkiK0Zb77Fk1ZjLuR5
CA2n8jYK9yz0nCaoS2OvAFFyVoc3JUQd4Via6ZjD07asoVSXInEkC0a7A6qim9It
SiHx0n65RUxXVHbAGTMgFqOvki5So6bLzf/TZPeT7160LdB3U00iLyhwB23+Zqo3
PRFm8Z2kIADKXIOcS8ufmdqxanJLND7hJYbJvXws8VH1d2C/jugh+6mmqODNNumA
IyNgiUvyAmvBlYdBv7oA
=kkEF
-----END PGP SIGNATURE-----

--53t+yOlxgLCdk6tE--
