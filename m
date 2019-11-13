Return-Path: <cygwin-patches-return-9840-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124371 invoked by alias); 13 Nov 2019 08:54:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124356 invoked by uid 89); 13 Nov 2019 08:54:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=international, International, Google, google
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 13 Nov 2019 08:54:55 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N3omW-1hmdu10zzc-00znFk for <cygwin-patches@cygwin.com>; Wed, 13 Nov 2019 09:54:53 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 89BD9A809F3; Wed, 13 Nov 2019 09:54:52 +0100 (CET)
Date: Wed, 13 Nov 2019 08:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] regtool: Ignore /proc/registry{,32,64}/ prefix, with forward or backslashes, allowing path completion
Message-ID: <20191113085452.GL3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191110161445.53479-1-Brian.Inglis@SystematicSW.ab.ca> <20191111091337.GE3372@calimero.vinschen.de> <20191111091909.GG3372@calimero.vinschen.de> <130d853b-1614-0e22-3bdd-c79f311ace0f@SystematicSw.ab.ca> <20191111162853.GI3372@calimero.vinschen.de> <5f5ad434-a01b-1609-1624-c47252e56f64@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Ubca5Sl/zyRO+Ah+"
Content-Disposition: inline
In-Reply-To: <5f5ad434-a01b-1609-1624-c47252e56f64@SystematicSw.ab.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00111.txt.bz2


--Ubca5Sl/zyRO+Ah+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1267

On Nov 11 13:47, Brian Inglis wrote:
> On 2019-11-11 09:28, Corinna Vinschen wrote:
> > Ok, we can add something to the help text, but the text still sounds
> > confusing, even the altenative one.  I think the reason is the negative
> > expression "ignore" here.  Why not express this in a positive way like
> > this:
> >=20
> >   "Use the /proc/registry{,32,64}/ registry path prefix to utilize path
> >    completion."
> >=20
> > Something like that anyway.
>=20
> Maybe something may be misinterpreted from your consideration of Internat=
ional
> English wording that is not even considered in my native English; "is ign=
ored"
> is passive voice but not negative in English, and neither does it appear =
to be
> so in Deutsch (via Google): "Zur Unterst=C3=BCtzung der Pfadvervollst=C3=
=A4ndigung wird
> das Schl=C3=BCsselnamenpr=C3=A4fix /proc/registry{,32,64}/ ignoriert."

Probably I phrased this wrong.  I was not talking about negative
connotation, but about using a negating expression.  Not doing something
vs. doing the other.   To a non-developer it may be pretty unclear
what's the deal with "ignoring a path prefix".  I think a simpler,
positive (non-negating) expression may be clearer, that's all.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Ubca5Sl/zyRO+Ah+
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3LxNwACgkQ9TYGna5E
T6CZoQ/9FxQu9yXGFrB4LeQQzw6rLA6YucZk8HTyL4C5KNRIuypRWgMh4FudtlLS
PbWPTtpKkAOrSdiJZxlQ1FKlOyVhOenMJ1tQ/6y+S7oBLkUgWl91oAF9uM780iA6
BX6VJKJ0LIfI6xyY2cyCI7QjhC4EJrA69nFhcJz6y2Bg8/by5XZBFKcm75YKPC22
ZVsAo/WO45+NA65SKXizWQ8whCLnjtUlZp5dEcATr/2me4SNum9gfhQiRXjpKtxJ
ISS5YPJkdqYFr+2qNJ5Zowhv91E8KD3As8fm89Ug8ys7mzQ30pbSrtakMLswllXf
RVsQCy1Q1Mol9a2azXJCIi9BIOF0NfIJ/waaOV87jKBErG5aOOkXSXyBJvDrnFYv
4QYe2wc/H5Tx5ImHioOuwHGyba8a29oxsJYnmwP/w75oFn5mVB71KSO2qEeNMjmr
uV0F6VL+09maZvRe2qW4ohbO26GZrcXPMm60nlqLAZXYfH44TSmwexG6s8ufrc4P
l78dy6cqCrRgG8aLyGytrB8HGBtz7vSmHy9Sz3TTs0i4e5ibO4ooxybMEzVuvdWJ
A9wm3vsjaYR+Ix6836+N8iF9GT3+lYB1HBJDezvZz2LZbFDByeGypePkj2ghCIWQ
8jxiZwFqpZZP71mZ+4exuAIa7rlWfTTSotwPL7goUD4p0dgWIgI=
=im5G
-----END PGP SIGNATURE-----

--Ubca5Sl/zyRO+Ah+--
