Return-Path: <cygwin-patches-return-9201-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 38613 invoked by alias); 19 Feb 2019 17:21:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 38541 invoked by uid 89); 19 Feb 2019 17:21:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-100.9 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=displaying, chose, H*F:D*cygwin.com, states
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 19 Feb 2019 17:21:31 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MvJs9-1hEE240fjt-00rIHo for <cygwin-patches@cygwin.com>; Tue, 19 Feb 2019 18:21:29 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B504DA804BC; Tue, 19 Feb 2019 18:21:28 +0100 (CET)
Date: Tue, 19 Feb 2019 17:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add secure_getenv
Message-ID: <20190219172128.GO4256@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190219050950.19116-1-yselkowi@redhat.com> <20190219114330.GK4256@calimero.vinschen.de> <20190219115910.GM4256@calimero.vinschen.de> <a31c3d43c9866900e7938015e2fed2c93712348e.camel@redhat.com> <b434e09b-94a5-c7af-db2f-3a9d2dfe991f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="tQHaQFR6K/xpRpl8"
Content-Disposition: inline
In-Reply-To: <b434e09b-94a5-c7af-db2f-3a9d2dfe991f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SW-Source: 2019-q1/txt/msg00011.txt.bz2


--tQHaQFR6K/xpRpl8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2014

On Feb 19 11:14, Eric Blake wrote:
> On 2/19/19 10:58 AM, Yaakov Selkowitz wrote:
>=20
> >>> "Secure execution is required if one of the following conditions was
> >>>  true when the program run by the calling process was loaded: [...]"
> >>>
> >>> Do we ever have this situation?  We don't have any capability to make
> >>> real and effective user ID different at process startup.  But from th=
at
> >>> description it seems secure_getenv does not trigger secure mode if the
> >>> process calls seteuid() or setreuid() later in the process.
>=20
> It says it may also be triggered by some Linux security modules (for
> which I'll assume that can include states that were not present at
> startup).  The main reason it was invented was to ensure that a setgid
> application CANNOT be negatively impacted by LD_PRELOAD and friends
> prior to main(), because all of the startup code in the dynamic loader
> was switched to use secure_getenv() for any place where the loader can
> normally be influenced by the environment.  But the wording sounds vague
> enough about what other situations may be considered as security that it
> is easy enough to just state that you should always be prepared for a
> NULL return when using the function.
>=20
> That said, while it is ideal to avoid squashing to NULL in situations
> that are not security boundaries (as with your STC displaying HOME even
> after seteuid() on Linux), I'm also okay if we filter too aggressively
> (the way gnulib's fallback implementation does when neither
> __secure_getenv() nor issetugid() available).

In fact, gnulib's implementation would chose the

   if (issetugid ())
     return NULL;
   return getenv (name);

branch on Cygwin right now, just as on BSDs.  If that's the right thing
to do for BSD, it's not... *really* wrong for Cygwin either, regardless
what Linux is doing.

That in turn means Yaakov's patch is perfeclty fine since it's equivalent
to the above gnulib code.

Agreed?


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--tQHaQFR6K/xpRpl8
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlxsOxgACgkQ9TYGna5E
T6A+gg//arfdY22dIRysXE/0iFs6zYtNbgMnvH1te9B+c4AABhbjqX1sziBocuYp
Kbe18IABPAS80f7jbZwE6UM5gBJVvXzDvCpXiUtmTEngj5C71Ll+zQap5aJC5bgF
QBvHrbdUDa/AFp6Vr4x5C9nvSaP6J1EnK5c1KWeT0Y+nUZHOwdNh8WHsMbEgfWEY
cul4Ro4ROEzy6QFejUFWwOu/On2S3HA/OEaXJrA3JEeyvp4NR56PdWWa3X9zauUV
cwptw+whJDpZ1Zy+WFAkpT3Mjunx/aZXOaOaN3W9DL76BCgB+qUz7hgBNxjb7EVy
3hfZCS7duYJF4gNSpsbrwwSLECc2+ZX0a5deirpNfHM18dJr3IUKnXaj9yQ5J4SB
CN3PQz2TO4Q50FhYFg9o7uLI8BZaHc9xdlCWo7YEc4hHSkkpXGP3Q4ys3d7t0Gdr
giVBKHoM+FFWFA5sQ4czqw9M1+VdooR6BRvFjTBE1N9BLs0a03c/RC1Lzd5APhpK
Nd8+FY4Mvgzln3SdNao0lN1foOtuNub7wBDpb9H23pZ8eld3dS4SZ5SRsBT8zAhJ
UxBR3FoSVGkaQ27u3pjN1mzVsE02j4p9QJzPTR1RhEr42oHlrXPfSs3/yG9F1hZf
YiAWE9eAF+Z/plw1tL89oLRdCpJ2M5BM2cD7lyJf+EBUYeA6vAY=
=HqoH
-----END PGP SIGNATURE-----

--tQHaQFR6K/xpRpl8--
