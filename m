Return-Path: <cygwin-patches-return-7936-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26853 invoked by alias); 8 Jan 2014 09:20:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26820 invoked by uid 89); 8 Jan 2014 09:20:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.3 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 08 Jan 2014 09:20:03 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D8D801A0BF9; Wed,  8 Jan 2014 10:20:00 +0100 (CET)
Date: Wed, 08 Jan 2014 09:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Reattach trailing dirsep on existing directories too.
Message-ID: <20140108092000.GB28847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAOYw7duMgGSfpxa4OtOPRhY5Mw6q=__shhJxELZ53Ez9_WETRQ@mail.gmail.com> <20140107151249.GI2440@calimero.vinschen.de> <CAOYw7dsJ5b5NVDowSAuK9F0uRztYhZLMU97G=T8jGECU-vcFVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <CAOYw7dsJ5b5NVDowSAuK9F0uRztYhZLMU97G=T8jGECU-vcFVw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2014-q1/txt/msg00009.txt.bz2


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1184

On Jan  7 18:15, Ray Donnelly wrote:
> On Tue, Jan 7, 2014 at 3:12 PM, Corinna Vinschen wrote:
> > On Dec 22 01:03, Ray Donnelly wrote:
> >> I hope this is OK and I've done it in the best place. Please advise if
> >> it needs any changes.
> >
> > I have no idea if this is ok.  This is a patch to a very crucial
> > function in terms of path handling, and it's not clear that this isn't
> > doing the wrong thing.  What is this patch trying to accomplish?  Do you
> > have example user space code which is failing for this very reason?
>=20
> The exact issue was that paths that do not exist would maintain their
> final dirsep whereas paths that do exist would lose this dirsep:
>=20
> test.exe /c/doesnt-exist/ /c/does-exist/
>=20
> test.exe would see:
> arg1: C:/doesnt-exist/
> arg2: C:/does-exist
>=20
> These paths were passed to GCC as search paths and while I could've
> hacked up the GCC code to detect and correct this anomaly, but I think
> this patch fixes the problem at cause.

And that is a problem, because...?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJSzRhAAAoJEPU2Bp2uRE+gvhEP/0oTc8Rg9eHkmnP94QFMYF58
6j9P2vc05uY3Tbybh6lSYwx2mbDh/qai5dnNdQRpvvCBHcxlDPPu5SyvzNN6pbVx
i7zo2sD2KkwLPETNSMKn74KdlSZb5tOB/tJtn3lHdiYWzbOpkbmm2j4N7OUZuwxS
BgJlch7Y4xtIilKIDtFadfQcgrYJD2cfKH04v13R68qvLd9i0v2FDVAITRr2Bf4Y
W9Qhs6Z0pLjTI94lMAGerGohNx1z3QG3wFnpYIesVkrPdnJN020P4FlO84usSzhS
s0621lTVZ4Tu3he7ZYB0tsInh2rMIjSTdR3U1hAtk7G3EwcboERe1rc2GfUpWlTq
58oGDNOXVmZO8CfkGyUvr7rJUt3TrN2G/9YXIIqngjNCJ+UvINpmnftBn6pyDcGB
hsW6rzRhqN8Rw4g9T7sL/jgosNVYlQ3AEe4QW1vc3SEfFZwLONO0boOLvVQYK0P6
vGXG3Vs0siqR0Xetw/JcOyAzKi2HM7ghzu9ryUFcWq8wCPNWSMsn7IQ0Phl0Ux9m
Ral202KGM1whIQCPTDfdBAWPWn6ru+KhUzKNxoHFErUWOeL/2SyGqENVB6fBIO7z
DT55FmmCmqrBQlh3qeq+7X3ywlGzZZJQgGmDcRTqiTx/qrnSUJ0gLRnLUQv179ow
20oQOMjBGUYF40GR4Etd
=xPkg
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
