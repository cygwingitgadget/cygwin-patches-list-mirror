Return-Path: <cygwin-patches-return-8237-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35066 invoked by alias); 17 Aug 2015 08:15:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35055 invoked by uid 89); 17 Aug 2015 08:15:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 17 Aug 2015 08:15:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id ED456A80562; Mon, 17 Aug 2015 10:15:08 +0200 (CEST)
Date: Mon, 17 Aug 2015 08:15:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] mkglobals: Fix EOL detection
Message-ID: <20150817081508.GG25127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAGHpTBLBua-DJQ1tBapYd_6ypdWGMW+ehAq4r7k_TA44Tn_Oxg@mail.gmail.com> <20150817075954.GB25127@calimero.vinschen.de> <CAGHpTBJaZmtKq_NvXgjVEz9QLv6siK9CdHBK+FXAn0Pb1iMfBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Content-Disposition: inline
In-Reply-To: <CAGHpTBJaZmtKq_NvXgjVEz9QLv6siK9CdHBK+FXAn0Pb1iMfBw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q3/txt/msg00019.txt.bz2


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1036

On Aug 17 11:02, Orgad Shaneh wrote:
> On Mon, Aug 17, 2015 at 10:59 AM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > On Aug 17 10:41, Orgad Shaneh wrote:
> >> When globals.cc has CRLF line endings, winsup.h is not removed, and
> >> compilation fails for duplicate definitions.
> >
> > Why on earth should globals.h get CRLF line endings?  It's stored
> > with LF line endings in git.  There's no reason to convert the file.
>=20
> globals.h is generated, I guess you refer to globals.cc.
>=20
> Well, git has a setting named core.autocrlf which converts
> line-endings to CRLF on Windows.
>=20
> This is very commonly used with msysGit and Git for Windows.
>=20
> If the cygwin repository is cloned with autocrlf set, then all the
> source files will have CRLF line endings, including globals.cc...

You should set core.autocrlf to no in Cygwin's local git config.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV0ZgMAAoJEPU2Bp2uRE+gXZIQAJAzbx2DH3zQw4iRzvZ/HkaI
eJDzI8wBRM5HYR94zrH7UqlRhlpEvtuOM1hax95ksHbGicvtop7ZEjg+SSvAhPb5
/sfVgxhMkLGBmksX5LZ01jQOPCOUQdvIRJwNzv6wbObAChTNlH0crsjbvAM3W4Mv
i0Fp6VRY+qlxEi68YYx7GBY4GpOT9lIDkl1sc5Oa9zJm5C/G3/AA1wEX5oLANv3w
DX6hBSiny2j/DPOAAl8Sn0VIFmwMMQ87Q9125DcWnPmGtKhwI1Ju5xjTP9u6AISo
sNzMpwPDykoF9KlL79gCpcNRwfnPntKiejJxHLFOGVelQ21Wk8kOvxiSYX0ww/0o
XyABh31Vq+nJKKjFRu+IJtw2O+Pac4rXTts0YIiv/yGddjGMivFUwP7s4mp0wSpM
Zispbdm1N5bRIwqyxAyPE+1RLpOfgyi2YZtjcliEwSafY4Sm/BOR4O0AOb/RvqEk
gtAwijgmXuzcT87I1n+oW6QKfKj+aQA4DOrtr2jSTNwT/5Cbv2GpdIeOAGslHiaq
Yeaum8etL3yF36d2fet9NYmselhXfcq/uPTcir1oIGKcU9K1oH/8Gse+2Z0oekSk
wZKw9f7ZzyuUI/VFKgbaAcv/nMb8zXhoz7oMZYQlvkcBSbZbw75N545EaaTLD35u
+Cj5Kd2QwNqA4rN+E3JP
=4BPg
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--
