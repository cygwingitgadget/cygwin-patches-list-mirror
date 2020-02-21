Return-Path: <cygwin-patches-return-10100-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 116340 invoked by alias); 21 Feb 2020 11:05:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 116329 invoked by uid 89); 21 Feb 2020 11:04:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*r:mreue012, H*f:sk:03af37e, H*i:sk:03af37e, H*MI:sk:03af37e
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 21 Feb 2020 11:04:58 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MSZDt-1itqdK0G8v-00SwgW for <cygwin-patches@cygwin.com>; Fri, 21 Feb 2020 12:04:55 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8EAE6A80712; Fri, 21 Feb 2020 12:04:54 +0100 (CET)
Date: Fri, 21 Feb 2020 11:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Ignore 0x00 on write().
Message-ID: <20200221110454.GY4092@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200220133531.GR4092@calimero.vinschen.de> <20200220134459.GS4092@calimero.vinschen.de> <20200220231312.8d7f478d578970fca29098bf@nifty.ne.jp> <20200220142245.GU4092@calimero.vinschen.de> <20200220234943.2d3bf6ca40d95166a5960051@nifty.ne.jp> <20200220160401.GV4092@calimero.vinschen.de> <db2b11d3-8499-55be-5384-8d6c623138f0@towo.net> <20200220163804.GW4092@calimero.vinschen.de> <20200221093253.GX4092@calimero.vinschen.de> <03af37e2-d04b-419e-06dc-f13fda58bedc@towo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="yLfVvEQOBD/VeTNx"
Content-Disposition: inline
In-Reply-To: <03af37e2-d04b-419e-06dc-f13fda58bedc@towo.net>
X-SW-Source: 2020-q1/txt/msg00206.txt


--yLfVvEQOBD/VeTNx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2611

On Feb 21 10:43, Thomas Wolff wrote:
> On 21.02.2020 10:32, Corinna Vinschen wrote:
> > On Feb 20 17:38, Corinna Vinschen wrote:
> > > On Feb 20 17:22, Thomas Wolff wrote:
> > > > On 20.02.2020 17:04, Corinna Vinschen wrote:
> > > > > On Feb 20 23:49, Takashi Yano wrote:
> > > > > > On Thu, 20 Feb 2020 15:22:45 +0100
> > > > > > Corinna Vinschen wrote:
> > > > > > > On Feb 20 23:13, Takashi Yano wrote:
> > > > > > > > On Thu, 20 Feb 2020 14:44:59 +0100
> > > > > > > > Corinna Vinschen wrote:
> > > > > > > > > But, here's a question: Why do we move the cursor to the =
right at all?
> > > > > > > > > I assume this is compatible with legacy mode, right?
> > > > > > > > Hmm. This may be a bug of legacy console.
> > > > > > > > https://en.wikipedia.org/wiki/Null_character
> > > > > > > > says
> > > > > > > > (some terminals, however, incorrectly display it as space)
> > > > > > > >=20
> > > > > > > > What about ignoring NUL in legacy mode too?
> > > > > > > I'd like that, but this may be a problem in terms of backward
> > > > > > > compatibility.  The behaviour is so old, it actually precedes=
 even the
> > > > > > > import of Cygwin code into the original CVS repository, 20 ye=
ars ago...
> > > > > > If so, can't we say it is the *specification* of TERM=3Dcygwin
> > > > > > that NUL moves the cursor right?
> > > > > Good point.  Yes, in that case it's "working as designed" and
> > > > > we just leave it as is.  I push my patch.
> > > > See `man 5 terminfo`: if NUL does anything else than just padding, =
the
> > > > terminfo entry must contain a pad or npc entry, which it doesn't.
> > > > Trouble to be expected. I'd rather suggest to align the design with
> > > > applications' expectations.
> > > Is that the cygwin terminfo or the xterm terminfo you're talking abou=
t?
> > >=20
> > > In case of the cygwin terminfo, that would mean the cygwin terminal
> > > emulation behaves differently from the terminfo for ages.  I guess
> > > you're right then, we should fix this in the cygwin terminal emulation
> > > to make sure it behaves as descibed in its terminfo.
> > >=20
> > > In case of the xterm terminfo, that would be no problem because my pa=
tch
> > > drops the cursor movement for NUL.
> > Yeah, never mind, I checked the cygwin terminfo entry myself.
> >=20
> > I pushed a patch removing the cursor movement on NUL and added
> > a matching comment instead.
> Great, thanks! And sorry I'm sometimes a bit slow to respond...

No worries, same here.  Thanks for the terminfo hint.
I created a new developer snapshot for testing.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--yLfVvEQOBD/VeTNx
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5PuVYACgkQ9TYGna5E
T6BR0Q/9GFjYI2Zcx6aYGWHGG626LIZipoEcC8Nqltky0IRWtLDx4qJDos84ieb1
+ayVdsHglRFKUryl5Bk9+jgEViCtll/BogYkTjm3hbJjMMlj4hxURVZ6IvxmPtb9
V6+bLGPVdFwZ2xVdLdQlGIZb4y5rmJVkAWGGp322IkGdUHEzI/GXxfgmRO7BZZG/
EzMstKLtd/hoTqDXLjrdqHpczi4zjlpgX5Exj/mw3vhInTrAhCjdJeolT04cDr/F
ijCT/oagzzF9JHgy7Lg/0mQ+SdPILx5PtDpCEKZyXfkam/QVXkYqE6BLtxNd6VOl
UKsZPNBWhGeol4AwOUksx7/2xpC3VHFL5AIVdpqzxyU9+nXLh7iYicw3xOlpkGg/
cfjZ2aKt6HUP3PiFizGjjaJY3XS3s/RTrpTXYb4XxKGPVQ0ULUHTpF4YvdOcJbS0
HUBskFd6VFB3M5qf9caY/lLsqPxeSWvROEvjl/kNhhyQbGUdxlIDM/61nhtZO68s
DU5tKZ7cvpiWdl4sAUGH/yHSfsWKHQZhb2AkBcQy25luXDkeZKAf+06Qf8Y2L5lH
3nysfbqQwvqxHTlWQ27+h014mYw9TZbbssl5kdGhBBwPiZGpKdw9HjagavuWyN/o
evNiPCdhg+5G9Cs2tW2/VBbHuXzkEXveLZHmPAS4fn+eeZ7kOjk=
=9O+g
-----END PGP SIGNATURE-----

--yLfVvEQOBD/VeTNx--
