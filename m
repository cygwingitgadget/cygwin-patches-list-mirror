Return-Path: <cygwin-patches-return-8255-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 108002 invoked by alias); 21 Oct 2015 18:32:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 107968 invoked by uid 89); 21 Oct 2015 18:32:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 21 Oct 2015 18:32:12 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E09EAA803D5; Wed, 21 Oct 2015 20:32:09 +0200 (CEST)
Date: Wed, 21 Oct 2015 18:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Allow overriding the home directory via the HOME variable
Message-ID: <20151021183209.GF17374@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Content-Disposition: inline
In-Reply-To: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00008.txt.bz2


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1913

On Sep 16 15:06, Johannes Schindelin wrote:
> 	* uinfo.cc (cygheap_pwdgrp::get_home): Offer an option in
> 	nsswitch.conf that let's the environment variable HOME (or
> 	HOMEDRIVE & HOMEPATH, or USERPROFILE) define the home
> 	directory.
>=20
> 	* ntsec.xml: Document the `env` schema.
>=20
> Detailed comments:
>=20
> In the context of Git for Windows, it is a well-established technique
> to let the `$HOME` variable define where the current user's home
> directory is, falling back to `$HOMEDRIVE$HOMEPATH` and `$USERPROFILE`.
>=20
> The idea is that we want to share user-specific settings between
> programs, whether they be Cygwin, MSys2 or not.  Unfortunately, we
> cannot blindly activate the "db_home: windows" setting because in some
> setups, the user's home directory is set to a hidden directory via an
> UNC path (\\share\some\hidden\folder$) -- something many programs
> cannot handle correctly.

-v, please.  Which applications can't handle that?  Why do we have to
care?

> The established technique is to allow setting the user's home directory
> via the environment variables mentioned above.  This has the additional
> advantage that it is much faster than querying the Windows user database.

But it's wrong.  We discussed this a couple of times on the Cygwin ML.
The underlying functionality generically implements the passwd entries.
Your "env" setting will return the same $HOME setting in the pw_dir
field for every user account.  All user accounts will have the same home
dir as your current user.  And the value is unreliable, too.  If another
user logs in, all accounts will have another $HOME, the one from the now
logged in user.  This is so wrong and potentially dangerous that I don't
think this belongs into Cygwin, sorry.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWJ9opAAoJEPU2Bp2uRE+gTBUQAIFZS20rLpxaMdjLaWoLNu9v
P9Iq06N1sk8uG+nBlfvQx3Ua/FVu1gUPCNPj8prHRimgboo/eH5HSWopj7k/BthE
nM6SaVXukAYwjkZublnHHwfZZTiKiKLBUtkPe6kdwcqK5nenwkcs83irE3k3bpma
YiXC7kkc8kBYm8oSS1VhMQduF0Jfs73LQmLqn/hSU2otl5RfGuwXPp9nlRv/u2pf
1mC108QhJKJVknmojLHmp9sJNTZESi6frjfRuUH0caNmehbW3vtUlFRSL7+ynMBW
e3Cied51YS92/3OYkBpz1d9wg4ZztcALHRH5DWIAha4foH7ghQ9AbJjcLzzVCtPE
qQ2j1Ug0e7W9GiLLMglHY5aZDeH62urrcXzGvORK1G2iNC7CyqUPWF3+7ivqYt+L
3KRUW/FfpJae9QImep0nfD51rB2ADab+TScHwkjEHKNDgFxFpX5Pp3ztk1OWqlkC
+5nIXRU8UswcjbwHbf/sjdHMgdYRwkf6fD/Fg/8TzoLTPvb0Txwmie32jKJy5n+v
3gS++n6WJ2mlSkChI4M/suBuc8iLEK5xoh8F6FdxApu4JUlT9hMCGfQ9wr/KC3Lj
/kKAI/OlwHpTMnWdHWMtmLe1xQa9YHATJrTYxlrtmNTzh0LD5iLt47FyyV0fTBTp
lOiWWTh9Z7ecHRBc7nUj
=/MXg
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--
