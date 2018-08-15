Return-Path: <cygwin-patches-return-9181-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 111084 invoked by alias); 15 Aug 2018 16:05:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 111064 invoked by uid 89); 15 Aug 2018 16:05:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 15 Aug 2018 16:05:07 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue103 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MgZE7-1fTdgN2sAZ-00Nz26 for <cygwin-patches@cygwin.com>; Wed, 15 Aug 2018 18:05:04 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4A68BA81F25; Wed, 15 Aug 2018 18:05:04 +0200 (CEST)
Date: Wed, 15 Aug 2018 16:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Keep the denormal-operand exception masked; modify FE_ALL_EXCEPT accordingly.
Message-ID: <20180815160504.GM3747@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1534330763-2755-1-git-send-email-houder@xs4all.nl> <20180815145449.GJ3747@calimero.vinschen.de> <f0f0756f46ab11e243b9f17e069a2788@xs4all.nl> <20180815152636.GL3747@calimero.vinschen.de> <925b0ec898fda180517a166802b740da@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="m4E4Spob7u7JiHeu"
Content-Disposition: inline
In-Reply-To: <925b0ec898fda180517a166802b740da@xs4all.nl>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00076.txt.bz2


--m4E4Spob7u7JiHeu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1482

On Aug 15 17:43, Houder wrote:
> On 2018-08-15 17:26, Corinna Vinschen wrote:
> > On Aug 15 17:01, Houder wrote:
> > > On 2018-08-15 16:54, Corinna Vinschen wrote:
> > > > Shouldn't FE_ALL_EXCEPT_X86 be defined locally in fenv.cc only?
> > > > I don't see that Linux exports that definition.
> > >=20
> > > Ah, Sorry. Do I have to resubmit my patch? Or is it easy enough for
> > > you to
> > > make this modification?
> >=20
> > It's easy enough but I'm still mulling over __FE_DENORM.  The glibc
> > fenv.h header defines it, so I guess we should stick to it.  In that
> > case it might make sense to revert the original comment and just move
> > __FE_ALL_EXCEPT_X86.
>=20
> ... uhm, my intention was to remove FE_DENORMAL from fenv.h, because it
> is no longer part of the interface.
>=20
> I should have defined "a mask" in fenv.cc, that would have enabled me to
> initialize the MXCSR register (i.e. mask ALL exceptions).
>=20
> I defined __FE_ALL_EXCEPT_X86 (and should have defined it as 0x3f).
>=20
> Basically, there was no reason to define __FE_DENORM (or __FE_DENORMAL),
> now that I think it over.
>=20
> (I needed __FE_DENORM(AL) for testing)

I think it's more clear to have the definition, even if only used
locally.  You're using __FE_DENORM in a comment, too.  So I just
moved it to fenv.cc.

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--m4E4Spob7u7JiHeu
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlt0TzAACgkQ9TYGna5E
T6D2gA/+KIt8JXwORbQprSO74jSwuncVokb14N5UFRgaXbYtUYuv9FJLZYV+ik4i
n4wToe6DeYwZxO72pJ24lMUiviLNnLITtWHPb/oOgT3+E6TAnJtOpa1Mp3uGshpT
eqK70tH4YalwRya8kUMjGc2PE+suRbu6FqUuuFqRApG7Je7PVKvwFvcwDv+gBuq7
k7HG+UymLJkHuaZsEBF2BFn36pZcCvGVTxjEP7WnbLxCwj4DeYJ5cl6Fsny+YYbs
DhRCcEy3wnYhTNxtvfGGw+wioCdYiLV6ajJNvt6UufFzagH4opNk3kI6NPolWcsE
+rLdiob0NdJK/qeR/WzV1dH9QOgD2bHvksT/gWv+0H2i9b9ge8BnhVOrKT/LhnDw
RqtlN2+99I4y/2MYGLmZu59QWkIipOtGHtXCGkUBeODU7Xw6LOASjFDPiJ+4pVMa
IRG5184NKSuz+HOpNAQUt/kXBFkJahqPTL28Q9SFY58/4iMGE5UosnNbfUStgDTq
y+HxOFnIGRqe0S/kA8P/yVESKcNZjpfDcx0pFf9EL8uAAKobT2eWk+1FmrpG/qZL
QIKmIy79xox2BriKfdR9XA23/vhwW01JU0CI+SszAu17OW89Ipw6NVGJyYeeKz/G
EPm5Lkqo/jORpUT3pWJ8vlApGdKf4GedNfSPQ0UloxF4TmkZaYg=
=eiNP
-----END PGP SIGNATURE-----

--m4E4Spob7u7JiHeu--
