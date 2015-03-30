Return-Path: <cygwin-patches-return-8083-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 117557 invoked by alias); 30 Mar 2015 18:47:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 117547 invoked by uid 89); 30 Mar 2015 18:47:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 30 Mar 2015 18:47:37 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 253A1A80975; Mon, 30 Mar 2015 20:47:35 +0200 (CEST)
Date: Mon, 30 Mar 2015 18:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Rename struct ucontext to struct mcontext
Message-ID: <20150330184735.GA12442@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20150330102129.GH29875@calimero.vinschen.de> <1427736757-13884-1-git-send-email-jon.turney@dronecode.org.uk> <1427736757-13884-2-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <1427736757-13884-2-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00038.txt.bz2


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 673

Just for the records what we talked about on IRC:

On Mar 30 18:32, Jon TURNEY wrote:
> @@ -45,7 +49,7 @@ struct _fpstate
>    __uint32_t padding[24];
>  };
>=20=20
> -struct ucontext
> +struct mcontext

__mcontext so as not to pollute the namespace.

>    __uint64_t etr;
>    __uint64_t efr;
>    __uint8_t _internal;
> -  __uint64_t oldmask;
>  };

Remove _internal, keep oldmask.  As a result, __mcontext is still
basically equivalent to Linux' mcontext_t.  __mcontext can be
taken from _my_tls.oldmask.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVGZpHAAoJEPU2Bp2uRE+gUogQAIZwkgU7r484kARRtZr4SlgC
vAHl15Y54c8QyE6oZtfpDxhw1CJcldMwZixZWXCmsEJfd0EIyz72Rn4AaXWjfMdl
NCrvdwwEiZEUHqewS4uWY9qkX2ZUOMCZ1c7DiRKfE/vTOhoSkxCLMAbwlZ3vn4uC
pnV9vECT9YhEhZ4E9F5biI8dI4T6HahN/5MDQFRJROhF3YDYV0U7jCaCg1blqw0t
g+vyd3euLq6tE5EDiusLam1JkAc4gMi/Y1LkOGygNdb/zWS1A327ayfZjwL4yvaF
HWcJ0tQxCEhX6VUAH2gUtDj/b76Iru3MG9GA2y1aDF/OW5JFVJdP0gilynCBojek
NnbLEuOL0ICsann4APM0amnCuY+ZTezmEit2urxZO5a+yf1rrOmRgEF37LJ+eewJ
loJZgXPbV4cM4phJyaRSh53na6Pk3l+R8qpHk3l+n9tCFrZ6kTSZbfVF59exjf1m
akWlMh6o7Fg7E8je3vXuej7PBP/T6G/Myq0Qdf2KwDWgLcTclm6yh9fT/kdw8qwM
WmrRXWEwlmLeNW7aNTg7helRNSQAV2zAqpToNJ3DUlFvspujgmwdfsKLl6/OlOnW
/LdR+p8gyaBE7LTyEoMqdSkUsx/PqccwUyjUAbKtwAhyJo30NyVo5hh+7J8fqSmC
6gyr3NHpy/IzjAsucYMd
=3Ibu
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
