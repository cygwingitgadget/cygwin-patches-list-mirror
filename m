Return-Path: <cygwin-patches-return-8309-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36170 invoked by alias); 12 Feb 2016 20:31:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35969 invoked by uid 89); 12 Feb 2016 20:31:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=filler, H*F:U*corinna-cygwin, Hx-languages-length:1700, HTo:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 12 Feb 2016 20:31:14 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id F0C57A80562; Fri, 12 Feb 2016 21:31:12 +0100 (CET)
Date: Fri, 12 Feb 2016 20:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: update child info magic
Message-ID: <20160212203112.GA27302@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1455244717-12688-1-git-send-email-yselkowi@redhat.com> <20160212093359.GC19968@calimero.vinschen.de> <56BE0DFC.7000702@cygwin.com> <20160212171815.GA21562@calimero.vinschen.de> <56BE3B05.1030108@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <56BE3B05.1030108@cygwin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00015.txt.bz2


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1948

On Feb 12 14:05, Yaakov Selkowitz wrote:
> On 2016-02-12 11:18, Corinna Vinschen wrote:
> >On Feb 12 10:53, Yaakov Selkowitz wrote:
> >>On 2016-02-12 03:33, Corinna Vinschen wrote:
> >>>On Feb 11 20:38, Yaakov Selkowitz wrote:
> >>>>	winsup/cygwin/
> >>>>	* child_info.h (CURR_CHILD_INFO_MAGIC): Update.
> >>>
> >>>This needs an explanation.  CHILD_INFO_MAGIC is still 0x30ea98f6U
> >>>for me.
> >>
> >>Hmmm, in that case it's either one of the patches I just sent or it's g=
cc-5.
> >>How would either of those affect this?
> >
> >Off the top of my head, I don't know.  Usually only a change to
> >child_info.h should affect CHILD_INFO_MAGIC.  Unless the preprocessed
> >output of gcc differs for some reason.
>=20
> It turns out it does.  Anything that is substituted by preprocessor is
> placed on its own line with gcc-5, e.g. with NULL and _SYMSTR:
>=20
> @@ -47340,7 +47636,11 @@
>    char filler[4];
>    child_info_fork ();
>    void __attribute__((__stdcall__)) __attribute__ ((regparm (1)))
> handle_fork ();
> -  bool abort (const char *fmt =3D __null, ...);
> +  bool abort (const char *fmt =3D
> +                               __null
> +                                   , ...);
>    void alloc_stack ();
>  };
>=20
> @@ -47422,6 +47722,14 @@
>=20
>  extern "C" {
>  extern child_info *child_proc_info;
> -extern child_info_spawn *spawn_info asm ("_" "child_proc_info");
> -extern child_info_fork *fork_info asm ("_" "child_proc_info");
> +extern child_info_spawn *spawn_info asm (
> +                                        "_"
> +                                        "child_proc_info");
> +extern child_info_fork *fork_info asm (
> +                                      "_"
> +                                      "child_proc_info");
>  }

Is that deliberate or a bug?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWvkEQAAoJEPU2Bp2uRE+gU2AP+wRb/yL6bq2xX+HJtc5uTS43
43DRz4elRfiZ6huOI5JuVozHThTliGdYPfk5/iwOfSEAqZcD0UiUwK0VR24f6JEO
08U77whC9MmegNg5tbwFGZFad61LMF5kJWRp2sbBFEgyJNZiSfvy468Ye99P0+DK
BK6s5BcPJ3Qp3coFOBnOZfAuR6mnPfxc66whthyExVELdoGQ2DQ1QB5lx+CJBVR8
OZPyWajkheK0I5DUnyS/zNpl8MS0e1iVej+B+tSFXwxmdQ7d/9ITYu95ZEhN5iUD
1B7KbeH9VGE4IScvMOUXEoOMeETlHBqmKdop/+GsHKI2dNGMgVhIEYNfjWfYt/j9
ECf+EHFQTh8Tx7I+EOVbQz/+GtSMXIMekbaLglP+QAqHhYPojVvnz8lvjuDOfRxi
uezphLEl8fATqaQ75iT3ZC6wot2EKZBHLsQLhF/zlFxx2I00y/+EQVSYTLcOlA7R
qJDOpycvWqf88UeOphyk4HFwQ3lKBrvd7I8b0WT9vAIgR6wcBuvYZzhAXq5Uzigx
8FXjrhuXmom6qg6bAVDEr4eO88WHedTPY9a2ZLlixlw9L+eG/E4gwGyzgvJRN/od
Y3XABzuAXXE0IT3MnnnmgSx0YY37Mz7ruUnO44/AzyymXHJt7yR9QJjx0KowSu5r
0HFeO+3VuvOaT9i2fp6F
=WB04
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
