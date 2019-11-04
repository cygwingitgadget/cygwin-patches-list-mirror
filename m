Return-Path: <cygwin-patches-return-9800-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24396 invoked by alias); 4 Nov 2019 09:28:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 24381 invoked by uid 89); 4 Nov 2019 09:28:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Gratz, gratz, H*F:D*cygwin.com, device
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 04 Nov 2019 09:28:31 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MYNW6-1iVJt90r2Y-00VQEd for <cygwin-patches@cygwin.com>; Mon, 04 Nov 2019 10:28:29 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6B167A80A60; Mon,  4 Nov 2019 10:28:28 +0100 (CET)
Date: Mon, 04 Nov 2019 09:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Provide more COM devices
Message-ID: <20191104092828.GJ3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <87mudvwnrl.fsf@Rainer.invalid> <20191021081844.GH16240@calimero.vinschen.de> <87pniq7yvm.fsf@Rainer.invalid> <20191022071622.GM16240@calimero.vinschen.de> <87sgn4ai3n.fsf@Rainer.invalid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="3yNHWXBV/QO9xKNm"
Content-Disposition: inline
In-Reply-To: <87sgn4ai3n.fsf@Rainer.invalid>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00071.txt.bz2


--3yNHWXBV/QO9xKNm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1270

On Nov  3 20:13, Achim Gratz wrote:
> Corinna Vinschen writes:
> [=E2=80=A6]
> > ttyS%(0-255) takes another 23K btw.  Even that should be ok, if
> > the need arises.  Alternatively we could shortcut shilka as for
> > /dev/sd*, but that involved much bigger numbers.
>=20
> I've searched for some documentation (anywhere the glob syntax %(1-128)
> would turn up, btw?) and I think Cygwin is misusing shilka a bit here.
> It's a keyword scanner, so the arithmetically coded parts of the device
> shouldn't be targeted at all.  Instead, only the device path prefix
> should be searched via the shilka lexer and the rest of the conversion
> done in code.

Sure, fine with me.

> For the disks we might keep the globbing that gets us the
> device major part.  That of course means we construct more devices
> on-the-fly (or even all of them) and have a much smaller table of static
> device entries

I don't think so.  We already construct the numbered devices on the
fly, see fhandler_dev::readdir() and the `exists' test in there,
which translates into on of the exists_* tests in devices.in.

> (which get searched linearly, so in the end that should
> be a net speed improvement).

That in turn would be great.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl2/7zwACgkQ9TYGna5E
T6Bt9RAAhlHNn9rtqrADWRKBHxQkve+/EdSb0j0X3Ib0LdYTQ9E5035luC0x205u
S9Hy/rc/ZPk0DxkCgjBWpd/ItX/wchOYbZ1Up4MLHQ51qh9fWVawnf6yxgr6zoMt
rm3aetpcfrNOzMI02HfqYFX23hk24mO1Go/HRZ/YE5QAIfb+0g+6Ws9blj9VTyp6
OyyYAeGM3RAs2odq9R9VHMbqj/Kr+ce/3cG35s/pAFro7polKtxR+IsAHwSKNeMh
R0qLMgdtU1aFsbzjoNBJLn+K4rR4CQniwlYvE+9g7K00u6a7S+mikPSSNH+E5YTS
2NyjjG2as8N3x+Iup0kLE2Ok4nRw83udEvnt2jldVZiPlNqMVxZGURHtJEBMdq9W
9Zob8oKJc7lsql0IpN4ystzEXQj8AdsbxZRyBF0Y4cIF19KSxlUuAIGNs0MGRQdv
UoVOeHK4jerbb/fsVHn5jhzrjVTYuPpVFpmzoj56nHeT5RFkLZz3KHdLpcRCSzi3
Rds4yKVN8ExO71BA56u2edPc0oxYBpjCSiir7SZar2hDC6ZUPE5XiMIBhzC0e3bG
Tq9I62Owh4Bgq9kC/am/Z57bntmAd7CSPRj4RKjXBCcMEE42nzwp6Q+1gONWuuTi
WXckMWENJSpLHjW3HAPP/6BXmYJ3c8n5HfeFRONhaTbxTtgwo00=
=cUnL
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--
