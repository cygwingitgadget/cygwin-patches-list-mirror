Return-Path: <cygwin-patches-return-8261-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13641 invoked by alias); 23 Oct 2015 09:10:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13623 invoked by uid 89); 23 Oct 2015 09:10:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.1 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 23 Oct 2015 09:10:20 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4252BA80443; Fri, 23 Oct 2015 11:10:18 +0200 (CEST)
Date: Fri, 23 Oct 2015 09:10:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Allow overriding the home directory via the HOME variable
Message-ID: <20151023091018.GE5319@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com> <20151021183209.GF17374@calimero.vinschen.de> <alpine.DEB.1.00.1510221731250.31610@s15462909.onlinehome-server.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="IgDDV5QArAYIxtdK"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1510221731250.31610@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00014.txt.bz2


--IgDDV5QArAYIxtdK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 4212

On Oct 22 17:38, Johannes Schindelin wrote:
> Hi Corinna,
>=20
> On Wed, 21 Oct 2015, Corinna Vinschen wrote:
>=20
> > On Sep 16 15:06, Johannes Schindelin wrote:
> > > 	* uinfo.cc (cygheap_pwdgrp::get_home): Offer an option in
> > > 	nsswitch.conf that let's the environment variable HOME (or
> > > 	HOMEDRIVE & HOMEPATH, or USERPROFILE) define the home
> > > 	directory.
> > >=20
> > > 	* ntsec.xml: Document the `env` schema.
> > >=20
> > > Detailed comments:
> > >=20
> > > In the context of Git for Windows, it is a well-established technique
> > > to let the `$HOME` variable define where the current user's home
> > > directory is, falling back to `$HOMEDRIVE$HOMEPATH` and `$USERPROFILE=
`.
> > >=20
> > > The idea is that we want to share user-specific settings between
> > > programs, whether they be Cygwin, MSys2 or not.  Unfortunately, we
> > > cannot blindly activate the "db_home: windows" setting because in some
> > > setups, the user's home directory is set to a hidden directory via an
> > > UNC path (\\share\some\hidden\folder$) -- something many programs
> > > cannot handle correctly.
> >=20
> > -v, please.  Which applications can't handle that?  Why do we have to
> > care?
>=20
> Oh, the first one that comes to mind is `cmd.exe`. You cannot start
> `cmd.exe` with a UNC working directory without getting complaints.

Sure, but then again, why do we have to care?  Didn't you say GfW is
using bash?

> > > The established technique is to allow setting the user's home directo=
ry
> > > via the environment variables mentioned above.  This has the addition=
al
> > > advantage that it is much faster than querying the Windows user datab=
ase.
> >=20
> > But it's wrong.  We discussed this a couple of times on the Cygwin ML.
> > The underlying functionality generically implements the passwd entries.
> > Your "env" setting will return the same $HOME setting in the pw_dir
> > field for every user account.
>=20
> No, it will not, because most users are not administrators. So they can
> only set environment variables for themselves.

You're looking at the problem from the wrong direction.  Consider how
the mechanism works.  The setting in /etc/nsswitch.conf configures how
the passwd/group entries for all accounts are created.  Your "env"
setting fetches the environment of the *current* user and generates
the passwd entry for *all* user accounts from it.  Here's what happens:

  $ echo $USER
  corinna
  $ echo $HOME
  /home/corinna
  $ getent passwd $USER
  corinna:*:1049577:1049701:U-VINSCHEN\corinna,S-1-5-21-913048732-169718878=
2-3448811101-1001:/home/corinna:/bin/tcsh
  $ getent passwd Guest
  Guest:*:1049077:1049090:U-VINSCHEN\Guest,S-1-5-21-2913048732-1697188782-3=
448811101-501:/home/corinna:/bin/bash
  $ getent passwd Administrator
  Administrator:*:1049076:1049089:U-VINSCHEN\Administrator,S-1-5-21-2913048=
732-1697188782-3448811101-500:/home/corinna:/bin/bash
  [...]

This is plain wrong.  You can't seriously provide a mechanism which
fetches data from the current user to generate the output for all users
from there.

> In most cases, `HOME` will not even be defined, but `HOMEDRIVE` and
> `HOMEPATH` will, and they will be correct.

That's not the point.

> > All user accounts will have the same home dir as your current user.  And
> > the value is unreliable, too.  If another user logs in, all accounts
> > will have another $HOME, the one from the now logged in user.  This is
> > so wrong and potentially dangerous that I don't think this belongs into
> > Cygwin, sorry.
>=20
> I ask you to reconsider.

I did, but the result is the same.  As is, the patch is not acceptable.

Here's what you *could* do:  Create a patch which fetches the pw_home
info from the current user environment for the current user only.  For
all other accounts, the info must be taken from elsewhere, one of the
other methods.  E.g., the env setting only affects the current user
passwd entry, not any other.  For all other accounts, the env method
provides no result, thus falling back to the next method in the row.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--IgDDV5QArAYIxtdK
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWKfl6AAoJEPU2Bp2uRE+g/eoP/2jEkvkU6OXL5QNxmuHRczaF
yfQrCZXvXNCeWN4P/ucKtwXboeRWUyQ4FBA1FU3QVT6d3q5aWQuLUHkcp4DKFRaw
4DQMw01C5Wy//8nEGNt34qZ6wd1wY9hSwMARZtFfejgS1FktwIctWkUMzT3lOyLt
oldJOVwpxtHhEAuELdD13oUM+T+q7FQgIT6QHDPRXQItkyWR2+PYqCDU9FKM2+FU
StaVUsHK0oO25HHgO7j14okV4fu09OS0f5XPPCBT7ZPtM5Jh8UoJFqGytMMXvLlc
2uBGSZnut7W1nPJVSGq6sY4OI6cNVxusMBZYvL3GCE5h87ESoLTbf1OdJZsedCib
qOkFSPzeoeAbWgoD2C2C3gZR5e7LZF+8hXP0C5zJz4kBCwCHo4gICNafCMun9NMO
ultxrLFIlXAXMKCx7J6mS9KIWpGdK00RdUIGzZxYZtSBwfz2qJvVpFQK6ukOvS0x
SrynzaoX45Fvm9YsIUd+PP1PJS9l32a8OQTPxYNwZfKIxGejsiVcubN5J9CfB149
7JnoU/IfsgjNaMW1HqNsOttE5b/mnf9jlDEBeRQlzoxoygvmx+wPpoONkTZHfyy5
RdQDCxGpqSPNhOqNN0V3oV1tM0LV/CaQVkWxTmnYcA+KT8WKUwUUVEoAmjrJB8hz
DO2K8IxDermAsO45fNnJ
=GHJV
-----END PGP SIGNATURE-----

--IgDDV5QArAYIxtdK--
