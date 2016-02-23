Return-Path: <cygwin-patches-return-8356-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 116550 invoked by alias); 23 Feb 2016 11:14:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 116516 invoked by uid 89); 23 Feb 2016 11:14:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=UD:cygwin1.dll, cygwin1.dll, cygwin1dll, HX-Envelope-From:sk:corinna
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 23 Feb 2016 11:14:25 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DF147A805D5; Tue, 23 Feb 2016 12:14:23 +0100 (CET)
Date: Tue, 23 Feb 2016 11:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] gprof profiling of multi-threaded Cygwin programs, ver 2
Message-ID: <20160223111423.GB5618@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56C820D8.4010203@maxrnd.com> <56CAF4A3.5060806@dronecode.org.uk> <Pine.BSF.4.63.1602222322100.88046@m0.truegem.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.1602222322100.88046@m0.truegem.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00062.txt.bz2


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1896

On Feb 22 23:36, Mark Geisert wrote:
> Hi Jon,
>=20
> On Mon, 22 Feb 2016, Jon Turney wrote:
> >Thanks for this.  A few comments inline.
> >
> >On 20/02/2016 08:16, Mark Geisert wrote:
> >>+/* Called from profil.c to sample all non-main thread PC values for
> >>profiling */
> >>+extern "C" void
> >>+cygheap_profthr_all (void (*profthr_byhandle) (HANDLE))
> >>+{
> >>+  for (uint32_t ix =3D 0; ix < nthreads; ix++)
> >>+    {
> >>+      _cygtls *tls =3D cygheap->threadlist[ix].thread;
> >>+      if (tls->tid)
> >>+	profthr_byhandle (tls->tid->win32_obj_id);
> >>+    }
> >>+}
> >
> >There doesn't seem to be anything specific to profiling about this, so it
> >could be written in a more generic way, as "call a callback function for
> >each thread".
>=20
> I saw your later conversation with Corinna on the list re why
> cygwin_internal() is involved now.  (I too had stumbled over the
> cygwin1.dll/libgmon.a gap when I started this work.)  Given the necessity=
 of
> the separation, does it still make sense to write a generic per-thread
> callback mechanism and then make use of it for this patch, or is that
> overkill?  I can't tell.

One problem with a generic solution is to generalize the arguments to
the called function.  IMHO, keep it as is for now.  If we ever need to
make this generic we can still do it.

> >>+	if ((prefix =3D getenv("GMON_OUT_PREFIX")) !=3D NULL) {
> >
> >setup-env.xml might be an appropriate place to mention this environment
> >variable.
>=20
> I am now writing a gprof.xml that will be tied into the existing
> programming.xml.  I plan to document GMON_OUT_PREFIX in gprof.xml.  Do you
> think that's sufficient?

A single paragraph in setup-env.xml pointing to gprof.xml might be
helpful, I think.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWzD8PAAoJEPU2Bp2uRE+gCh8P/238qqMPacK3pvLBVZNPSL5+
6bjfbbzaE1ucmkcmGFNcbpHGZ8QC4lIvzXYa8imJvkJr+i7nmqnH3eIUY6Jfxjxb
OK6hF2ByAAICZofAyf7efEJt4FKFsi+b5grwfGZ1wrIfcguAbKevwgageyzir5v2
Ca0oMuO92nRqiWFhVHTvfk3wPZzi/T64TXnRrY2CrM5D9XGBA/Uhk827vo7sVZBi
/YH/KGDXwU8TRr/RG/6cZbXbdzHmgmgSynaLy9Bq6U/ZuXSSBlZA3B9hSICTGbvl
j46RzF9S87QO4L1LX1dlJxQN52O8Y+win9NeCYSVG3UGA1R/TyxbKFhvPfvt6ydq
ZzI9GE/WwbnYU/kUwRFUXfaln94CgZBk3qBIOwhYtUbPWXjctHvywlngS3GfjGVz
kvhe9AUKYkVYi1sQJ/eMpFG7Te5nyCWVYHSkzQ0sDEXWeR+Yjm92oM6fzXo7Otb/
ygN+g4X9Qa3sGu7Xdp2CrGYoymjUtGL5ExydFjn0GapuOPDrlygZcfHlD3FEFkSg
2N+U+J+Ngy6abBl1fkdiu0Z095lDTIjxf3yCHB1taNeTHCrzbHof/gXF+YQ2s+1e
1J6vYhLwBkodCx+m5SggTnqoUk0GX8ncydfRgiWmo5bHJoQ9Xg/mRrWmIopVl0Ci
t5hzLeITA0R2kF2BasVu
=Vq4s
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
