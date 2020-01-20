Return-Path: <cygwin-patches-return-9956-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 112969 invoked by alias); 20 Jan 2020 09:35:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 112960 invoked by uid 89); 20 Jan 2020 09:35:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-113.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Jan 2020 09:35:45 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MuDTn-1jlAcF2BB7-00uXNi for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2020 10:35:42 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C419CA80734; Mon, 20 Jan 2020 10:35:41 +0100 (CET)
Date: Mon, 20 Jan 2020 09:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: allow opening an AF_LOCAL/AF_UNIX socket with O_PATH
Message-ID: <20200120093541.GC20672@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200116183355.1177-1-kbrown@cornell.edu> <20200117094826.GC5858@calimero.vinschen.de> <20200117095104.GD5858@calimero.vinschen.de> <f94efc8e-28d3-fd68-d6e4-a092637cf6e8@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <f94efc8e-28d3-fd68-d6e4-a092637cf6e8@cornell.edu>
X-SW-Source: 2020-q1/txt/msg00062.txt


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1728

On Jan 19 20:25, Ken Brown wrote:
> On 1/17/2020 4:51 AM, Corinna Vinschen wrote:
> > On Jan 17 10:48, Corinna Vinschen wrote:
> >> On Jan 16 18:34, Ken Brown wrote:
> >>> If that flag is not set, or if an attempt is made to open a different
> >>> type of socket, the errno is now EOPNOTSUPP instead of ENXIO.  This is
> >>> consistent with POSIX, starting with the 2016 edition.  Earlier
> >>> editions were silent on this issue.
> >>> ---
> >>>   winsup/cygwin/fhandler.h               |  2 ++
> >>>   winsup/cygwin/fhandler_socket.cc       |  2 +-
> >>>   winsup/cygwin/fhandler_socket_local.cc | 16 ++++++++++++++++
> >>>   winsup/cygwin/fhandler_socket_unix.cc  | 16 ++++++++++++++++
> >>>   winsup/cygwin/release/3.1.3            |  7 +++++++
> >>>   winsup/doc/new-features.xml            |  6 ++++++
> >>>   6 files changed, 48 insertions(+), 1 deletion(-)
> >>
> >> I'm a bit concerned here that some function calls might succeed
> >> accidentally or even crash, given that the original socket code doesn't
> >> cope with the nohandle flag.  Did you perform some basic testing?
> >=20
> > Iow, do the usual socket calls on a fhandler_socket_local return EBADF
> > now?  Ignoring fhandler_socket_unix for now.
>=20
> I really hadn't thought this through very well.  I think the following=20
> additional patch should do the job:
>=20
> --- a/winsup/cygwin/net.cc
> +++ b/winsup/cygwin/net.cc
> @@ -67,6 +67,11 @@ get (const int fd)
>=20
>     if (!fh)
>       set_errno (ENOTSOCK);
> +  else if (fh->get_flags () & O_PATH)
> +    {
> +      set_errno (EBADF);
> +      fh =3D NULL;
> +    }
>=20
>     return fh;
>   }

Looks like the easiest solution indeed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4ldG0ACgkQ9TYGna5E
T6ALKw//eYO2jo5aY9mMr8KX+XMuKD2wUEikLTjPyfJw5idCyXfNKKO9SiHNXXgM
2+QnDcYi4JMNmiyA5QwG1Sbdc+tLzC91Tps7o1kjdijPWr172yOr3chtCIfYsWo6
hamN3H69vobDfAXI8S38XEpoq/7aVRTZsPoEDIQ7aUk6HkYm7AQGgANU2cbo7lQQ
eo2UwhYvvSFVSfyrRxPNGMxddaxYKreH0fAISiFQqduchGsoHHKw9Bbyp3+CmOFz
jxgCOXCBFT5kql/yE3bds3qB43B5FkfaRgr88xsdE2EBKTS4KEOlOw4EXXym+QAK
MFyu00vGg+jQ0LGS9YT9E0rwK+LNAeGrVYTxRf9hTzzQE1oALNwlESXfvJH0Ntjb
qgciqhQPbAVt2GA+27YCiZQjm7P/0O9sRiXkTTYXRJPtfq1ynJuMyGBLo4ppDYnN
jaZLgfibmj18x8CxZZRotdNEy7Ct8FWdHiX72tynCsxQBP0Whjdn353aSh+G7e4W
LSKnHkeCYfpvtEIhiOb/Z1TfgrwjoW79B8BZ4cASBvrlSvpQT16f41YC6f20ZPEt
7pcTpGpKUhxdMwPgVF2Z4lut39ByPQuBvu0QZ27sCPaVVOGNWAWLkLHHd4bMpy/t
Y3b9VthX5c90+kj5aC7mGn1rzSUIsfmy85uCdVDaBc7XSkXShC8=
=N4T4
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
