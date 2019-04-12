Return-Path: <cygwin-patches-return-9331-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 125759 invoked by alias); 12 Apr 2019 17:58:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125749 invoked by uid 89); 12 Apr 2019 17:58:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:698, H*F:D*cygwin.com, somewhere
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 12 Apr 2019 17:58:29 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N33AR-1gs1QF3DJt-013JuR for <cygwin-patches@cygwin.com>; Fri, 12 Apr 2019 19:58:26 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B2B56A806B7; Fri, 12 Apr 2019 19:58:25 +0200 (CEST)
Date: Fri, 12 Apr 2019 17:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fork: remember child as late as possible
Message-ID: <20190412175825.GD4248@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <2cc9ac65-ff3c-f88e-e8d3-13105115bdcf@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="SqfawxHnX56H7Ukl"
Content-Disposition: inline
In-Reply-To: <2cc9ac65-ff3c-f88e-e8d3-13105115bdcf@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00038.txt.bz2


--SqfawxHnX56H7Ukl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 644

On Apr 12 15:31, Michael Haubenwallner wrote:
> Otherwise, when the child does fail to reload dlls and terminates, we
> produce a SIGCHILD signal, even if we did not succeed in starting up the
> child process at all.  Also, we would need to reap that child somewhere.

I'm not that happy with the patch.  The patch is doing two things, one
is to remember child as late as possible, the other is to change the
child startup in case the parent loaded dlls.

Either write a more descriptive commit message or split this into two
patches.  I'd prefer two patches.  It may help debugging.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--SqfawxHnX56H7Ukl
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyw0cEACgkQ9TYGna5E
T6AAPxAAh+ppPiIeQvBvkhab/swIFTyKMxSYsVl1BippJKOYexOE0MfVKyqtaSk6
OJLgL4rHTcq72M+EZLeNvna820LOEv6OK28r2fzgXPv3v/K2s27+aI9VDkkxdpE6
1HJ6Fpe0KZvRuJ0WIcwM7XQXFjXP2zuGaxsoV1KGf7REx7L0tMncK/xLieqjqEik
B6ivaMCvsiBC32ytzTpqURkaLkduf9sgXs+dU2SZwcZdgyodwtPEUz7VYyhaDQ7f
asInJUdWskdXC9OnCh3d6v9Bd3y/HYRAA6OBu3wwDg+wgRS/U+r761Qa3Uzz43Af
JCO0IuGjQccYaJ5KRmoVZ1FY/uNsCTz1c6rifco3OKFZkibUrApjEtr6JDMGl2v9
YVdtLBHCt1NjtBLHl+W1+qjdTAeXGd6pWS11OBVkpH5qGk7jtadvKk4Gn8IvrgMj
eKheVdiIKz6/EiKkH41E9xO2jbXvGsS74ayo3PdSthQ7ktCqmGOdU9ZxcfjWd3Eg
Ti7ZjMJHTf92HMFQuGeqNWElppH3PgtoiE8KVMocZ0lb9ppwriB+aXBIXERKE/I+
fZihrgYJaxKQwXgkwoFhiU+1cAxEM0viMBX49RUsaKzCWlW3x7R9sGNVPVT6ng1e
4YiW1+sY0+EV2fxOQ9pjGZ9F16/5jrv+D7GxV5fhJXEJRpXxkwo=
=rY2F
-----END PGP SIGNATURE-----

--SqfawxHnX56H7Ukl--
