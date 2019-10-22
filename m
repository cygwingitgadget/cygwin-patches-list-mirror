Return-Path: <cygwin-patches-return-9781-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62247 invoked by alias); 22 Oct 2019 08:04:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62225 invoked by uid 89); 22 Oct 2019 08:04:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*c:HHu, H*F:D*cygwin.com, screen, yourself
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 22 Oct 2019 08:04:06 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MSqbe-1iRoGj1uAg-00UH8G for <cygwin-patches@cygwin.com>; Tue, 22 Oct 2019 10:04:03 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B1E05A80773; Tue, 22 Oct 2019 10:04:02 +0200 (CEST)
Date: Tue, 22 Oct 2019 08:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-ID: <20191022080402.GO16240@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191018113721.2486-1-takashi.yano@nifty.ne.jp> <b13f5d3c-c557-ff4e-6fcd-399952bad47e@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="xjamM5M9kpPM/bcu"
Content-Disposition: inline
In-Reply-To: <b13f5d3c-c557-ff4e-6fcd-399952bad47e@ssi-schaefer.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00052.txt.bz2


--xjamM5M9kpPM/bcu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1706

On Oct 22 09:20, Michael Haubenwallner wrote:
> Hi Takashi,
>=20
> On 10/18/19 1:37 PM, Takashi Yano wrote:
> > ---
> >  winsup/cygwin/fhandler_tty.cc | 21 ++++++++++++++++++++-
> >  winsup/cygwin/tty.cc          |  1 +
> >  winsup/cygwin/tty.h           |  1 +
> >  3 files changed, 22 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty=
.cc
> > index da6119dfb..163f93f35 100644
> > --- a/winsup/cygwin/fhandler_tty.cc
> > +++ b/winsup/cygwin/fhandler_tty.cc
> > @@ -1305,6 +1305,20 @@ fhandler_pty_slave::write (const void *ptr, size=
_t len)
> >    if (bg <=3D bg_eof)
> >      return (ssize_t) bg;
> >=20=20
> > +  if (get_ttyp ()->need_clear_screen_on_write)
> > +    {
> > +      const char *term =3D getenv ("TERM");
> > +      if (term && strcmp (term, "dumb") && !strstr (term, "emacs") &&
> > +	  wcsstr (myself->progname, L"\\usr\\sbin\\sshd.exe"))
>=20
> Again, my real problem does not utilize ssh at all, but is some python sc=
ript
> using multiple pty.openpty() to spawn commands inside, to allow for herdi=
ng
> all the subprocesses started by the commands (Ctrl-C or similar).
>=20
> The ssh -t is just the sample showing a similar effect.
>=20
> Unfortunately, I'm not deep enough into that python script to quickly pro=
vide
> a test case with pty.openpty() combined with all the tty settings used th=
ere.
>=20
> I've started to extract the important bits, but that may take a while.  O=
TOH,
> this is an open source project if you like to try yourself: prefix.gentoo=
.org
>=20
> Thanks!
> /haubi/

In terms of clearing the screen at all, what's your opinion, Michael?


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--xjamM5M9kpPM/bcu
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl2ut/IACgkQ9TYGna5E
T6DxJA/4wEToWNK2pUH869n2wsZu2Z+bHqaA29yEMIEzGdEW5GyWVu0ot5oj+f2w
zPzaqXB9byU3OeiaiMp67JNefj2KGany+b3wfxH8NxKqVscijZOi4u1YIg+4jTro
wfJzrhhOulFP9N4nD+cSL7DxadZcmB6Af7+IehfCPQNQ/VjN8vHptp6Zi5qHEMpF
ckJck1LYSEipgQLAxLTM/PfOqVcKy/LWiZt15AT7uLaEXHpYKESfwAytS2BkZfiN
1fdZs8HeB0Y8XrZy9WuX0fJcsBzAMlNLUcPzBRffdXXVkq9j8vvfZRIgkmvWmtZY
YBxoAah1aruC8B4+99pbVnJClt9Kxk0aC7o4iI8tfsgDGLRdaLiB2lqzbtLPMMjj
Gt2bmf9xjWT+9gIl8K5OG9yU1c2qmnawm8xazUtHVXJcxgnkQaIwmaS5aSiuAx6J
k/PggG6f+5WZCsHlC8sxduTXJ4JnTPnhS35CioVwNhZxkfGYDfNvMUbpamaz7uBi
L2O4eA3YsuJ0I7i34devexOIhPTcnYHYiwBsCFr/JGWoIgoUMA6wWrHHqrGs1V7K
Z66ERPLZbGwt5gEmRFcnEHhyr6/Od5QMZKwa1NLS/8blqsVnML3nI0g7/8BFA+sB
epFGnSjIdV7ErRzcL/bjJrx4avLAuNT/IDcZ1rpKuZfELlP/Qw==
=u12r
-----END PGP SIGNATURE-----

--xjamM5M9kpPM/bcu--
