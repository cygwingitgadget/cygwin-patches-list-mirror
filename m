Return-Path: <cygwin-patches-return-8095-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64136 invoked by alias); 31 Mar 2015 19:03:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64126 invoked by uid 89); 31 Mar 2015 19:03:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 31 Mar 2015 19:03:37 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 10FBCA80A3F; Tue, 31 Mar 2015 21:03:35 +0200 (CEST)
Date: Tue, 31 Mar 2015 19:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Rename struct ucontext to struct mcontext
Message-ID: <20150331190335.GD15852@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20150330102129.GH29875@calimero.vinschen.de> <1427736757-13884-1-git-send-email-jon.turney@dronecode.org.uk> <1427736757-13884-2-git-send-email-jon.turney@dronecode.org.uk> <20150330184735.GA12442@calimero.vinschen.de> <551ADDF6.1060608@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline
In-Reply-To: <551ADDF6.1060608@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00050.txt.bz2


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1143

On Mar 31 18:48, Jon TURNEY wrote:
> On 30/03/2015 19:47, Corinna Vinschen wrote:
> >Just for the records what we talked about on IRC:
> >
> >On Mar 30 18:32, Jon TURNEY wrote:
> >>@@ -45,7 +49,7 @@ struct _fpstate
> >>    __uint32_t padding[24];
> >>  };
> >>
> >>-struct ucontext
> >>+struct mcontext
> >
> >__mcontext so as not to pollute the namespace.
> >
> >>    __uint64_t etr;
> >>    __uint64_t efr;
> >>    __uint8_t _internal;
> >>-  __uint64_t oldmask;
> >>  };
> >
> >Remove _internal, keep oldmask.  As a result, __mcontext is still
> >basically equivalent to Linux' mcontext_t.  __mcontext can be
> >taken from _my_tls.oldmask.
>=20
> Thanks for your help with this.
>=20
> You'll have to help me understand what the difference in meaning between
> ucontext_t.uc_sigmask and ucontext_t.uc_mcontext.oldmask is.
>=20
> In the context of _cygtls::call_signal_handler() is _my_tls.oldmask corre=
ct
> and not this_oldmask?

Yes, this_oldmask should be the right one.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVGu+GAAoJEPU2Bp2uRE+gIfIQAJGxMQA5tEU/1dDAnf28AwnE
6ICY45kOtuez67GKykIhNKhtau1rpqR/wA/B71g4z7/iyzjH015pAKC79X4skn87
EFXec5RxrLE7HPRAGwimA9aQtEiZPE2vAbxiuHmAaSdf+ICWfVlBfSbrrBSIZqBw
vhZ8VISFJ/VX5A/n1uIuxMMMbMcG+uaB7YsTaV5Ax8cPNL20gutAse1WF4dThLNR
WR+8XFX5AEQhi7yMVq3xnXuIIx9bhVAAySPQOZkYP4+1hneLWnsDCReSV7gMQcMd
10eRkPxw6Fk5WXl2eaSsyPjbuPaoX7wjfFk8ehRcZDJae9zO4mZH9V69U23n7hm6
vDSxpXMEdt73btAg1pW77oBpgYY9bHsHPYYAqCPqUH2Cfv8JYNGUiIC/gFBVSE5L
7N3kdJ+SBB2lvmlwZBTtUjA+DnlfVOmjTCVyx0gnbjA0sXF2zfC2sgbFEb89v8+C
WNU6VBZr9o07ZEvF+XfImmXR160ExeZ294iaM02HqVTiTY4evsKGTL4+ByIvImd3
GTqaTagvXS1efDMnmXmtBXe9yUvazKsv/u5rPF/lOxiwqzA8S+HbQgaj1LdiZhr0
vLy+YIxNtZ+bKeQxyweex6Szm8u08ouisjWzUjcFlnFs9Bne7RyVbcT4LopfKgr8
WPJJO3LoMEVR3+o5tPvE
=kG6t
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
