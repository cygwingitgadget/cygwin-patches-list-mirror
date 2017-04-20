Return-Path: <cygwin-patches-return-8749-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51399 invoked by alias); 20 Apr 2017 08:45:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51385 invoked by uid 89); 20 Apr 2017 08:45:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-98.3 required=5.0 tests=AWL,BAYES_00,CYGWIN_OWNER_BODY,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=bounced, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, respond
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 20 Apr 2017 08:45:45 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 5D07D721E281E	for <cygwin-patches@cygwin.com>; Thu, 20 Apr 2017 10:45:43 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 885385E049A	for <cygwin-patches@cygwin.com>; Thu, 20 Apr 2017 10:45:42 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 64C13A80C17; Thu, 20 Apr 2017 10:45:42 +0200 (CEST)
Date: Thu, 20 Apr 2017 08:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] strace: Fix "over-optimization" flaw in strace.
Message-ID: <20170420084542.GA16686@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170418100400.GA29220@calimero.vinschen.de> <20170419160602.3952-1-daniel.santos@pobox.com> <20170419184813.GH30642@calimero.vinschen.de> <c124d390-11ce-7951-2f73-8a8ad21408da@pobox.com> <cbc8f410-dc59-8427-f221-ab43fb8ff0ca@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <cbc8f410-dc59-8427-f221-ab43fb8ff0ca@pobox.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00020.txt.bz2


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 692

On Apr 19 17:24, Daniel Santos wrote:
> On 04/19/2017 05:10 PM, Daniel Santos wrote:
> > Thanks. I hope this message goes through. Earlier when I tried to
> > respond with both you and cygwin-patches in the To: header it bounced. I
> > emailed cygwin-owner@cygwin.com about this, is that the right address
> > for mailing list problems?
>=20
> Actually, any email I send with corinna-cygwin@cygwin.com in the To header
> is bounced.

Yes, it's a write-only mail address.  Please send stuff only to the
respective mailing list.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY+HU2AAoJEPU2Bp2uRE+gKukP/0e11YY7yo6RoLOma75eEMqO
gVtmXgiFx9eBmSTzFHoqo/O+l3P7cJZNNTMSKciLxSrWgMJuabP6okKkbg0CEsff
BnrgTuZqOdeSEc9/GmBGYjz3ipBKw1C/VrDfrgRetsFJ9D/nd+iCPcgu0nThujDk
wxsa+pz3ugqlbSXMLTzHFBoB0sMgHUzUo+D9OSH2rphRj401NIE+Q/A5yZXuQLMD
DXEIzezTKnL81emokEwLf8+pWGLHcyFOOB8I8zahKKxtrf0xWKNWt/2WIJudPOsq
KRbxDBxemwAj7K9sYrVv1z5Jr/q3RcFNHsC363+Y+ISdyye9YTzasJqAQs2oXO5d
M7lLhHBRTMaU5lxpnu41mjOHnz/G1IILZi0dXtBSmu64Doies8JzI0GiPIyYZdqG
32n4q/E3g9jf5SFEwFiTqbPqV81ZC3GoRvxYj3/Tkqf4vOCpixEzWkd/QZlHupgg
rrry1EpEdzr41j6GosSa4akD3+yuz1MU3Jsw4WMY6VJYtkKB+J3uwPh0RgXu6ws7
hF2VyUnBYjknJvxScgFJg8EASYFmYQgo8E3TiKQgVRNVxX429Qd4/rCUfcWMAQwQ
tNx7MaFIuKe2OrWpNS6GSn8E8pFfCC3dwjJ24HWCvhCLGwdH90yibdkQBp3BkApM
/3Pe/C+ynAON3dVvmx81
=p84g
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
