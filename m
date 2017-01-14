Return-Path: <cygwin-patches-return-8686-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126987 invoked by alias); 14 Jan 2017 15:17:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 126976 invoked by uid 89); 14 Jan 2017 15:17:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=ate, layers, poster, bdp
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 14 Jan 2017 15:17:26 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 0A320721E2825;	Sat, 14 Jan 2017 16:17:22 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 5AFC55E021D;	Sat, 14 Jan 2017 16:17:21 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3E2D6A804D6; Sat, 14 Jan 2017 16:17:21 +0100 (CET)
Date: Sat, 14 Jan 2017 15:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Daniel Havey <dhavey@gmail.com>
Subject: Re: Limited Internet speeds caused by inappropriate socket buffering in function fdsock (winsup/net.cc)
Message-ID: <20170114151721.GA919@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Daniel Havey <dhavey@gmail.com>
References: <CAO1c0ATh9aD-zbHcpna76EXr-Lavrbk5rnnnJC+bAtehe2xXHQ@mail.gmail.com> <CAO1c0ARd7smeWLDpqHVyBSvcAZMSAKA4uDc3e2nKHpT73PiWBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <CAO1c0ARd7smeWLDpqHVyBSvcAZMSAKA4uDc3e2nKHpT73PiWBQ@mail.gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00027.txt.bz2


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1503

Hi Daniel,

On Jan 11 16:38, Daniel Havey wrote:
> Hi Corinna,
> I can see your email on the archive, but, I never received it in my
> gmail account (not even in a spam folder).  I think the Internet ate
> your message.

No, I only sent the reply to the list.  It's customary in the Cygwin
mailing lists not to CC the original poster, unless the poster requests
it.  I CCed you now, of course.

> Yes Windows :).  I'm the Program Manager for Windows 10 transports and
> IP.  Anything in layers 4 or 3.

Cool.  I'm glad for any input from "upstream" :)

> We can help you with network stack in
> the current release of Windows 10.  Downlevel is more difficult.  I'm
> not sure about the answer to your question on the size of wmem.  I
> don't think that there is a static value that will work in all cases
> since Windows TCP will send 1 BDP worth of data per RTT.  If the BDP
> is large then the static value could easily be too small and if the
> BDP is small then the static value could easily be too large.  It will
> take some digging to figure out what the best practice is.  I will do
> some digging and let you know the results.

I'm really looking forward to it!

> In the mean time I will apply your recommendations to my patch and repost=
 it.

Same here.   Thanks a lot for fixing another of those pesky "Cygwin is
slow" problems :)))


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYekEBAAoJEPU2Bp2uRE+gG08P+wcqzL3y02eLGhf1lUEtgPqt
JaA9Xn7Lbxtv3OKlAfdgs0StRSIU/crrJiQhfpkss5wAMUsudefOclzOYo4UjIhj
KiJGAcK6tBiRbMPYjRZr1hDeeGdQz37kUGySlAM+scXUGTBbGi0md+Sl//Yyw5e+
FoZ03EwD2O+9FMMBXUnMccWKiVzpM8SNjGlNTFsggj7lWALSY8/4GgYrcGwRvVCR
ALJcfzom+hCwTcKiwuRb2ct5qEub8DrYVDDxMU55XKklXWOYJx7xI0Z1KxnILuQf
boe0imZyxXHFlboL1GB4fVWBpQX6513hoIaW+7SwqiNjiVakiFt0Y+djKWEX38wp
BLwg+ikI2Yhc+0J7XL07URU1/T32fjMu/XreAi9KreAHpFZzzV2XxVWFqCe1aKvI
DIjQpnL4/h0L6jcZpuup/W1ACRlAQh1JLMr9olpIh9/Jcxuwrn+aZkb+yLC5A6Aq
96WJnIhLVH+G9sJpMeEYd3D7y5yG7xgX91s4zPpWeaNmCqJW6zPhPFp2ArY84AOo
Eq1c7IQaw3HfErgJwZ3tBBXrZ+Vrp9FtTvZie4DdClEfNlC/Lv9uwi2WzRVjk3wk
e5i8xGmBh+EQcaR55iAoE5zWHvxeh5mLAYSCKQQVEnRUXvfOsSkUQFDazZNFaHd3
059H7NRRZ/VtW56/2BMZ
=hX8G
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
