Return-Path: <cygwin-patches-return-9593-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17427 invoked by alias); 3 Sep 2019 09:16:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17418 invoked by uid 89); 3 Sep 2019 09:16:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-103.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=category
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 03 Sep 2019 09:16:41 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MGQf5-1hxcfD33cL-00GpYa for <cygwin-patches@cygwin.com>; Tue, 03 Sep 2019 11:16:38 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 216A2A8064B; Tue,  3 Sep 2019 11:16:38 +0200 (CEST)
Date: Tue, 03 Sep 2019 09:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 1/1] Cygwin: pty: Fix state management for pseudo console support.
Message-ID: <20190903091638.GH4164@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190901221156.1367-1-takashi.yano@nifty.ne.jp> <20190901221156.1367-2-takashi.yano@nifty.ne.jp> <20190902143716.GF4164@calimero.vinschen.de> <20190903120530.f7b31bfa6feb2118762891a2@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
In-Reply-To: <20190903120530.f7b31bfa6feb2118762891a2@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q3/txt/msg00113.txt.bz2


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 4282

Hi Takashi,

On Sep  3 12:05, Takashi Yano wrote:
> > > -      Sleep (60); /* Wait for pty_master_fwd_thread() */
> > > +      Sleep (20); /* Wait for pty_master_fwd_thread() */
> >=20
> > Isn't that a separate issue as well?  A separate patch may be in order
> > here, kind of like "Cygwin: pseudo console: reduce time sleeping ..."
> > with a short description why that makes sense?
>=20
> Actually it is not. The wait time became able to be reduced by
> redesigning switching of r/w pipes which managed via variable
> switch_to_pcon. So I think this should be included in this patch.=20

Ok.

> > However, I have a few questions in terms of the code in general, namely
> > in terms of
> >=20
> >   ALWAYS_USE_PCON
> >   USE_API_HOOK
> >   USE_OWN_NLS_FUNC
> >=20
> > Can you describe again why you introduced these macros?
>=20
> These are defined for debugging purpose.
>=20
> If ALWAYS_USE_PCON is defined to true, pseudo console pipe is used for
> all process including pure cygwin process. Usually, this should be false
> so that the cygwin process use named pipe as previous.
>=20
> USE_API_HOOK is for enabling/disabling the API hook to detect direct
> console access in cygwin process. This should be true so that the
> r/w pipe switching is set to pseudo console side for the cygwin
> process which directly access console.
>=20
> As for USE_OWN_NLS_FUNC, I have not decided yet which codes should be
> used. If USE_OWN_NLS_FUNC is false, setlocale (LC_CTYPE, "") is
> called therefore it may affect to some programs wihch do not call
> setlocale().
>=20
> > In terms of USE_API_HOOK:
> >=20
> > - Shouldn't the hook_api function be moved to hookapi.cc?
>=20
> I will move it into hookapi.cc, and post it as a separate patch.
>=20
> > - Do we really want to hook every invocation of WriteFile/ReadFile?
> >   Doesn't that potentially slow down an exec'ed process a lot?
> >   We're still not using the NT functions throughout outside of the
> >   console/tty code.
>=20
> I measured the time for calling WriteFile() 1000000 times writing
> 1 byte to a disk file for each call.

Files are not affected in Cygwin, fortunately.  They use
NtReadFile/NtWriteFile, not ReadFile/WriteFile.  However, other
stuff is still affected...

> Not hooked:
> Total: 4.558321 seconsd
>=20
> Hooked:
> Total: 6.522692 seconsd
>=20
> Hooking causes slow down indeed. It seems that GetConsoleMode()
> is slow. So I have added the check for GetFileType() before
> GetConsoleMode() and made check in two stages.
>=20
> Hooked (new):
> Total: 5.217996 seconsd
>=20
> This results in speed up a little. I will post another patch for this.

This is a slowdown of about 15%.  That's quite a lot.  Can't you just
check the incoming handle against the interesting handles somehow?
If there's no other way around it, we should at least make sure (in a
separate patch) that Cygwin calls NtReadFile/NtWriteFile throughout,
except in tty and console code.

> > In terms of USE_OWN_NLS_FUNC:
> >=20
> > - Why do we need this function at all?  Can't this be handled by
> >   __loadlocale instead?  If not, what is __loadlocale missing to make
> >   this work without duplicating the function?
>=20
> Calling __loadlocale() here causes execution error.
>=20
> mintty:
>       0 [main] tcsh 1901 sig_send: error sending signal 6, pid 1901, pipe=
 handle 0x0, nb 0, packsize 164, Win32 error 6
>=20
> script:
> Script started, file is typescript
> script: failed to execute /bin/tcsh: Bad address
> Script done, file is typescript
>=20
> I could not find out the reason. Some kind of initialization which
> is needed by __loadlocale() may not be done yet. So I copied
> only necessary part from __loadlocale() and nl_langinfo().
>=20
> Simply,
>  path_conv a ("/usr/share/locale/locale.alias");
> also causes errors on starting mintty.
>=20
> Ideally, the cause of the error should be found out, I suppose.

Indeed.  We can keep the code in for now, but the end result should
call a tweaked version of __loadlocale instead.  As long as the=20
tweak only requires a single extra argument, or if the category or
new_locale argument can be used as indicator to trigger the required
special behavour, we should have no problem to get that into newlib.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1uL3UACgkQ9TYGna5E
T6A1kg/9FI/r01KoHqdJfR2AVqgAcMk9BT2tYPt1hhMe7gpWyH+HOSfjWKpEXRrP
llsTLOJf3sSBaTEQAxbGjTu3luIUihzFA9BDPauYQWgHqjqHhfzk7HIb8DrzGNud
QY4w6mMtQ28MA2qnIIPHGQ5x988702Nr6dEya1qtmFl8ZVj3ZKhK7PqdLLM77p/Q
xoEy5yXEXiggPUCNqRuy4JneGHKgAq/GX6ffAyvN7C8goyKhxfkywCHlww+F4iwU
8MPfiPExLUWJBlerrbMhdLqaFOFvNVBbcFgxLSF11s234agaWYp1LD02zO9dItps
1020CWPuWMaVuIPv7abUW/+R+dUMK7jgkSjdLS7l8D/njTpVnlNgpqvxtJJSMFbp
7e53r/JEo4GPgI0icoliwEi3o/zyL+3A1vqC4MI9z5sSnMIiyDnPsUtKcOzEhHyV
8n18wVkKMiUlpRwu/aAjY871fF9+fdaq3wBDhre2faERo5e81gUYayaucKVr6f/h
+vgYUMTOzIhVBHqwOsyu5d25pD0+SjMJUV7lSmwLdcXNDUnB4A2SMLHMnn1kAowC
nJabI1elTeMgFz4XTVf3V7mDhG5qHn1nAtTWC7eEB+tqnN62UD4ofRX6014p+2o2
o+YQdC72wZodU1IuzCljZP46zbdjzGM5EbrzAlyMhfeAS8n3LXI=
=PJw/
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--
