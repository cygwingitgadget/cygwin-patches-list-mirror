Return-Path: <cygwin-patches-return-8741-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 82329 invoked by alias); 18 Apr 2017 10:04:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 82310 invoked by uid 89); 18 Apr 2017 10:04:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=love, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, learn
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 18 Apr 2017 10:04:03 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id E595B721E281E	for <cygwin-patches@cygwin.com>; Tue, 18 Apr 2017 12:04:00 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 553FB5E046E	for <cygwin-patches@cygwin.com>; Tue, 18 Apr 2017 12:04:00 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3F316A80C12; Tue, 18 Apr 2017 12:04:00 +0200 (CEST)
Date: Tue, 18 Apr 2017 10:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] strace: Fix crash caused over-optimization
Message-ID: <20170418100400.GA29220@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170415222750.28067-1-daniel.santos@pobox.com> <201db532-9a76-7358-d12a-469a1f5e7d71@dronecode.org.uk> <955dbe34-f515-1e39-1d9c-a5e92c33fd87@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <955dbe34-f515-1e39-1d9c-a5e92c33fd87@pobox.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00012.txt.bz2


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2408

On Apr 17 03:39, Daniel Santos wrote:
> On 04/16/2017 05:21 AM, Jon Turney wrote:
> > On 15/04/2017 23:27, Daniel Santos wrote:
> > > Recent versions of gcc are optimizing away the TLS buffer allocated in
> > > main, so we need to tell gcc that it's really used.
> > > ---
> > >  winsup/utils/strace.cc | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/winsup/utils/strace.cc b/winsup/utils/strace.cc
> > > index beab67b90..1e581b4a4 100644
> > > --- a/winsup/utils/strace.cc
> > > +++ b/winsup/utils/strace.cc
> > > @@ -1192,6 +1192,8 @@ main (int argc, char **argv)
> > >    char buf[CYGTLS_PADSIZE];
> > >=20
> > >    memset (buf, 0, sizeof (buf));
> > > +  /* Prevent buf from being optimized away.  */
> > > +  __asm__ __volatile__("" :: "m" (buf));
> >=20
> > wouldn't adding volatile to the definition of buf be a better way to
> > write this?
>=20
> I actually did try that, although I had guessed it wouldn't (and shouldn'=
t)
> work.  I believe that the reason is that rather the accesses are volatile=
 or
> not, gcc can see nothing else using it and memset can be a treated as a
> compiler built-in (per the C spec, maybe C89?), so it can presume the
> outcome.  If there's a cleaner way to do this, I would really love to lea=
rn
> that.  __attribute__ ((used)) only works on variables with static storage.
>=20
> Now I suspect that I may have found a little bug in gcc, because if I call
> memset by casting it directly as a volatile function pointer, it is still
> optimized away, and it should not:
>=20
>   ((void *(*volatile)(void *, int, size_t))memset) (buf, 0, sizeof (buf));
>=20
> And most interestingly, if I first assign a local volatile function point=
er
> to the address, then gcc properly does *not* optimize it away:
>=20
>   void *(*volatile vol_memset)(void *, int, size_t) =3D memset;
>   vol_memset (buf, 0, sizeof (buf));
>=20
> I'm actually really glad for your response and that I played with this
> because I need to make sure that this problem doesn't exist in gcc7.  I h=
ave
> changes going into gcc8 shortly and this could mask problems from my test
> program where I cast functions as volatile w/o assigning using a local.
>=20
> Daniel

What about using RtlSecureZeroMemory instead?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9eSQAAoJEPU2Bp2uRE+ghiMP/2lOmEggKg6okNqnzOrT01Rs
nwQ9H+RE58e67hfvclsvKbQ7//q/2i+lM+voVTJ7VQmLxWUcf/gZwCiARL2vX887
DSboDj21MpvKbhloF9ZhshCn6M2S7frNrzGUwiX7A9UToXFVVZnT25xB6NSyiDnU
NnRaCMUknfPSdNk06eQoagmWJmb6jZae0HZ1TDv2DeCULYaPejOLTyzk9MT7xcTx
u6GgjXf0SFjkVpursF949Oe2/RCjwFR8oDETLdTG/EbSbNLoDZhgeDPUbKd9Trkq
PjKRMWWgb+byHKxTOOBYo/WQ4rh2HUKMy/6d+raoRSnHFsKS1bGSNojHZyFxV9pG
2+gNjGr+siGIa0hqlsv0lzzkirw3gW+huqayHO5TZRMt9/kiAi2zukzQ5d7umHdu
maUQa/JJVSJYqdMEz0S8pSahDVeEnBv+cbAWMM0YSsNw46jY3JLPDvcQhNvHeJRo
MrCrzJjkTATWa3PaxUkDS3K300H8n/4hFwy/oHfenl+5R7+eX/rGiGCSVckp4Sh1
yFrCtFWr4fXhqqCiJPlcRy+f5JaCDUZcwREPGhcRoCi5qaSf1wyYoq/+uSIrec/F
eBQbr5GGi33t6I62egfcMhyYGBx7ZZKfEilqzHz3mmC63/CVqlZQFdLMufpin0ey
onLqZCZTBmO64EcI3Td4
=Nsd5
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
