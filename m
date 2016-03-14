Return-Path: <cygwin-patches-return-8396-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24406 invoked by alias); 14 Mar 2016 10:13:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 23567 invoked by uid 89); 14 Mar 2016 10:13:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=HX-Envelope-From:sk:corinna, Aside, H*R:D*cygwin.com, HTo:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 14 Mar 2016 10:12:59 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 76E21A805E5; Mon, 14 Mar 2016 11:12:57 +0100 (CET)
Date: Mon, 14 Mar 2016 10:13:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: Cygwin select() issues and improvements
Message-ID: <20160314101257.GE3567@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56C03624.1030703@glup.org> <20160215125703.GE8374@calimero.vinschen.de> <56C66DDE.9070509@glup.org> <20160219104641.GA5574@calimero.vinschen.de> <20160304085843.GB8296@calimero.vinschen.de> <56E5DD8D.7060302@glup.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Content-Disposition: inline
In-Reply-To: <56E5DD8D.7060302@glup.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00102.txt.bz2


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1437

Hi John,

On Mar 13 17:37, john hood wrote:
> On 3/4/16 3:58 AM, Corinna Vinschen wrote:
> > John,
> >=20
> >=20
> > Ping?  I'd be interested to get your patches into Cygwin.  select
> > really needs some kicking :)
>=20
> Sorry to be so slow responding.  Here's a rebased, squashed,
> changelog-ified patch,

Thank you.  Uhm... I just don't understand why you squashed them into a
single big patch.  Multiple independent smaller patches are better to
handle, especially when looking for potential bugs later.

Would you mind terribly to split them again?

> and I've sent an assignment in to Red Hat.

Cool, thanks!  This might take a few days.

> Aside:  Why maintain Git comments in ChangeLog format?  That made sense
> up into the CVS era, but now version control systems and viewers provide
> most of the details that a ChangeLog needed to list, and newlib/Cygwin
> has stopped maintaining ChangeLogs.

It's probably the "get off my lawn" mentality of old, die-hard CVS users.
Both, Jeff and I, the maintainers of newlib and Cygwin are such specimen.

I'm in the process of reconsidering it for Cygwin-related logs.  I'm still
mostly sticking to these ChangeLog entries, but I'm moving over to adding
textual descriptions to the git log.  See my latest commits for examples.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW5o6pAAoJEPU2Bp2uRE+gSwQP/03aDW/7VAzDn4j0pCHwCZB/
xlh2WiMSp8ev+GSMXYEg/74Qrv2zQsRpe72iJJB3xhws7Dm8M349q2E1IyC/pFia
nDEf5XCNvgR8yLzIcmhvx0DzQjWxvqejlpx46x/jd3zwXpZdfkkGYC/NMxIFff39
HTJ1YCnRLAOsqiOggvY5plwAbxmCGsqNeNrWzpHNSRYQ5WC1VSU9lvOwyCATVNeV
bae5/LmXXibZMIELAunTOpgUTkyG/fkYIdY5emoUP5NpWGRAqfS6nZGuHaCUkLZB
gPpvOsdWGwyg8QKnf/Uk4Nyo7W9ydLXPeFHF3fqoLjOXwvXDK2KwprGxfKO8cZY1
00B4iCAsZToU4WOsJFsm8TjbkSngN4NT3obi5gLEw8YkoTt2vpu95SWSCeVgBWvO
/EPAbrnPoCIxA40i5TwSoEYnxSUXUddNdttW2w/vS+oQtzcxIvlmYC58gAzUbKyw
Zdy81zh/l37WvXbBH/JuvJOqu4DPBN8UuFot6LxqkAI9H0Pb13tpNwzzxChKGztg
mggrT6oargJLWsXfFc/4j1xTHIn35OAZIxd/nazdGZnQwcyZ50xDrc3jIjBMPNwJ
kLUku5DlssC/KRfKlWTwWD/6Jz/zLc4lO6dwRndb5QYcFj/6xxyeEUgoXGbNcO4z
PX4bY0IFig1ob8LCzEwe
=yyQz
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--
