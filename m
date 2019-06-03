Return-Path: <cygwin-patches-return-9420-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 85236 invoked by alias); 3 Jun 2019 16:34:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 85226 invoked by uid 89); 3 Jun 2019 16:34:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=sshd, shutdown, Ping, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 03 Jun 2019 16:34:31 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N5FtF-1gWxy33INZ-011Ehb; Mon, 03 Jun 2019 18:34:26 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A83E2A80653; Mon,  3 Jun 2019 18:34:25 +0200 (CEST)
Date: Mon, 03 Jun 2019 16:34:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: expand common_apps list
Message-ID: <20190603163425.GI3437@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>,	cygwin-patches@cygwin.com
References: <20190523170532.64113-1-yselkowi@redhat.com> <d5c6bf3c-b429-689e-2909-01c5680e12ac@SystematicSw.ab.ca> <b61928129326ea776c98684346790458791dfbb4.camel@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="tcC6YSqBgqqkz7Sb"
Content-Disposition: inline
In-Reply-To: <b61928129326ea776c98684346790458791dfbb4.camel@cygwin.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00127.txt.bz2


--tcC6YSqBgqqkz7Sb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 857

On May 27 00:50, Yaakov Selkowitz wrote:
> On Sun, 2019-05-26 at 00:49 -0600, Brian Inglis wrote:
> > To a degree, depends on installed Cygwin packages and Windows features,=
 but I
> > also have in both Cygwin /{,{,usr/}s}bin and /Windows/{,System32{,/Open=
SSH}/:
> >=20
> >         {"certutil", 0},
> >         {"comp", 0},
> >         {"ftp", 0},
> >         {"scp", 0},
> >         {"sftp", 0},
> >         {"sftp-server", 0},
> >         {"shutdown", 0},
> >         {"ssh-add", 0},
> >         {"ssh-agent", 0},
> >         {"sshd", 0},
> >         {"ssh-keygen", 0},
> >         {"ssh-keyscan", 0},
> >=20
> > from ls *.exe | sort in each set of dirs then join both.
>=20
> I don't have /Windows/OpenSSH on my system.  Is it added to PATH when
> present?
>=20
> --
> Yaakov

Brian?  Ping?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--tcC6YSqBgqqkz7Sb
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlz1TBEACgkQ9TYGna5E
T6DAiA//UldbSV4QmHvk96XkaivJL9WpCSH6sYdFM2SiJFITHsv30BKkEp/PLIjH
9frKoQmqt4e9qJMe6FsBAy9uX8GhamUdpuzzQuym+gJoM9UJ2O5yU7xLrHhxy/0A
83Jf582X9UVL4Za1wtikhvEPesOrFBcrwI58nvundSW2ccYpT/Iz7L8SArEW0d6x
xf5EHA1p7jtYLf/1SXziHzyNe/Ng5g+kke5bE1U8IWk9t1aK9Bjj86I3hdbHU3LM
/9dtvAOkg7R2K3FRTUQJ0gHZz5xgnAnhwoNI3RXcPvIc1lm4x566Be86c+bAvHZ5
Dzc6QaIIsmxTl7c4L020HFBxq5E+lsiiAhrQi0y119UfSenT+0iXCs/QJj5RtcYm
dsKAJM3FtfLDaWBP25ln62G1cd/233qcLDjf95xo4XQ95qnV2+niv1BUkIwv0/y4
FZSlwQ1klgjAk3+oYl8bxf3zxRpzBzmyTC/ZuGzvx7DT0Wjc9IW5afDPNd7q7wgG
bvhE+u5rmlo2m2BYCbgcgJ3drv1SUg5KNI6rH2V1P0iHUQhz9I0/RhXU7BheLkkt
gfwnOGp5PWQ4xw/4rXRIbDFEjIWH1FwOAZCV/vqeWcd3ft7gik9ts39mH+jlH4WN
ybx/wyP4hoYPiyc2wgYac/Xb2sj/i3wdm/1ufbazH6I3qnA6Ufs=
=pZNM
-----END PGP SIGNATURE-----

--tcC6YSqBgqqkz7Sb--
