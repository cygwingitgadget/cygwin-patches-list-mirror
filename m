Return-Path: <cygwin-patches-return-8976-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11783 invoked by alias); 18 Dec 2017 18:49:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11667 invoked by uid 89); 18 Dec 2017 18:49:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-100.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 18 Dec 2017 18:49:06 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id BB15C72106C24	for <cygwin-patches@cygwin.com>; Mon, 18 Dec 2017 19:49:03 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 7504A5E0389	for <cygwin-patches@cygwin.com>; Mon, 18 Dec 2017 19:49:03 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DA64DA805AA; Mon, 18 Dec 2017 19:49:03 +0100 (CET)
Date: Mon, 18 Dec 2017 18:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Implement sigtimedwait (revised)
Message-ID: <20171218184903.GC11285@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171215010555.2500-1-mark@maxrnd.com> <20171218091700.GA11071@calimero.vinschen.de> <Pine.BSF.4.63.1712180131070.73988@m0.truegem.net> <20171218104855.GA7214@calimero.vinschen.de> <d2824b5f-b5a3-9e24-64bf-455668ab149b@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <d2824b5f-b5a3-9e24-64bf-455668ab149b@cygwin.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00106.txt.bz2


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1043

On Dec 18 11:07, Yaakov Selkowitz wrote:
> On 2017-12-18 04:48, Corinna Vinschen wrote:
> > On Dec 18 01:34, Mark Geisert wrote:
> >> On Mon, 18 Dec 2017, Corinna Vinschen wrote:
> >>> Hi Mark,
> >> [...]
> >>> as I wrote on Friday, the patch looks good to me.  I just need a
> >>> contributors license agreement from you per the "Before you get start=
ed"
> >>> section on https://cygwin.com/contrib.html
> >>
> >> Hi Corinna,
> >> Y'all should have one from me on file already.  Back in Feb/Mar 2016 I=
 did
> >> some work on the gmon profiler and documentation for same.
> >=20
> > I can't find it, neither on cygwin-developers nor on cygwin-patches.
> > AFAICS, I missed to ask you for one back in 2016.
>=20
> It was sent through the old process in February 2016.

I didn't expect that, duh.  Thanks for pulling this fact from history.
I patched the CONTRIBUTORS file accordingly.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaOA2fAAoJEPU2Bp2uRE+gYJMQAJMnRb0DmFzXb/ImGdI8NkCi
UupGUQQSipAlTl2whafqmKXvYnTwHtm2YIhG++ZnkMRw3Oqc+fFo+W07XAwb/NWz
IyFE4Hw3dAZC/svjnegtp5bDl0mFOR2KUVUKRhge0yWtkOu0jjlLqIzJZ63s0LuR
wYyofZBFIXY6SH2nzFXCMyyRNfvrBd0vuY7KWKMAIC5RvRdBr6Q1njsjTuSDrwpQ
rLHlmEIYqSuhSL3p4e3cxeH2oKGaNuTzx3WiOTgCM9KvG4s0Zpe7Y1aZhP9BB6Eq
nA4jYKp005Kb8rgY8/uhmhZ4HRQE8VLG7AAqUSSSF7/Zkv5LSNYZLtqbXZCZO0hQ
ltgCwmEipQYAQ8r90oBucZiC92OdVhLXrcFOO+dAI2q2jJQERVcXvjf+f01Y7Yke
U1VHSucKIx62ts50iVOQ8sj9LjFZbgBROBRYcRSrtG5qzcm8F9HsvoANVe8rdzsW
Cw35xAxgKxqq/FFhJX+ME2b35bXIdMACSwYNqgnQj324KV+PSrVe7vQtJotI7DLZ
3TangB+CxI90mMHIKq464UCin8lMfoXo/tLB6CLHf+uPzcWG6L75F6O19/QAN3Et
V5pITntinI8V9p+aqLDzVD7yw77zuNcTUdW+wZCh5NxoRvrl7+DU/5wNECmwmkWQ
2g/9N1TxessfBq8fRy4f
=jaKR
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
