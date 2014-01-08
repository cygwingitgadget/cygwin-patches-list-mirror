Return-Path: <cygwin-patches-return-7939-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22434 invoked by alias); 8 Jan 2014 11:21:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22421 invoked by uid 89); 8 Jan 2014 11:21:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.4 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 08 Jan 2014 11:21:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 93FB71A0A5D; Wed,  8 Jan 2014 12:21:39 +0100 (CET)
Date: Wed, 08 Jan 2014 11:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Reattach trailing dirsep on existing directories too.
Message-ID: <20140108112139.GB1336@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAOYw7duMgGSfpxa4OtOPRhY5Mw6q=__shhJxELZ53Ez9_WETRQ@mail.gmail.com> <20140107151249.GI2440@calimero.vinschen.de> <CAOYw7dsJ5b5NVDowSAuK9F0uRztYhZLMU97G=T8jGECU-vcFVw@mail.gmail.com> <20140108092000.GB28847@calimero.vinschen.de> <CAOYw7dsfrz5Y2AT9E7JFVfzdKcLV3da12GEAs6KQJZaP9Jw7DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline
In-Reply-To: <CAOYw7dsfrz5Y2AT9E7JFVfzdKcLV3da12GEAs6KQJZaP9Jw7DA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2014-q1/txt/msg00012.txt.bz2


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2849

On Jan  8 10:49, Ray Donnelly wrote:
> On Wed, Jan 8, 2014 at 9:20 AM, Corinna Vinschen wrote:
> > On Jan  7 18:15, Ray Donnelly wrote:
> >> On Tue, Jan 7, 2014 at 3:12 PM, Corinna Vinschen wrote:
> >> > On Dec 22 01:03, Ray Donnelly wrote:
> >> >> I hope this is OK and I've done it in the best place. Please advise=
 if
> >> >> it needs any changes.
> >> >
> >> > I have no idea if this is ok.  This is a patch to a very crucial
> >> > function in terms of path handling, and it's not clear that this isn=
't
> >> > doing the wrong thing.  What is this patch trying to accomplish?  Do=
 you
> >> > have example user space code which is failing for this very reason?
> >>
> >> The exact issue was that paths that do not exist would maintain their
> >> final dirsep whereas paths that do exist would lose this dirsep:
> >>
> >> test.exe /c/doesnt-exist/ /c/does-exist/
> >>
> >> test.exe would see:
> >> arg1: C:/doesnt-exist/
> >> arg2: C:/does-exist
> >>
> >> These paths were passed to GCC as search paths and while I could've
> >> hacked up the GCC code to detect and correct this anomaly, but I think
> >> this patch fixes the problem at cause.
> >
> > And that is a problem, because...?
>=20
> .. because in this case, GCC appends sysroots directly to those
> passed-in-as-#define values and I end up with e.g. C:/does-existusr/
> and C:/doesnt-exist/usr/, when I always wanted the final /. Of course

Hang on.  Why are you using DOS paths here?  Cygwin's GCC uses POSIX
paths, not DOS paths.  The DOS path handling should be entirely internal
and we don't give any guarantee that it does exactly what you want in
case you're using them on the application level.  That's what already
bothered me in your above example.  test.exe should always only see
the POSIX path /c/doesnt-exist/ and /c/does-exist/, and the DOS path
is only used internally in Cygwin and doesn't concern the application
at all.

http://cygwin.com/cygwin-ug-net/using.html#pathnames-win32

> I could add some nasty hacks in GCC and any other program that runs
> into this odd behavioural quirk to detect and workaround it, but IMHO
> fixing the quirk is a better approach.
>=20
> Someone's gone to the effort to re-attach the dirsep when the folder
> doesn't exist so they must have thought that preserving this was a
> good idea, I've just fixed a corner case in that so the results are
> consistent.

As I wrote, this functionality is the core of the path handling.  I'm
very reluctant to change it unless it turns out that an application
using POSIX paths has a problem.  Your change may end up breaking
another corner case when using POSIX paths, and if so, I opt for keeping
the POSIX path corner case working.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJSzTTDAAoJEPU2Bp2uRE+ge6QP/1EAkF12Y63+GTJljCoADH4Q
6ENKhVlTVtsUfGFRvfD5j+CPqybIu3G/wrQd188CrpcQKNyghjDAeP/rPVW3HWRf
MhWDe7Mrr464OEtpEILhK/xyy9tcDu5HSO/ZqF8jwuw72DetpJy4kXLCKXoLu68K
U9WiU+7yENQfL1ROjRX6uTFDfbeL1ns2ZbJe4vXgtnw+MVVyt0uao3petpnsz4//
GuYqVJffUR0TXxV0tjrHsgnc3/UfDgRE7vVek/alUsf+qMynkVwojcBF1rwPJdjB
Vv8wlPPmpRgoTGDE/Mko+vQoMS7SIIPNVCNqQhwPLBvmuFEiS/R75PXfOjBAHt/C
dB/H5IDuMgNihaFYXSf8/zoFI2K8+ecXnloS50cGBuMDFaNJ7A3DimfYgwD258pm
HFmbSTpoNI+b44u2gj/e9Upr+kuVugGHw3LpYCm4MHwpX7TQLkawT2raJNw7f4Gc
N5e3t0Dk5FbYxeezexB1JfbJIvaeCkaqUPwns9FRBkQTk0+1RlNyvv8Ju2MGGSvi
luZ73EJF8cW1ZqYKWL07Y6LYxL6piSa9kp0T8lrMYO+S7lIHsabbl+thgCerfBfw
JgGAqcvq/DUvkmkJqGww57qoVy4sHZNKiBMrKZgptJ2Of786+NXpYVjcsqA1mhhY
0sVOZPUvG1qOhk2v27Si
=K5F4
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
