Return-Path: <cygwin-patches-return-9769-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98357 invoked by alias); 21 Oct 2019 09:44:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98341 invoked by uid 89); 21 Oct 2019 09:44:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=deeper, sid, H*F:D*cygwin.com, clearing
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Oct 2019 09:44:05 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MLzSD-1idjxv4A53-00HzaY; Mon, 21 Oct 2019 11:43:59 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E5B97A8073B; Mon, 21 Oct 2019 11:43:56 +0200 (CEST)
Date: Mon, 21 Oct 2019 09:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-ID: <20191021094356.GI16240@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <takashi.yano@nifty.ne.jp>,	cygwin-patches@cygwin.com
References: <20191018113721.2486-1-takashi.yano@nifty.ne.jp> <20191018143306.GG16240@calimero.vinschen.de> <20191019085051.4d2cc80811854d21b193fed6@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline
In-Reply-To: <20191019085051.4d2cc80811854d21b193fed6@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00040.txt.bz2


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2904

Hi Takashi,

On Oct 19 08:50, Takashi Yano wrote:
> Hi Corinna,
>=20
> On Fri, 18 Oct 2019 16:33:06 +0200
> Corinna Vinschen wrote:
> > Sorry, but this doesn't look feasible.
> >=20
> > You can't base the behaviour on the name of an application.  What about
> > other applications like telnetd, rshd, just to name the first ones
> > coming to mind?  What about a renamed sshd, or sshd installed into
> > another directory, or just an sshd in the build dir during testing?
> >=20
> > Is this workaround really necessary at all?  Even basing this on the
> > terminal name looks pretty fragile.
>=20
> I agree with you. However, I couldn't come up with better method.
> Now I have come up with another implementation. Could you please
> have a look at v2 patch?
>=20
> As a caution, this patch is for:
> https://www.cygwin.com/ml/cygwin/2019-10/msg00074.html
> therefore, telnetd or rshd is not targeted.
>=20
> > Why exactly is the clear screen necessary?  You wrote something about
> > synchronizing the pseudo console and the pseudo tty content, IIRC, but
> > it still seems artificial to enforce a clear screen.  Is there no
> > other way to make the pseudo console happy?
>=20
> Using cygwin 3.1.0-0.7 (TEST), by the following steps, you can see
> what happens if clear screen is not done.
>=20
> 1) Execute ls or ps to draw something to screen.
> 2) env TERM=3Ddumb script
> 3) Execute cmd.exe.
>=20
> If we can accept this behaviour, clear screen is not necessary.

I just tried it and what I see is that starting cmd.exe clears the
screen.  While starting e.g. reg.exe or sc.exe or w32tm.exe does not
clear the screen.  Starting cmd.exe after reg.exe clears the screen and
positions the output of reg.exe at the top.  Same if I call a Cygwin
tool between reg.exe and cmd.exe.

So it seems cmd.exe is the only (or one of few) native CLI tools
actually trying to manipulate the screen buffer.  And what it does is
not so much clearing the screen, but to align buffer line 1 with the top
of the screen, even if line 1 has been produced before cmd.exe started.

I didn't look deeper into this yet, but the question coming to mind is,
what does GetConsoleScreenBufferInfo return right after starting
`env TERM=3Ddumb script`, how does it look like right after running
`reg.exe' and before `cmd.exe', and how does it look after cmd.exe
changed it?

The (admittedly vague) idea is, maybe cmd.exe can be cheated into
not changing the console buffer by changing it to what it expects
right after creating the pseudo console...

Also, maybe this effect has something to do with the screen buffer
size in relation to the window size?

Other than that, my very personal opinion here is, not clearing the
screen is more desired than the terminal type and application name (or
SID) hacks just to pamper cmd.exe.  Others may disagree, so I'm open to
discussion.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl2tfdwACgkQ9TYGna5E
T6DGjQ/+OxJxjka+FCj7LpDuzWCMjUPYNPuqljJJxW399EmBEcNyEby1QQp1JhIG
Zr9SP3x6yfLvu2mDCMunhFVOFnGtc7/wVTCqqzIeiPjUfNlkeo2ZaamTmWuue4QQ
DWIQwQGr19KjkZlAkQIGWZo19J8johOfM0Z7cqPEqus8CkC+SWHhj0aZmPTevsX7
nZ9KF09F0mt7rsC//gM2Yf5O+OAUC11oh5vX9Gfo5w/IU71kUV+il3IP3VCsGKiS
UrM2j+SaDInvt2n8bCKb/8gmvfTb8LjZr5ZVHKJzX3wkF9wBNnngdOcAQ89bmorj
OzM5Qw75KqHhj5WHPHsOwI+nSUteLJ/uwa0q7DOGa67/YUY3iA4YXYOv7iov1Bax
hlwlNuUJDZ3PWW6x3mCyTRundHDtLCAY/p2UnEyTCL5KXrlUnJJjp+GYJMeXBbN1
LGnNfZfHvF4DZYyPYoH6RxqbVw9w9F9dsjwtwYeKPrStdAv8z/opYxWDpi6cn5/w
imKkhy0+2h0p7vOdejFI8FpJMbP7gyb1tRIYACbQUCPWLj/0o5kKrpA4HDORQZty
nmxtGDCk3PmjPnJKFO6baON4leiFjwWhEVs4ukOn4RR5imY7EkHH7FTAf+OjfvAF
1mxxMZQ3wTnQfNb5cM+7rfmbMuPVGHhvZz1ZWNRQCkMsdEYPcn4=
=n1RF
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--
