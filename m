Return-Path: <cygwin-patches-return-8384-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62835 invoked by alias); 10 Mar 2016 08:48:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62718 invoked by uid 89); 10 Mar 2016 08:48:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-93.9 required=5.0 tests=BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=DOT, Maintainer, columns, Geisert
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 10 Mar 2016 08:48:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C297BA805E4; Thu, 10 Mar 2016 09:48:08 +0100 (CET)
Date: Thu, 10 Mar 2016 08:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Support profiling of multi-threaded apps.
Message-ID: <20160310084808.GC13258@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56DFE128.6080308@maxrnd.com> <20160309224400.GA13258@calimero.vinschen.de> <Pine.BSF.4.63.1603091646490.69685@m0.truegem.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.1603091646490.69685@m0.truegem.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00090.txt.bz2


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2170

On Mar  9 16:54, Mark Geisert wrote:
> On Wed, 9 Mar 2016, Corinna Vinschen wrote:
> >Hi Mark,
> >
> >On Mar  9 00:39, Mark Geisert wrote:
> >>This is Version 3 incorporating review comments of Version 2.  This is =
just
> >>the code patch; a separate doc patch is forthcoming.
> >
> >The patch looks fine to me code-wise.  I just have a few style requests:
> >
> >>+	if ((prefix =3D getenv("GMON_OUT_PREFIX")) !=3D NULL) {
> >>+		char *buf;
> >>+		long divisor =3D 1000*1000*1000;	// covers positive pid_t values
> >
> >Why "long"?  It's safe to use here, but it doesn't match the incoming
> >datatype.  pid_t is 4 bytes, but long is 8 bytes on x86_64.  If you
> >like it better that way we can keep it in but wouldn't, say, int32_t
> >be a better match?  Also, can you convert the TAB to a space preceeding
> >the comment so it's within 80 columns, please?
>=20
> The "long" was a dumb mistake (and malingering 32-bit orientation) on my
> part.  It shall be made int32_t of course.
>=20
> >I'm also a bit unhappy with some of the comments not trailing on a code
> >line.  E.g.:
> >
> >// sample the pc of the thread indicated by thr, but bail if anything am=
iss
> >
> >// record profiling samples for other pthreads, if any
> >
> >Ideally that would be /**/ style comments, starting in uppercase and
> >as full sentences ending with a dot, e.g.:
> >
> >/* Sample the pc of the thread indicated by thr, but bail if anything am=
iss. */
> >
> >/* Record profiling samples for other pthreads, if any. */
>=20
> I'll go over the whole patch set to get rid of nonleading TABs and to fix
> the comments as you suggest.  The latter was just me not realizing there =
was
> a convention to follow so I didn't :-).  All shall be fixed.

Thanks.

> gmon.c/.h need to be reformatted to GNU style like the rest of Cygwin but
> I'm leaving that to a future patch (NO I AM NOT COMMITTING TO THAT!! :-).

Haha!  But, seriosly, indent(1) is a wonderful tool for that.  With the
right options there's no subsequent manual work.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4TTIAAoJEPU2Bp2uRE+gtb8QAJetgqPQMuKoTh08leydaO4l
EESaySVfy7y7le4O9/sAUaLiqAR2818SZgkJb0oAky0Y2MabaeO+FnHWrfz9wYVY
RtKyE6l6UUHLM80qLOZx6dDYrGtN79ykgaybz+ruT3BDtBUDLv2x1vP4sVcQTapA
st9aFE9zSER7eD7qGDHve1ICyFuaxo/YRW9U35MbvYle+Igwk10a6asunXMl9Nnm
JtCwbtyNxkTqRqaNTY63oParCReIHR1KRBplRPVDIUt+lc+VF400Aa4HTDXeFM++
xQszXz2bynJ7mKbr48GS2uqna8JVz/C5Zg5mupnYGLD7+x2mWehqiPKYUK9FLZHS
mF0aPrnOpYMkqDHddx7Wl+EZyPGet21h406hsd1pS5EV29YO9ytoQWKW4L5bCuWY
wo9Pw418ntN5Wplnde0AGHH1UdTTmztV0l3sDkCEIrqk6UvBrRKwMoO0NZEv6895
CrEMe4ghBdr4/VLurfb5/aeJIOeQfT71LudcH/5iLgVPToaRYBMcZKYIJJHJmaZI
DBMoJaoG7DOKswDf63VX3wyzAHzXE42WbU7wVY3QZGCN0OHJQwUqLN9GOO1g8sW8
iDNzRoE6dQ+FKFmP1iu4lO4AmcGcuqNfU23uLZJnOPS3gD0e8GGVtPbGc13wH7Ws
uwMdLzTKU0E3n0OevJEa
=VNBt
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
