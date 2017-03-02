Return-Path: <cygwin-patches-return-8705-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 60682 invoked by alias); 2 Mar 2017 10:35:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 59232 invoked by uid 89); 2 Mar 2017 10:35:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=states, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 Mar 2017 10:35:11 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id B3AEA721E2825	for <cygwin-patches@cygwin.com>; Thu,  2 Mar 2017 11:35:08 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id E714E5E03CA	for <cygwin-patches@cygwin.com>; Thu,  2 Mar 2017 11:35:07 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C6E8AA80405; Thu,  2 Mar 2017 11:35:07 +0100 (CET)
Date: Thu, 02 Mar 2017 10:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: (fixup) [PATCH] forkables: use dynloaded dll's IndexNumber as dirname
Message-ID: <20170302103507.GF24619@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9f8649cf-0293-cce7-f4a1-84433d62152d@ssi-schaefer.com> <20170223140347.GK23946@calimero.vinschen.de> <fde647fb-1b6c-4a2d-cf9f-93bd7f2c9750@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <fde647fb-1b6c-4a2d-cf9f-93bd7f2c9750@ssi-schaefer.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00046.txt.bz2


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3478

Hi Michael,

On Mar  1 20:18, Michael Haubenwallner wrote:
> Hi Corinna,
>=20
> On 02/23/2017 03:03 PM, Corinna Vinschen wrote:
> > Hi Michael,
> >=20
> > I'm inclined to promote the "forkables" code to master.  I just have a
> > few points before we do that:
> >=20
> > - Revert bumping of CYGWIN_VERSION_SHARED_DATA.  We only have to do that
> >   if the shared region changes in an incompatible way.  But this is just
> >   adding a member to the end.
>=20
> Ok.
> As long as properly aligned, even int-access should be atomic:
> Is it ok to add the new member as 'char' rather than 'int'?

What about using a LONG?  It allows atomic access and is the right type,
should we find that we have to use Interlocked access at one point.

> > - I'm looking a bit cross-eyed on the usage of forkables_needs and
> >   cygwin_shared->prefer_forkable_hardlinks.  It seems to me as if the
> >   split between those two isn't quite right and the fact that both
> >   share information seems error prone.
> >=20=20=20
> >   IMHO prefer_forkable_hardlinks should actually be the single marker
> >   for the per-installation state.  After startup of the first process it
> >   should be "unknown" (0) by default.  At startup it's set to one of
> >=20
> >     "disabled"   (-1)	no NTFS or dir is missing
> >     "enabled"    (+1)	NTFS and dir exists
> >=20
> >   That sets the state once and for all by the first Cygwin process in
> >   the system.
>=20
> The initial check now is moved to dll_list::forkable_ntnamesize(),
> which is called by dll_list::alloc().
>=20
> What about the renaming cygwin_shared->prefer_forkable_hardlinks
> to cygwin_shared->forkable_hardlink_support?

Good idea.

> The new dll_list::forkables_supported() replaces the "unknown","impossibl=
e",
> "disabled" values.  I've thought about inlining into dll_init.h, but that
> would require to include "shared_info.h": Is there a specific reason behi=
nd
> dll_init.h not having any #include right now?

History.  At one point there was a rule set to reduce include-creep in
header files and to move the includes to the .c and .cc files as much as
possible.  I think the driving factor at the time was compile time,
which is pretty moot these days.  I think it would not hurt to include
obvious local dependencies directly from the affected header, but you could
also just include shared_info.h prior ro dll_init.h in affected sources.
AFAICS, 3 of 5 already inlcude shared_inof.h anyway.

> >   Consequentially, forkables_needs should only reflect the per-process
> >   states
> >=20
> >     "needless"
> >     "needed"
> >     "created"
> >=20
> > - Shouldn't forkables_needs be renamed to forkables_needed?
>=20
> I've further simplified and replaced "enum forkables_needs" with
> "bool forkables_created", because the "needless" value now is
> implemented as "first fork tries without hardlinks". So as soon as
> request_forkables() is entered, hardlinks aren't "needless" any more.

ACK

> > That's all.  There are a few minor formatting issues, but they are
> > negligible.
>=20
> Do you prefer another patch series with this patch applied as fixups?

No, just send patches.  I think keeping the history of changes is helpful
in the long run.  I'm going to apply the attached patch as is, and you just
follow up with a char -> LONG patch, ok?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYt/VbAAoJEPU2Bp2uRE+gWyIQAI1f5ZFi/1ZZI/uiCLUul/cm
lmBO2Q5ZdghKeQ1OaeSdVnJ394NObIVP9XkaO/nVSmbWGOJaEaUWkiFvqNBjRESS
/OH0qmB163ZpAVl6XJFkoDSrz7JIyWZeSotokpiX/3pYr4S6cl4VX5LVTr06t8R4
b3QqZqo389N5kB0qqfPQkwLyD/g8L97SSnvzZX2igXQXUiepynu6bbwUwmPo9fvC
8ie8497zojgoeoWcbYGsSQONQbOQ0ZqcP9aGE01UFadKDbnjM8X4gi2r/dUM5Irp
fxlcad+hkERt5VDK80s57vuzmScJ65an0g9z+GlD4QjIo4BRAzepSoewX2GUdaeU
LYJkK0cxM8b/geCrfuJGYgOvUG4H6RjqsHNDMWOwcoCN/HOsQcGe97wpAshdmVKO
YxXF3/x5PRzWsGNipx8tif18nhfhd63c15gGTXCrL26NnNS6LbTw3NutFY/2FGuL
38zhpki8K9PwohveEBuRRVh6uPTlGgCWLTqK7mKqv+U+HsOy8XQbTcx9EIyRTTLC
24Ws9UTVy1trQaST5FmYUKkyT3z6iZ12aBkMwzzPsiOxjFI6D6yO8uVcUjHw2QrJ
G6JWWZUlK57AMGZH4BJG5fvLSEUaEq/XAFIYML440yfGgVuSyeuIoKM/W1r9VyHp
DHVLntW0A5QCXCaLlAAK
=98dk
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
