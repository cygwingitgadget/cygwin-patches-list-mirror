Return-Path: <cygwin-patches-return-9355-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48243 invoked by alias); 16 Apr 2019 11:22:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48231 invoked by uid 89); 16 Apr 2019 11:22:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, retry
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Apr 2019 11:22:47 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MwQGj-1gxJmj1MA9-00sMpQ for <cygwin-patches@cygwin.com>; Tue, 16 Apr 2019 13:22:44 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 914CDA80586; Tue, 16 Apr 2019 13:22:43 +0200 (CEST)
Date: Tue, 16 Apr 2019 11:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
Sender: cygwin-developers-owner@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 00/14] FIFO bug fixes and code simplifications
Message-ID: <20190416112243.GR3599@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190414191543.3218-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ELVYuRnMxQ5nnKRy"
Content-Disposition: inline
In-Reply-To: <20190414191543.3218-1-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00062.txt.bz2


--ELVYuRnMxQ5nnKRy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1219

On Apr 14 19:15, Ken Brown wrote:
> Ken Brown (14):
>   Cygwin: FIFO: rename client[] to fc_handler[]
>   Cygwin: FIFO: hit_eof: add a call to fifo_client_lock
>   Cygwin: FIFO: remember the type of the fhandler
>   Cygwin: FIFO: fix a thinko in listen_client_thread
>   Cygwin: FIFO: fix the error checking in raw_read
>   Cygwin: check for STATUS_PENDING in fhandler_base::raw_read
>   Cygwin: FIFO: code simplification: don't overload get_handle
>   Cygwin: FIFO: fix fifo_client_handler::close
>   Cygwin: FIFO: fix the use of the read_ready event
>   Cygwin: FIFO: use a retry loop when opening a writer
>   Cygwin: FIFO: fix clone
>   Cygwin: FIFO: start the listen_client thread when duping a reader
>   Cygwin: FIFO: improve raw_write
>   Cygwin: FIFO: fix and simplify listen_client_thread
>=20
>  winsup/cygwin/fhandler.cc      |  14 +-
>  winsup/cygwin/fhandler.h       |  43 +--
>  winsup/cygwin/fhandler_fifo.cc | 580 +++++++++++++++++----------------
>  winsup/cygwin/select.cc        |   4 +-
>  4 files changed, 342 insertions(+), 299 deletions(-)
>=20
> --=20
> 2.17.0
>=20

Pushed with v2 of patch 13.  Developer snaps should be up shortly.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--ELVYuRnMxQ5nnKRy
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAly1uwMACgkQ9TYGna5E
T6DTfhAApmDK5W5DrIu/OAsqldZ7qYEF1inILtAIASGJlcYa428XNFA7tExZfRrs
/NOom6Ke6dnVJb76PpfnHlmVHgIDTbAnQNn7Iq2BiOPzc2C/B99GtWntaHpMzYK8
AQvWwnaCP5mbJiPOOXLTDBs2q0fKHNKR6GXD1xzVFMiRwjrxjC2irjGmTlx8CtFh
Am8ln5tzyiK0+2/nFw222bgdxzmVgvVEUKXnKD9JE5LFS4BhbT1Ki8tkVxqevQGO
jX12UOKK3xX9m5FbxbneCyYhmcI4uYHa5HAn0N/VqrSvznvZh5LRGANoAZKR/cVW
gfe07QEjZ5ZMq2dyUV5P5Hq67dUO2BAkw8c9dvxe31a1SFjWkDXQx+fxL36WhlR3
dWmIh0gafQbzH7Idy6n6dERIXd+d7nMEdpAJpO0kazMwQv9Ya2TetFRAvvIYDoiU
ORc3chlVoEBv7IAGekmJp085MSkXyKI3MgYMF7dGKW+0fPPFmpUc91XXVEzd0oPv
Y4FetN+IVsfwzAm+32A2OKtVsO0CswRNOok11yrjqaOYMQS6k68RKLKmvtBt6knn
RSRnTr10BKFPZhtxbISHWi1LvYADsiHPQaxK7zh+olB5Kpr/kJCLKWeYLHgBcjt1
CF2Suu1vNetGTNHWZ8mv/B7iJQcgSg2bw8wJn5sVswVvB26Gb84=
=8z+r
-----END PGP SIGNATURE-----

--ELVYuRnMxQ5nnKRy--
