Return-Path: <cygwin-patches-return-8809-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17034 invoked by alias); 24 Jul 2017 09:31:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17019 invoked by uid 89); 24 Jul 2017 09:31:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=ado, limbo, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Jul 2017 09:31:14 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 770E8721E281E	for <cygwin-patches@cygwin.com>; Mon, 24 Jul 2017 11:31:11 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id B387E5E0359	for <cygwin-patches@cygwin.com>; Mon, 24 Jul 2017 11:31:10 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 92677A80448; Mon, 24 Jul 2017 11:31:10 +0200 (CEST)
Date: Wed, 02 Aug 2017 08:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin strptime() is missing "%s" which strftime() has
Message-ID: <20170724093110.GA5104@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BY1PR09MB0343663DE41D927E67CF0CCEA5BB0@BY1PR09MB0343.namprd09.prod.outlook.com> <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00011.txt.bz2


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1619

Hi Brian,

On Jul 23 22:07, Brian Inglis wrote:
> On 2017-07-23 20:09, Lavrentiev, Anton (NIH/NLM/NCBI) [C] wrote:
> >> But that's just scanning a decimal integer to time_t.
> >=20
> > It's not a question of whether I can or can't convert a string into an =
integer, rather it's a question about portability of code that uses %s for =
both functions and expects it to work unchanged in the Cygwin environment. =
 Also, strptime() was designed to be a reversal to strftime() (from the man=
-pages: the  strptime() function is the converse function to strftime(3)) s=
o both are supposed to "understand" the same basic set of formats.  Because=
 of Cygwin's strptime() missing "%s", the following also does not work even=
 from command line:
> >=20
> > $ date +"%s" | strptime "%s"
>=20
> Attached diff for proposed strptime %s and %F support.
> Let me know if you would prefer a different approach before I submit a git
> format-patch.

Approach looks good, so please send the patch to the newlib mailing list
with a nice log message.

In fact, just send patches like these immediately in the right format to
the right list.  Chances are good that the patch is taken without further
ado and you skip the part where you have to send the patch twice :)

In this case I have a nit, but this should be discussed on the right
mailing list so all affected parties can chime in.  Hint: strtoimax is
not available on all platforms yet (patches still in limbo)...


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZdb5eAAoJEPU2Bp2uRE+gA4cQAKRVDaKKjAqWYtXxR+7Wd8Q2
lxjcwddQGE8jqgFsdE7XVPIe1Ilr3sW1TriGn3SZ4i1s1csDAwwd6214SfVpn3Km
m5N679eGf2831G5NbowvbVAPnzz+kOsyrq0lzYMVkHcK1JycWSjNqjoitVkfw4MR
GPTE9/29lDQ5UbZajiHv3UgcVEr6eoJSIwWqSUoifM5qH8usaB3taNOy2W0DrGlb
J2xQn5YaRMUiB5CW3/EY8BVSAqpHEEzBLNgbb/VyLwl6t1X6QQvuBMT6BOx/20iw
g/PcI/TgaMi5xdjZDB5ndpK4dHj0LHs6QgZQ5Yums6YNd4/HPnTrd6Bv7BeqCpoM
uFtOo+GJMfgKRrHWEYAapdxLe25QZ4r5XP0Gmja1hQQXq1IoeCS2bjMBEJVTSs+y
+oyJGQ8lB4NSRXFMX8m1WqjHdeRvUX0guFNdCVf/i0PzbO3mI+miH4JxDDzx8ir5
ULy0CtcZkxxYud2k1klU820OmshE15eTyF4HjfyfQWkGXbSHWfZ9uxT5B3v6Xtdo
+ZSAQEPIk/TNGsaEHahvUjftFDopCW1e5h+KMIuxfqKeLDVeR5pU7Zwv61dZ6h9y
zI4CK/a05Z4X0kRDkkpGe6VauUuKR5sKI9Cpvgl4eDpls3eEmKuYvYYHWeD3jO77
AkhRYLRxUhhxzPGFNuhI
=RFoY
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
