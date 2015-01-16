Return-Path: <cygwin-patches-return-8048-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11695 invoked by alias); 16 Jan 2015 16:22:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11574 invoked by uid 89); 16 Jan 2015 16:22:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 16 Jan 2015 16:22:05 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 43CBB8E1421; Fri, 16 Jan 2015 17:22:03 +0100 (CET)
Date: Fri, 16 Jan 2015 16:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: tracing malloc/free call
Message-ID: <20150116162203.GI3122@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <54B6EE1F.60705@gmail.com> <20150115093451.GB10242@calimero.vinschen.de> <54B91EFD.80302@gmail.com> <20150116154425.GG3122@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="0qt3EE9wi45a2ZFX"
Content-Disposition: inline
In-Reply-To: <20150116154425.GG3122@calimero.vinschen.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00003.txt.bz2


--0qt3EE9wi45a2ZFX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1307

On Jan 16 16:44, Corinna Vinschen wrote:
> On Jan 16 15:23, Marco Atzeri wrote:
> > Attached patch that allows tracking of original caller,
> > for the 4 memory allocation calls.
>=20
> Thanks for the patch, but it won't work nicely either this way.  The
> problem is that, in theory, the code has to differ between internal and
> external callers.  Internal callers (that is, Cygwin functions itself)
> don't hop into the function via _sigfe/_sigbe.  Thus the output for
> internal callers of malloc/free is now wrong with your patch.
>=20
> The solution for this problem would be a test which checks if the return
> address is the _sigbe function and if so, returns *(_my_tls.stackptr-1),
> otherwise __builtin_return_address(0).  However, the symbol _sigbe is
> not exported since, so far, it was only used inside _sigfe.  This needs
> a bit of tweaking.  I'll have a look.

I applied a patch to print the right caller address.  I created a new
macro caller_return_address() for reuse, should we have a desire to
print the caller address in other parts of the code.

I'm going to create a snapshot with this change.  Please give it
a try.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--0qt3EE9wi45a2ZFX
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUuTqrAAoJEPU2Bp2uRE+gt/oP/ixmSa8/MV2zKd7R/7lApJKj
+3BbC5EyIyexEqSB5Wkc+b8wZ2mTgExaW56Va+RCYSN0JLMkzCpEQ9CXeNJitqzs
+qebs9L4IkLlMkl560zuEOvqAc8i6+fA4mpvTRtFZQtZx/9pMglEeRzwRlGF1CTL
uKzbTdmVgcxi75+7Dw/0IjxBdyhmB4ihkj6eAz3zjVs57dxVYgxL5xMRyg2CRNtR
vZIaYvnPmG3GLTzcwTphJh+uI4gsorqMNbvw/tA6708SfT/A4h7kWjwZbNidEhbE
lqBMZ9P1BPefWtRyxv9xUdpCvHeLcMdl8ieOBi7JEuAbemqJp4RYQXOnsg3G7rFa
WBfSzyvQF6d1KHbQTx2xnUz01FYllPAqW59ROtWPUi9PrdQAz635PLRMyNicOM9u
JzA3TtpbNKgRtjyA9HnNf8Zxd+JDMNUkKB9RIxRju1rspts3BEsbUggPYcEBBePQ
kNORO/ZuFxCG++JpZwIR3VlR2hZIDEiPIJg6+KC9E9HkBQ9IJnZY0ChqbJ0qPRs0
1CNBrk7ophA4RGSmWNLpWh8aElzEBWNh+jfFhF3BGvObCS8VXB9iy0Xzkge/AErn
mZBzLBHVsUq7+mDfmxQBoszlBF+we5tbMBR1SjUJjNBvPnsM65Pb04oIkiYil9yw
0PwwLaa7gM4Kgxh5SIlc
=cVnH
-----END PGP SIGNATURE-----

--0qt3EE9wi45a2ZFX--
