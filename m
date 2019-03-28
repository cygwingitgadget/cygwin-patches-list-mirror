Return-Path: <cygwin-patches-return-9252-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 82879 invoked by alias); 28 Mar 2019 09:16:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81559 invoked by uid 89); 28 Mar 2019 09:15:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-117.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 09:15:39 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MCJzI-1hIp331bda-009QDF for <cygwin-patches@cygwin.com>; Thu, 28 Mar 2019 10:15:23 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id F0DA3A8057D; Thu, 28 Mar 2019 10:15:22 +0100 (CET)
Date: Thu, 28 Mar 2019 09:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: FIFO: implement clear_readahead
Message-ID: <20190328091522.GN4096@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190327212910.672-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="I/5syFLg1Ed7r+1G"
Content-Disposition: inline
In-Reply-To: <20190327212910.672-1-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00062.txt.bz2


--I/5syFLg1Ed7r+1G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1339

On Mar 27 21:29, Ken Brown wrote:
> Make fhandler_base::clear_readahead virtual, and implement
> fhandler_fifo::clear_readahead.  This is called by
> dtable::fixup_after_exec; it clears the readahead in each client.
> ---
>  winsup/cygwin/fhandler.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> index 3398cc625..21fec9e38 100644
> --- a/winsup/cygwin/fhandler.h
> +++ b/winsup/cygwin/fhandler.h
> @@ -444,7 +444,7 @@ public:
>      return dev ().native ();
>    }
>    virtual bg_check_types bg_check (int, bool =3D false) {return bg_ok;}
> -  void clear_readahead ()
> +  virtual void clear_readahead ()
>    {
>      raixput =3D raixget =3D ralen =3D rabuflen =3D 0;
>      rabuf =3D NULL;
> @@ -1302,6 +1302,12 @@ public:
>    bool arm (HANDLE h);
>    void fixup_after_fork (HANDLE);
>    int __reg2 fstatvfs (struct statvfs *buf);
> +  void clear_readahead ()
> +  {
> +    fhandler_base::clear_readahead ();
> +    for (int i =3D 0; i < nclients; i++)
> +      client[i].fh->clear_readahead ();
> +  }
>    select_record *select_read (select_stuff *);
>    select_record *select_write (select_stuff *);
>    select_record *select_except (select_stuff *);
> --=20
> 2.17.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--I/5syFLg1Ed7r+1G
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyckKoACgkQ9TYGna5E
T6BzhQ//ZSsz8sPuWIvnuQDg+XkqontmTUJx7tjt0aSrjp3Kkpb8WTs/NUUyKZ/U
9o/JaGIu8azODka9y8OOVh4JDUC/Mmvqfn6PNyzNfavJ65c78ElUl1a9qI23ucO/
5dEJ28bmDvs38b05NkVjse/zTfSTJrLaMYrQ0zuLvTh4nFsLMCn5prjyWCINiL64
7CrdpdQ/rnucHaIm7tYFuYU4ROrmOuI2Sbn2DQVo8gv4q0b2jv+LDomG9P5mWJs6
i3hUyxeQEOjx5No0T3ymMZd+tPtN6y/ysikDODp2rGABCZ4JAneksOe4GQkjw8nx
pFYE+iGsCKuU7szV2UNR0f9BCSWiW9r1zpZcIFd4PTcqnCIpeF3qhuI/RmYseuvd
T+pDMEwKj21hDuNy6wCavcdY0b5pF1XXygDFxKF11kgF8YqpdrgTzIXXPwD9IpY3
rDt6enZJH2CDRZLPlUNe+AUKgG+zMsHgLnnpopgTjzOyftlLUEgiRHrywwS5eDbE
vsC+0eFDW5Gk1GjTc4T93xrC3ExaOE15W1azDu9lGFQsJ0ydYtrBkMdeUHpNJjlJ
jreDT9ik1qYPm7vmrOjukxdwLRXpC2WkC/W5+XxkGQzG0I5KIc4gQIoinydHuQfF
V+aCopvV3u8b6RMCCXLYd9AdraQggI5e00rrRBdma5ofSlfuFMk=
=2h/d
-----END PGP SIGNATURE-----

--I/5syFLg1Ed7r+1G--
