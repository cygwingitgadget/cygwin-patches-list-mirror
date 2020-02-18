Return-Path: <cygwin-patches-return-10087-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20492 invoked by alias); 18 Feb 2020 12:01:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 20483 invoked by uid 89); 18 Feb 2020 12:01:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 18 Feb 2020 12:01:52 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MLQl3-1ilWz02ba7-00IYg7 for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2020 13:01:49 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DC4E2A80734; Tue, 18 Feb 2020 13:01:48 +0100 (CET)
Date: Tue, 18 Feb 2020 12:01:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: Add guard for set/unset xterm compatible mode.
Message-ID: <20200218120148.GJ4092@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200218091254.415-1-takashi.yano@nifty.ne.jp> <20200218104336.GI4092@calimero.vinschen.de> <20200218203446.d70de4ddc487d246f74c9aed@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="MFZs98Tklfu0WsCO"
Content-Disposition: inline
In-Reply-To: <20200218203446.d70de4ddc487d246f74c9aed@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00193.txt


--MFZs98Tklfu0WsCO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2376

On Feb 18 20:34, Takashi Yano wrote:
> On Tue, 18 Feb 2020 11:43:36 +0100
> Corinna Vinschen wrote:
> > On Feb 18 18:12, Takashi Yano wrote:
> > > - Setting / unsetting xterm compatible mode may cause race issue
> > >   between multiple processes. This patch adds guard for that.
> > > ---
> > >  winsup/cygwin/fhandler.h          |   6 ++
> > >  winsup/cygwin/fhandler_console.cc | 125 +++++++++++++++++++++-------=
--
> > >  winsup/cygwin/select.cc           |  22 ++----
> > >  winsup/cygwin/spawn.cc            |   8 +-
> > >  4 files changed, 103 insertions(+), 58 deletions(-)
> >=20
> > The patch looks good to me, but I'm curious...
> >=20
> > Yesterday you wrote that interlocked counting is not a good
> > solution due to the 'bash -> cmd -> bash' scenario.  What has
> > changed your mind?
>=20
> Interlocking in this patch is not used in open/close, but
> in read()/select() for input, and in write()/close()/exec()
> for output. For input, InterlockedIncrement/Decrement() is
> used and InterlockedExchage() is used for output.
>=20
> As for bash->cmd->bash case, first xterm mode is enabled
> for output and input in write() and read() in bash, then
> xterm mode for input is disabled when it returns from read().
> When cmd.exe is executed, xterm mode for output is disabled
> in exec(). As a result, cmd.exe is executed under xterm mode
> disabled. Next, when bash is executed, xterm mode is re-
> enabled in write()/read().
>=20
> After that, if second bash is exited, xterm mode for input
> is disabled when returned from read(), and for output, it
> is disabled in close(). Then, cmd.exe is executed under
> xterm mode is disabled. If cmd.exe is exited, xterm mode
> is re-enabled in write()/read() in bash.
>=20
> After all, xterm mode for input is enabled/disabled each
> read() and select() call. xterm mode for output is enabled
> when write() is called and disabled in close() and exec()
> for non-cygwin process.
>=20
> On Mon, 17 Feb 2020 10:00:15 +0100
> Corinna Vinschen wrote:
> > In terms of this patch, rather than to change the mode on every
> > invocation of read/write/select/close, wouldn't it make more sense to
> > count the number of mode switches in a shared per-console variable, i.e.
>=20
> In other words, it is not as suggested above.

Thanks for the explanation.  Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--MFZs98Tklfu0WsCO
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5L0iwACgkQ9TYGna5E
T6AUaQ/7B999uPRaIWtBxcan09n8F0pNq66p5BLw/jYLi5+ahKbvpthUvHlUV6zr
IZAQJMrK0XnmHUOG/K1018W76ArBfftB28X3qUx88ac7jD8ks9s03TCBM+LyeczK
RBQsWrOtEa9PWCs923S0vTF6kqQA5p//wieIyo0PFEIyaXT6tOBAx1LOxmY0ZF3A
NOn5zsXPPLg14w54QEBYAdmhm+m494JRnwc9Wlh1pTsDk7u0dlgy0B9hlfVyJv+m
Z04drP5tnWCL5xxRZ/FWna7PrViIxKEZQx996iLu6Twdr47t6JICERxCkhoVjJnk
0Ihts8FESKc1UGxMTAataxpCSUcEgqtjn2/RHC9p3KSuQ19+ZhsM3C/+C98Es7in
kO1KS5J7rsFYln95nhBGZAnpFT08UCkKYxt28nl6ycrH4Z+ATMirJpftB+mOMr1M
vLApjhnfA7kKrrmiOdvlYELuMWCMkixttoya0ishDvOS2Dw9jsj4aS4QdOyWshnu
tMyJ2qWw2/xk+C/wEE5xZ9LIFELbxCTfIJYt8A31H2dhTux0uqoL0w7Frixp0lXr
ntupzKDrdmjtozeKzqDOymiSZzZgcGFii/qMguTVaKyC0MisaPOR7TIbNhOJ0/mX
kCHOJbHNBCtrj4PvaVeLOTw87lS7zEUWjFGgIX91DLwvz1FvGnA=
=bEBr
-----END PGP SIGNATURE-----

--MFZs98Tklfu0WsCO--
