Return-Path: <cygwin-patches-return-9616-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 532 invoked by alias); 4 Sep 2019 13:34:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 520 invoked by uid 89); 4 Sep 2019 13:34:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-115.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_SBL autolearn=ham version=3.3.1 spammy=
X-HELO: mout-xforward.kundenserver.de
Received: from mout-xforward.kundenserver.de (HELO mout-xforward.kundenserver.de) (82.165.159.5) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 13:34:57 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MqatE-1ia7DC1PcW-00maC7 for <cygwin-patches@cygwin.com>; Wed, 04 Sep 2019 15:34:54 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DCCA1A80659; Wed,  4 Sep 2019 15:34:53 +0200 (CEST)
Date: Wed, 04 Sep 2019 13:34:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: pty: Add a workaround for ^C handling.
Message-ID: <20190904133453.GR4164@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190904014618.1372-1-takashi.yano@nifty.ne.jp> <20190904014618.1372-2-takashi.yano@nifty.ne.jp> <20190904104222.GO4164@calimero.vinschen.de> <20190904223054.e3debe5ca201ee5bb94f1203@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="xXygN3QAmJYWdGtb"
Content-Disposition: inline
In-Reply-To: <20190904223054.e3debe5ca201ee5bb94f1203@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q3/txt/msg00136.txt.bz2


--xXygN3QAmJYWdGtb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1703

On Sep  4 22:30, Takashi Yano wrote:
> On Wed, 4 Sep 2019 12:42:22 +0200
> Corinna Vinschen wrote:
> > If this workaround works, what about making it the standard behaviour,
> > rather than pseudo-console only?  Would there be a downside?
>=20
> I am not sure why, but console does not have this issue.
> However, I do not notice any downside.
>=20
> If making it standard, the patch will be very simple as follows.
>=20
>=20
> diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
> index a3a7e7505..0a929dffd 100644
> --- a/winsup/cygwin/fork.cc
> +++ b/winsup/cygwin/fork.cc
> @@ -213,7 +213,6 @@ frok::child (volatile char * volatile here)
>       - terminate the current fork call even if the child is initialized.=
 */
>    sync_with_parent ("performed fork fixups and dynamic dll loading", tru=
e);
>=20
> -  init_console_handler (myself->ctty > 0);
>    ForceCloseHandle1 (fork_info->forker_finished, forker_finished);
>=20
>    pthread::atforkchild ();
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 4bb28c47b..15cba3610 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -635,6 +635,12 @@ child_info_spawn::worker (const char *prog_arg, cons=
t char *const *argv,
>        if (ptys)
>         ptys->fixup_after_attach (!iscygwin ());
>=20
> +      if (!iscygwin ())
> +       {
> +         init_console_handler (myself->ctty > 0);
> +         myself->ctty =3D 0;
> +       }
> +
>      loop:
>        /* When ruid !=3D euid we create the new process under the current=
 original
>          account and impersonate in child, this way maintaining the diffe=
rent

Sounds good to me.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--xXygN3QAmJYWdGtb
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1vvX0ACgkQ9TYGna5E
T6BOMRAAgPxKYbqTYNBvGFimPovg36WGYRHtRQFtuyE1BnLjmqTaBlXvU1wA9RtM
hfpwybDGh1FUp85lvHXsLzxTFtd/pHeaiN/u8wiuQAOEROT2lOF/oEwmiSr23BRG
wrfTFj+ozL6T+pF13n0s/5m+xcQPsWblQDD24oTzrtG/cdRiinncvaIWKUfQnwy5
1tYrYDgsRCvEKWuJZFyLMS3lIrUPlglpNxK19GvoUFFYg0f6ujY0ypQ+FVPf9ouA
3a+Num329S6dbY2SAwvOe3eJDnCz4tvxJMbaf1mOz+EKvDlWyREpd9jRwz39efIV
XFbbJH1K+gTWaXezgzUev407waIA2a9GVyEmrM4ACTF04AbEe5FwX33XHgladCKi
UCmiv1NRffHbPSPGObOAfgTjADFTyPyRDWLkn0DhxfuuYyWSGG+AFRxQ67Ct54xF
HJE3bI7gNGPUIhVhdmyIhrgGNIBPCNuAH7dynKUoQZxy1voW7nijgpwQuRkUBmFm
D9cykoRXoPWKkGLX41H1Gc4s/vTx0xpBewA/t9PXz7OOfh8XnJaXDx4eoNZBuu0B
p0GAAu1DuLW+hb+t/+9rAcjprsyHMULWpABBjK+8k0+3WDEzyKwIItt7H5ibr9xj
ptufT9O5HNbusdKxiHpvHORaXBcrxbI6cju9xuEDiWnv8m1by68=
=JT1f
-----END PGP SIGNATURE-----

--xXygN3QAmJYWdGtb--
