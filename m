Return-Path: <cygwin-patches-return-8817-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20665 invoked by alias); 7 Aug 2017 09:31:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 20635 invoked by uid 89); 7 Aug 2017 09:31:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, H*c:application
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 07 Aug 2017 09:31:03 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 9EE00721E281A	for <cygwin-patches@cygwin.com>; Mon,  7 Aug 2017 11:31:00 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 049CF5E041E	for <cygwin-patches@cygwin.com>; Mon,  7 Aug 2017 11:31:00 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DAFDCA8056F; Mon,  7 Aug 2017 11:30:59 +0200 (CEST)
Date: Fri, 18 Aug 2017 13:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Define sigsetjmp/siglongjmp only if __POSIX_VISIBLE
Message-ID: <20170807093059.GR25551@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <def00c5d-15d9-237e-8579-371eebdfc5fe@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="j/HO4hzKTNbM1mOX"
Content-Disposition: inline
In-Reply-To: <def00c5d-15d9-237e-8579-371eebdfc5fe@cornell.edu>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00019.txt.bz2


--j/HO4hzKTNbM1mOX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 618

Hey Ken

On Aug  6 17:46, Ken Brown wrote:
> The attached patch fixes the issue reported here:
>=20
>   https://cygwin.com/ml/cygwin/2017-08/msg00060.html
>=20
> I'm not sure if I was correct in including RTEMS or if this should have b=
een
> Cygwin only.  If the former, I probably should have sent this to the Newl=
ib
> list.

thanks for the patch, but you should really send it to the newlib list,
especially given that not only Cygwin is affected.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--j/HO4hzKTNbM1mOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZiDNTAAoJEPU2Bp2uRE+gHy8P/0Wa+2h2qDpwoBnNemCRSP4Z
FYS7yZ0NP3inr87ww7dtZESyz92r+3w0YzWVuUTz7xuLWqgmRjcGwiZPbcN3EjRk
3ZGe3FUeF41HuLezZEjL7etkwsYE1N5ZrzrTEmGLyEx1VI2FIcMFYz88JLEZfUzH
9fJPZS9FdwCXV+XZWKP+Ds5W8RdJ+hBJBU9GaFnLI2qQXT5IevzZe/TJfQPovbMp
IImyTXz5ccgt1NVGhjmyJrdxF8fNwiZj3uNS5kPyBU410JhA9WxrNIfWyy3u5ulF
WeIc7wGaAYFy31Dc1SURnsI+dbQBcNTtAcE9B3GHDkNRp4CKwdASXP00pFIDPH7n
LXkGcYdpFqaDdS70heRxJC5I1iCWAleF63143HKexiMuKkeg3EuKsmpFvkTbCUhv
/V/Wv0R1x4TchgHpCLltP+uAV1cq2qpKiJiwJaDs4EOA4PTo2AcSjBQDmqB0NbOz
CWHDc3PEOeq6BcncLUko2gsZ/WmYdDHvcyVEzrRn42NvIEGq6IOD0yaVK4IBVZYk
P1G+ITG3NOuOyJTNgHO2Ho/UdlaM9RqlqD3Cp6Y2ms0FFD6chlLun/DIbHvsb1L7
WrH4BXEjWdELRMB+X9wUHRDJe1Um3x6jTpYzKja8TVWyRDbczf8AjCTTOe/t0L8b
Lz015jbJb/A4RBCNcdep
=RmDl
-----END PGP SIGNATURE-----

--j/HO4hzKTNbM1mOX--
