Return-Path: <cygwin-patches-return-8177-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29898 invoked by alias); 16 Jun 2015 17:45:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29868 invoked by uid 89); 16 Jun 2015 17:45:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jun 2015 17:45:53 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 821FAA807DA; Tue, 16 Jun 2015 19:45:51 +0200 (CEST)
Date: Tue, 16 Jun 2015 17:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Hide sethostname() in unistd.h
Message-ID: <20150616174551.GF31537@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <55804E7D.3060504@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="p11K2BJEgMZL61bg"
Content-Disposition: inline
In-Reply-To: <55804E7D.3060504@t-online.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00078.txt.bz2


--p11K2BJEgMZL61bg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1585

On Jun 16 18:27, Christian Franke wrote:
> Found during an experimental build of busybox:
>=20
> The sethostname() prototype in /usr/include/sys/unistd.h is enabled also =
on
> Cygwin.
> It should be disabled because Cygwin does not provide this function.
>=20
> Christian
>=20

> 2015-06-16  Christian Franke  <franke@computer.org>
>=20
> 	* libc/include/sys/unistd.h (sethostname): Hide prototype on Cygwin.
>=20
> diff --git a/newlib/libc/include/sys/unistd.h b/newlib/libc/include/sys/u=
nistd.h
> index eb26921..6131b5c 100644
> --- a/newlib/libc/include/sys/unistd.h
> +++ b/newlib/libc/include/sys/unistd.h
> @@ -169,7 +169,7 @@ int     _EXFUN(setgid, (gid_t __gid ));
>  #if defined(__CYGWIN__)
>  int	_EXFUN(setgroups, (int ngroups, const gid_t *grouplist ));
>  #endif
> -#if __BSD_VISIBLE || (defined(_XOPEN_SOURCE) && __XSI_VISIBLE < 500)
> +#if !defined(__CYGWIN__) && (__BSD_VISIBLE || (defined(_XOPEN_SOURCE) &&=
 __XSI_VISIBLE < 500))
>  int	_EXFUN(sethostname, (const char *, size_t));
>  #endif
>  int     _EXFUN(setpgid, (pid_t __pid, pid_t __pgid ));

What about implementing sethostname instead?

  extern "C" int
  sethostname (const char *name, size_t len)
  {
    WCHAR wname[MAX_COMPUTERNAME_LENGTH + 1];

    sys_mbstowcs (wname, MAX_COMPUTERNAME_LENGTH + 1, name, len);
    if (!SetComputerNameEx (ComputerNamePhysicalDnsHostname, wname))
      {
	__seterrno ();
	return -1;
      }
    return 0;
  }


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--p11K2BJEgMZL61bg
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgGDPAAoJEPU2Bp2uRE+geswQAImwpHPUdj7CIS8bQbpE02fq
vvNfq3tgpJ/gcPtDbemlSNXdgxho9Oh7xsdXjShbFsIQM8Yoq1qAwthQptR4gf/e
mlEN1VryILFGjaG/obi4etQbpSEBZW6JOxXMv3nCX9INemiUYbUox3dNyYbJFz6q
KOUF7U5huvar6naJa5FZ+pzta0mxi6tzL6GuevGP6JJTifLGXPs44g4ZrZGOK6Dl
KAng61jgD155QztP2e1s1NU3SOostCNLMj3950sfYXUNmQ7dSjE8yXph1dNHYToP
mRbOgVv8oFDlowz89xUjcHvOJY8+Em5nfIHdbWgRgQ7Xea7KZISHXPJf98ZwFJVa
jwjOBZ9Aaj8Gaqwu3jYPeugp4MS1aCOYJSu3WdFNoHNfKVQzm6OZH0nzqexLYh5+
35doSdxH7C96DiDPExQTIzduwbgSkKWiDheAJtCZvC2oNvJvfgvzXZ5TNdMYaijW
kYxeGpPgAol6SFoWs96RWO761E+weWPX6vh2eYXyV3cWx5vYflI3+n0WoeF/3HaJ
VTvnohLwUvUSSGILjh5ZWZTJ9/+wsbBnujrblq+iZ/CMmyQ+bSRpjHjZDYeMAYe+
mqd19JDjhIgkf0wSGVF1KE7wYg80bKKDmdfVIhCEIIjx7IpBYXVNdGm7Ut9aH+gU
0PWNKbjHUHgcNWTsCcs5
=y0mF
-----END PGP SIGNATURE-----

--p11K2BJEgMZL61bg--
