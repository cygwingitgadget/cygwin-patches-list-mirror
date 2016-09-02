Return-Path: <cygwin-patches-return-8633-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98081 invoked by alias); 2 Sep 2016 09:03:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98047 invoked by uid 89); 2 Sep 2016 09:03:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=pathname, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 02 Sep 2016 09:03:05 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id DB111721E280D	for <cygwin-patches@cygwin.com>; Fri,  2 Sep 2016 11:03:02 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 3A6E85E07DB	for <cygwin-patches@cygwin.com>; Fri,  2 Sep 2016 11:03:02 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2BAEEA8059C; Fri,  2 Sep 2016 11:03:02 +0200 (CEST)
Date: Fri, 02 Sep 2016 09:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/4] dlopen: on x/lib search x/bin if exe is in x/bin
Message-ID: <20160902090302.GB7709@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1472666829-32223-4-git-send-email-michael.haubenwallner@ssi-schaefer.com> <20160901133255.GC1128@calimero.vinschen.de> <21ed8215-f321-ed7f-e06a-fa6f36900d65@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <21ed8215-f321-ed7f-e06a-fa6f36900d65@ssi-schaefer.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
X-SW-Source: 2016-q3/txt/msg00041.txt.bz2


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 986

On Sep  2 10:46, Michael Haubenwallner wrote:
> Hi Corinna,
>=20
> On 09/01/2016 03:32 PM, Corinna Vinschen wrote:
> > You could just use the global variable program_invocation_name.  If in
> > doubt, use the Windows path global_progname and convert it to full POSIX
> > via cygwin_conv_path.
>=20
> Patch updated, using global_progname now.

Looks good and you're right to do it this way since I just noticed
that program_invocation_name may return a relative pathname.

Btw., in other calls which require the full POSIX path we use
mount_table->conv_to_posix_path instead of cygwin_conv_path (see
e. g. fillout_pinfo()).  It's a bit faster.  Maybe something for a=20
followup patch.

Note for some later improvement:  I really wonder why we don't store
the absolute POSIX path of the current executable globally yet...


Thanks,
Cornina

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXyUBFAAoJEPU2Bp2uRE+gAgYP/1RTWLaeJdp+EnvuWGBC0byr
GP9QX+QJ2Q/IGcw8qj0oKer6cYPHqlAVZYCCWyTQHKJgeR1/Q14V8n+HRMhAUq6N
EznPjhHG2QxguCWx7ZDah9k4goSVBNhx4YGfQnFj1UKBb02ugynPE4cRJK/FyF7j
uxTeIf0GKeGOsMtu/3g90YD62i+GQ/s2PT+D5yY8qKYN9I4t8ixrJy30bkHYlyzd
1kfeyezcInvRuRosinmJhFj9BxbNRnlCGFcWBIKtQd6CDICs+xzuoi3AKlfVzPSn
TDcJYGaP/4rewH76PBYdtmQpjncPSmwuFNCCgAdIMv7asjRltqnwAozWGUW5eIWM
jf/onrYJ0/uXdtfeT9B3+m47ruAaAHZazEiuZD4dOpDKOJA3NPM8xT/OH8jac9ex
t4VQLYFEgQMLyV9EunzL3fTaPT15KAl1RUkOYFwl4HvPtzVH0BurxJeNcTHE90XI
DkTnrcy2yxnpXbx3xAOY7uIGdKcGNpTJQIaTP4WAwd9cKC4VrZmhiprjs3+/ZIxH
teMLM+l0LHufL31LrMoAPETlYIANCBFLtNPaiyDjUf+23xmhzRthci/8XJk7YBj0
77ngJHo+yUM87OOZUxRz4qevP/4x6sGjZy0pmgZ5MAwpWHrmKbiI9+z6XY6Z7CI7
Q6uNQX++dqmchda33ewj
=2wA0
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
