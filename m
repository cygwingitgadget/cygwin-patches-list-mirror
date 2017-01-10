Return-Path: <cygwin-patches-return-8670-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119421 invoked by alias); 10 Jan 2017 10:47:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119378 invoked by uid 89); 10 Jan 2017 10:47:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=inappropriate, meg, traced, vista
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Jan 2017 10:47:47 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 87A62721E280D;	Tue, 10 Jan 2017 11:47:43 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id F31715E00CD;	Tue, 10 Jan 2017 11:47:41 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D611CA804C1; Tue, 10 Jan 2017 11:47:41 +0100 (CET)
Date: Tue, 10 Jan 2017 10:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com, Daniel Havey <dhavey@gmail.com>
Subject: Re: Limited Internet speeds caused by inappropriate socket buffering in function fdsock (winsup/net.cc)
Message-ID: <20170110104741.GA316@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Daniel Havey <dhavey@gmail.com>
References: <CAO1c0ATh9aD-zbHcpna76EXr-Lavrbk5rnnnJC+bAtehe2xXHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <CAO1c0ATh9aD-zbHcpna76EXr-Lavrbk5rnnnJC+bAtehe2xXHQ@mail.gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00011.txt.bz2


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3273

Hi Daniel,

On Jan  9 15:49, Daniel Havey wrote:
> At Windows we love what you are doing with Cygwin.  However, we have

Windows?

> been getting reports from our hardware vendors that iperf is slow on
> Windows.  Iperf is of course compiled against the cygwin1.dll and we
> believe we have traced the problem down to the function fdsock in
> net.cc.  SO_RCVBUF and SO_SNDBUF are being manually set.  The comments
> indicate that the idea was to increase the buffer size, but, this code
> must have been written long ago because Windows has used autotuning
> for a very long time now.  Please do not manually set SO_RCVBUF or
> SO_SNDBUF as this will limit your internet speed.

Yes, the code has quite a history.

> I am providing a patch, an STC and my cygcheck -svr output.  Hope we
> can fix this.  Please let me know if I can help further.

Yes, perhaps.  Your patch disables setting SO_SNDBUF/SO_RCVBUF, but it
keeps the values for wmem/rmem intact.

rmem is basically unused, but wmem is used in fhandler_socket::send_internal
to account for KB 823764 and another weird behaviour we observed long ago:

If an application sends data in chunks > SO_SNDBUF, the OS doesn't just
fill up the send buffer, but instead it will allocate a temporary buffer
big enough to copy over the application buffer.  So if the application
sends data inb 2 Meg chunks, every send will allocate another 2 Megs and
copy the data, which wastes time and space.

As far as I remember, this is still a problem in Vista and later.  Can
you confirm or deny this by any chance?

And, do we have something like an ideal splitting point?  Given that
SO_SNDBUF/SO_RCVBUF isn't set anymore, we could set wmem to some
arbitrary, yet useful value on both targets, 32 and 64 bit.  I think,
keeping wmem < 64K on 32 bit should be better,

> If you want to duplicate the STC you will have to find an iperf server
> (I found an extreme case) that has a large enough RTT distance from
> you and try a few times.  I get varying results depending on Internet
> traffic but without the patch never exceed the limit caused by the
> buffering.

I can confirm the observation.  I have an iperf server with an avg
RTT of 155ms, and without your patch I hit the upper ceiling at
10.4 Mbit/s, while with your patch I get up to 23 Mbit/s.

> Here is the patch:

As for your patch, a few minor points:

- Can you please send a BSD sign-off per https://cygwin.com/contrib.html?
  For the text see
  https://cygwin.com/git/?p=3Dnewlib-cygwin.git;a=3Dblob;f=3Dwinsup/CONTRIB=
UTORS

- Please keep the line length <=3D 80 chars and remove unnecessary changes
  (e. g. adding empty lines).

- The now unused code should be put into `#if 0' bracketing, rather than
  in a comment. Move the `int size;' declaration down so it will be inside
  the same `#if 0' bracket.

- The preceeding comment shows that the code has a lot of history.  I
  think it would be prudent to add your comment as NOTE 4 into the same
  comment, so the history is in one place.

- Not a requirement, but it would be nice to get the patch in the
  typical `git format-patch' fashion.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdLvNAAoJEPU2Bp2uRE+gHlwQAJdr+bDtAm74ms2KxNPHFVqP
TH0mz8YY1g+wmwhTnkZxqjhkJmWnI55tzWp5lu8kwF8mwOnlQsESEWMPoisLcxFT
KSQpMwCLY60O1HEJcAFfqY0hs+3TlYNQWwvZkxwEHQG5H6VgfDvrGxNg4aTQ04Cj
kpHtU72SU2A89ND4ylSaXL/GrzWxVWzGKQvs/MCg6T2Pr7ZgN35gcW+adB0hkJJZ
FlJMdlajzIkwkMaeyRLtAt2F3wuHE70UY9E8EXXGjyMuzoa1Ko0KVw/cVCGnpAh8
W7s0qpYbLlczs9LIJ0rkmCPIDhnmCc+UpyGMTWJ3t/Rvx303E+EvpTEep08/bUm2
4jQ2AR8aMY+RTYUgE6PoeL35RQn6JlSmC8O6q8HosWUyD9mgT7PKyuO2eOmcn19W
5hrYcMBIf1/bhewihL744YdM6uvoT6vYOGscpPrQyW4lgaGn8N40wxSWCTYBBLv3
o3JefnWUSpBAk5godkufw7CVFy+Aus9IW2VDtWSnRtzVMoNmF2Mt22pEeI4BePyN
bWlzfFckneLW5KQuzvSdWaBR+BHgRwtuu+FTmCtbrDVU1hlbfdMgAzA0q8n9lQMy
64fkxh0ot/HkgiSBFW368l+gcNvnbrRYdetXV6EC5Kp2ByjpEc06FH0KiDpLWPNY
z5sKjDJYJNg9VVOpKCBW
=cbKw
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
