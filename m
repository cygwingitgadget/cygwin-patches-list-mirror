Return-Path: <cygwin-patches-return-9033-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1807 invoked by alias); 22 Feb 2018 13:14:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1634 invoked by uid 89); 22 Feb 2018 13:14:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=pine, piping, screw, Pine
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 22 Feb 2018 13:14:19 +0000
Received: from perth.hirmke.de (aquarius.franken.de [193.175.24.89])	by mail-n.franken.de (Postfix) with ESMTP id 61C77721E280D	for <cygwin-patches@cygwin.com>; Thu, 22 Feb 2018 14:14:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perth.hirmke.de (Postfix) with ESMTP id 3D55B862108	for <cygwin-patches@cygwin.com>; Thu, 22 Feb 2018 14:14:15 +0100 (CET)
X-Spam-Score: -2.9
Received: from perth.hirmke.de ([127.0.0.1])	by localhost (perth.hirmke.de [127.0.0.1]) (amavisd-new, port 10024)	with LMTP id VyrN5sO9OivI for <cygwin-patches@cygwin.com>;	Thu, 22 Feb 2018 14:14:14 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by perth.hirmke.de (Postfix) with ESMTP id AF52B8620FE	for <cygwin-patches@cygwin.com>; Thu, 22 Feb 2018 14:14:14 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A63E5A806E3; Thu, 22 Feb 2018 14:14:14 +0100 (CET)
Date: Thu, 22 Feb 2018 13:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] doc/ntsec.xml: Fix typo
Message-ID: <20180222131414.GA10740@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <f1047ae4-4edf-6343-2929-c193e6cee77c@gmail.com> <20180221210534.GA7576@calimero.vinschen.de> <9501f8b9-f84a-ea43-93da-c0eeb8ca9d35@SystematicSw.ab.ca> <20180221213714.GB7576@calimero.vinschen.de> <1403214d-ca26-02ad-5d59-eea94b7039bb@gmail.com> <Pine.BSF.4.63.1802220257200.76751@m0.truegem.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.1802220257200.76751@m0.truegem.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q1/txt/msg00041.txt.bz2


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1525

On Feb 22 03:04, Mark Geisert wrote:
> On Thu, 22 Feb 2018, David Macek wrote:
> > On 2018-02-21 14:05, Corinna Vinschen wrote:
> > > The patch is malformed.  It claims to contain 7 lines (6 lines contex=
t,
> > > one line changed), but actually it has only 4 lines context.  Please
> > > check your git settings.
> >=20
> > On 21. 2. 2018 22:56, Brian Inglis wrote:
> > > I can see why you strenuously request git format-patch/send-email
> > > attachments ;^>
> >=20
> > I did use `git format-patch` to make that message (then sent using TB).
> > I guess I'll have to try something else next time.
>=20
> Been there, done that, even the "I'll have to try something else".  It's
> astounding how SeaMonkey, Pine, and probably gmane bork up the formatting=
 of
> something that looks so benignly laid out to begin with.
>=20
> After much experience putting up with these and other MUAs from us, Corin=
na
> really does know *the* solution that just works.  'git format-patch'
> followed by 'git send-email'.

Actually, in this case I'm a bit puzzeled about mutt.  I would have sworn
mutt doesn't screw up, but the fact that there are encoded lines in the
original mail like

  =3D20=3D20\n

which simply disappear in the output after storing the mail with the
decode-copy function leaves me stumped.  I also tried piping into cat,
and the problem persists.  Weeeeeird.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlqOwiYACgkQ9TYGna5E
T6Dwzw//ewqC4ZU0ZBWE2cXf2T2v88KPVgNecWOIjg0Dnlgl5wVmDHo3Di3O8kj5
LShG6TKbR1XJFq98nAM4KbJuhgRg0N8FQNwDEbeGhfX3/znkRhpiuBlyuDZ7RO6x
fr/emVKQiwiFzBW8/anUZV9eaD39kBA7bOzd4fIUe7XYWfGGwUMSPcdMcvMzLhDP
XfQfl47wYvuAgJt0BbD7Zat6ZEmC57XPcqWgG+Urr70WSfymzqfuuJ3NEb2CHfB6
7C9sm+FLx7tfTo7w8usxK07WbAssGmXY4QNXpZ9PI+rnxVFf/ocLuzWjNwQCqxhC
Yzu6WKgxN/mkvjNioa5SGM0qXDi10nrvJtUUFnCPWieAWqEz4FE/hTSH2xBKt9F0
dUZWfRGKBolUjsjtpCHz9iB0ryItPaGLbzTCMupEgVTLoscFVmIRNdbYOaJjftVE
tbnhHioUbunWAtvxUhjlLMZ1BqzBGh8Hxta79buJX86DGI9D5scbGgoCxSpV9pxl
JwAxw0XOK2KtHTpnerAD/U/7JMkIrcRZH4vb1V1LhunnY/eNPhr9oFc5y4w5UX7R
Ua30RWgPqtEVF2UArcywzOnNEqnYq6f4aEvVDBx1X7+TZ2osLNoBQbwapwD2o5Qq
5mZqbyTBgRtO5n39gOiU2IWS7VODfnallJhkfmL7ZU30m2hi3nw=
=Ksmm
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
