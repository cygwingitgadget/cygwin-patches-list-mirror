Return-Path: <cygwin-patches-return-9935-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 114391 invoked by alias); 14 Jan 2020 16:24:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 114376 invoked by uid 89); 14 Jan 2020 16:24:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=know, H*i:sk:4e2f713, H*MI:sk:4e2f713, H*f:sk:4e2f713
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 14 Jan 2020 16:23:51 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MybbH-1ja1wf1iDF-00yyu7 for <cygwin-patches@cygwin.com>; Tue, 14 Jan 2020 17:23:48 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 74BF3A80668; Tue, 14 Jan 2020 17:23:47 +0100 (CET)
Date: Tue, 14 Jan 2020 16:24:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: select: Speed up select() call for pty, pipe and fifo.
Message-ID: <20200114162347.GX5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200106143834.1994-1-takashi.yano@nifty.ne.jp> <20200113163316.GQ5858@calimero.vinschen.de> <4e2f7132-0e2b-a87f-a73e-a427abbdc7e9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Vhqu5qQ3bjg0ZI9i"
Content-Disposition: inline
In-Reply-To: <4e2f7132-0e2b-a87f-a73e-a427abbdc7e9@gmail.com>
X-SW-Source: 2020-q1/txt/msg00041.txt


--Vhqu5qQ3bjg0ZI9i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1273

On Jan 13 22:17, Marco Atzeri wrote:
> Am 13.01.2020 um 17:33 schrieb Corinna Vinschen:
> > On Jan  6 23:38, Takashi Yano wrote:
> > > - The slowing down issue of X11 forwarding using ssh -Y, reported
> > >    in https://www.cygwin.com/ml/cygwin/2019-12/msg00295.html,
> > >    is due to the change of select() code for pty in the commit
> > >    915fcd0ae8d83546ce135131cd25bf6795d97966. cygthread::detach()
> > >    takes at most about 10msec because Sleep() is used in the thread.
> > >    For this issue, this patch uses cygwait() instead of Sleep() and
> > >    introduces an event to abort the wait. For not only pty, but pipe
> > >    and fifo also have the same problem potentially, so this patch
> > >    applies same strategy to them as well.
> >=20
> > Pushed.  And thanks for testing, Marco!
> >=20
> >=20
> > Thanks,
> > Corinna
> >=20
>=20
> you are welcome.
>=20
> I found the improvement better than anything I ever seen
> on octave plotting with QT interface.
> Redrawing of the images when moving windows is now very responsive,
> in the past, also 3.0.x or before, the visual effect was poor.

Great, good to know!  In retrospect I wonder about these dumb
Sleep calls now replaced with cygwait, too...


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Vhqu5qQ3bjg0ZI9i
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4d6xMACgkQ9TYGna5E
T6B0cQ//ekdyzfYvDIx+luRUckI2Vv4scsy3YRlrF3enZwzxUPLH2Fsr6VbwRz0R
WWzSk35oddlbf1EajsguT0kRf2DJmW2swK17gL6LP8RMZzUKWjpU7n5i1H9ybo+U
umXBStyvb95BoDo0rISBkTJ1h2R8wVK0pXT91HfHM5b8/zrRxfrlIeeyGPQgUxMf
wGR01b3zTAYwDTCUtNPguZSAblynt8pHNEiDGAYEjIOYJtowYIg1uuE0QMiY7bS6
dGcI/rp+YlVtiewDMtxH3DG2YINd6kp7L0o3qwQhtYZ5KjFhc+PglJ5Ww5IJ4Bsv
yZWExXSgfu4r37SHwZw0rzveU/Ad3xX2dP+2f1/dj7nNIVOPvrAx1XMHcyaMCOQA
aU1L4Dm0CfuO3ycmSXCZz4MBWAiCH+7qssNfEDKCEH9pM7YHxxLLHB/ojaPPLpzj
R9iaV55KevXjmMhtvESI5CuiM0qrkvNmd3y5rib5kvt6d0lOba9d2XLy8YtgSASL
TKqjLi8VT7X0xsNGurvEOm4iZQkeV9ESBUSeRT/1HXJ4iuVMzIzp9oGOA1h05Mmr
UxM5VlwPsJnD6A6FoGmzNUnt/Mv44pDQhaW0LHPeBI9UOJzsvcV8hDLGiwf0GD9x
vE8mjXwZZx1btLz0CWO+imoz66xXHE4qnVCcMxObqe3vVax7rAs=
=A1No
-----END PGP SIGNATURE-----

--Vhqu5qQ3bjg0ZI9i--
