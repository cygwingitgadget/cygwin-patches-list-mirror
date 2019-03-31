Return-Path: <cygwin-patches-return-9292-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 82198 invoked by alias); 31 Mar 2019 17:45:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81632 invoked by uid 89); 31 Mar 2019 17:45:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.0 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 31 Mar 2019 17:45:23 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N5FtF-1glNvK1Jdl-011DqY; Sun, 31 Mar 2019 19:45:07 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 18C86A8059A; Sun, 31 Mar 2019 19:45:05 +0200 (CEST)
Date: Sun, 31 Mar 2019 17:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 0/3] Reworks for console code
Message-ID: <20190331174505.GH3337@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <takashi.yano@nifty.ne.jp>,	cygwin-patches@cygwin.com
References: <20190331143651.GF3337@calimero.vinschen.de> <20190331154748.1957-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="9/eUdp+dLtKXvemk"
Content-Disposition: inline
In-Reply-To: <20190331154748.1957-1-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00102.txt.bz2


--9/eUdp+dLtKXvemk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1705

On Apr  1 00:47, Takashi Yano wrote:
> Hi Corinna,
>=20
> On Sun, 31 Mar 2019 16:36:51 +0200 Corinna Vinschen rote:
> > This hunk is ok, but I wonder if the time hasn't come to simplify the
> > original code.  The `static char NO_COPY' only makes marginal sense
> > since it's strdup'ed anyway.
> >=20
> > What if we just define two const char's like this
> >=20
> >   const char cygterm[] =3D "TERM=3Dcygwin";
> >   const char xterm[] =3D "TERM=3Dxterm-256color";
> >=20
> > and then just strdup them conditionally:
> >=20
> >   if (!sawTERM)
> >     envp[i++] =3D strdup (wincap.has_con_24bit_colors () ? xterm :
> > cygterm);
> >=20
> > What do you think?
>=20
> > Sorry, didn't notice this before:  Please prepend this block with
> > a comment along the lines of "/* Not yet defined in Mingw-w64 */"
>=20
> Adopted.
>=20
> > Doesn't this belong into the select patch?
>=20
> Actually, no. This makes select() recognize Ctrl-space, but
> is just tentative. Patch 0002 overwrites this fix.
>=20
> This is corresponding to:
> > @@ -435,7 +451,8 @@ fhandler_console::read (void *pv, size_t& buflen)
> >  	      toadd =3D tmp;
> >  	    }
> >  	  /* Allow Ctrl-Space to emit ^@ */
> > -	  else if (input_rec.Event.KeyEvent.wVirtualKeyCode =3D=3D VK_SPACE
> > +	  else if (input_rec.Event.KeyEvent.wVirtualKeyCode
> > +		   =3D=3D (wincap.has_con_24bit_colors () ? '2' : VK_SPACE)
> >  		   && (ctrl_key_state & CTRL_PRESSED)
> >  		   && !(ctrl_key_state & ALT_PRESSED))
> >  	    toadd =3D "";

Ah, right, that makes sense.

Pushed.  I added release info accordingly.  I'm also just building new
developer snapshots with this patchset included.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--9/eUdp+dLtKXvemk
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyg/KAACgkQ9TYGna5E
T6CNeg/9FfTIbOldeV0v9QCat8+ynNEhDQewI7HZvBm1U+Yv7nOUSuSS4IPYiJhU
oN9A9bzSg14LiZr7H6ibBbN82yY5WxEl5nD8kn7kt6sYXRs9mlAmNiJmGY9R2PVQ
xUYCu0D9LOW80smjoTwjz92+2hPEGtyoQCZHS/h+RabfUMDtWN9c/nwmv/hlZL0Q
WEvRbt7Mug8U9GonL8SjyjsgoYR5b/xTY/FwrnxBTCVmYT8ER7JG59xwEUpe39Xy
RBzji+rGY/ovZrT5EKpeZmcTucgKrPCQ1srLHKHYgk+yiqU75NF7G7mVRGDd1L3r
SV2eKlFExQPtZdJFmq+q7dcadv3kkOF4bWh0c/6nX2h702jmEGTc5XX/HOEhz7XB
6YMJ4DVfRm4PVe/0IvWiwBLDqsfo/1oK2FcHZ6ph1OA8WHY0ZgUCt/a66OYxT5tM
LvEBs7KwwguCDwlKCH0MDF3c4i2PHPi0vznZoXVZvzvFaI1TtMoIg0HjGr3vh18p
+PRzlHkWNw8RzFfVlNgmWrZq8hSGWPn0QNOETjnIGLBPMdxj5ANXfeWG9MGHdGoy
WzI+yt9zTynJ468qnXXMDBSMi8/Owv+tEOKB7LnHcYcR7v6x4K+Wm4qTSxJPu4mt
xpuhrZi43v1fZInMYu/8iy9LdikQBN5Kfgp8zm3vca9Y+uYrgb0=
=G7D4
-----END PGP SIGNATURE-----

--9/eUdp+dLtKXvemk--
