Return-Path: <cygwin-patches-return-8208-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47817 invoked by alias); 22 Jun 2015 15:14:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47802 invoked by uid 89); 22 Jun 2015 15:14:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.1 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Jun 2015 15:14:22 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E099DA8094D; Mon, 22 Jun 2015 17:14:19 +0200 (CEST)
Date: Mon, 22 Jun 2015 15:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/5] winsup/doc: Add intro man pages from cygwin-doc
Message-ID: <20150622151419.GI28301@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434983976-3612-1-git-send-email-jon.turney@dronecode.org.uk> <1434983976-3612-3-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <1434983976-3612-3-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00109.txt.bz2


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 5078

A few nits:

[intro.1]
> +      <para><emphasis>Cygwin</emphasis> is a Linux-like environment for
> +      Windows. It consists of two parts:</para>
> +      <para>A DLL (<filename>cygwin1.dll</filename>) which acts as a Lin=
ux API

s#Linux#POSIX#

> +      emulation layer providing substantial Linux API functionality. The

s#Linux API functionality#POSIX API functionality modeled after the GNU/Lin=
ux operating system#

> +      <citerefentry><refentrytitle>intro</refentrytitle><manvolnum>3</ma=
nvolnum></citerefentry>
> +      man page gives an introduction to this API.</para>
> +      <para>A collection of tools which provide Linux look and feel.  Th=
is man
> +      page describes the user environment.</para>
> +    </refsect1>
> +    <refsect1>
> +      <title>AVAILABILITY</title>
> +      <para><emphasis>Cygwin</emphasis> is developed by volunteers colla=
borating
> +      over the Internet. It is distributed through the website <ulink
> +      url=3D"http://cygwin.com">http://cygwin.com</ulink>, where you can=
 find
> +      extensive documentation, including FAQ, User's Guide, and API
> +      Reference. The <emphasis>Cygwin</emphasis> website should be consi=
dered
> +      the authoritative source of information. The source code, released=
 under
> +      the <emphasis>GNU General Public License, Version 2</emphasis>, is=
 also

s#Version 2#Version 3 (GPLv3+)#

[intro.3]
> +      <para><emphasis>Cygwin</emphasis> is a Linux-like environment for
> +      Windows. It consists of two parts:</para>
> +      <para>A DLL (<filename>cygwin1.dll</filename>) which acts as a Lin=
ux API

s#Linux#POSIX#

> +      emulation layer providing substantial Linux API functionality.  Th=
is page

s#Linux API functionality#POSIX API functionality modeled after the
GNU/Linux operating system#

> +      describes the API provided by the DLL.
> +      </para>
> +      <para>A collection of tools which provide Linux look and feel.  Th=
is
> +      environment is described in the
> +      <citerefentry><refentrytitle>intro</refentrytitle><manvolnum>1</ma=
nvolnum></citerefentry>
> +      man page.</para>
> +    </refsect1>
> +    <refsect1>
> +      <title>AVAILABILITY</title>
> +      <para><emphasis>Cygwin</emphasis> is developed by volunteers colla=
borating
> +      over the Internet. It is distributed through the website <ulink
> +      url=3D"http://cygwin.com">http://cygwin.com</ulink>. The website h=
as
> +      extensive documentation, including FAQ, User's Guide, and API
> +      Reference. It should be considered the authoritative source of
> +      information. The source code, released under the <emphasis>GNU Gen=
eral
> +      Public License, Version 2</emphasis>, is also available from the w=
ebsite

s#Version 2#Version 3 (GPLv3+)#

> +      or one of the mirrors.</para>
> +    </refsect1>
> +    <refsect1>
> +      <title>COMPATIBILITY</title>
> +      <para><emphasis>Cygwin</emphasis> policy is to attempt to adhere to
> +      <emphasis>POSIX/SUSv2</emphasis> (Portable Operating System Interf=
ace for

s#POSIX/SUSv2#POSIX.1-2008/SUSv4#

> +      UNIX / The Single UNIX Specification, Version 2) where possible.</=
para>

s#Version 2#Version 4#

> +      <para><emphasis>SUSv2</emphasis> is available online at:</para>

s#SUSv2#POSIX.1-2008/SUSv4#

> +      <para>
> +	<ulink url=3D"http://www.opengroup.org/onlinepubs/007908799/">http://ww=
w.opengroup.org/onlinepubs/007908799/</ulink>

http://pubs.opengroup.org/onlinepubs/9699919799/

> +      <para>Keep in mind that there are many underlying differences betw=
een UNIX
> +      and Win32 (for example, a case-insensitive file system), making co=
mplete
> +      compatibility an ongoing challenge.</para>

Is "case-insensitive file system" a good example?  For one thing, NTFS
is a case-sensitive filesystem, and only the Win32 API and the default
NT kernel setting in the registry enforces case-insensitivity.  See
https://cygwin.com/cygwin-ug-net/using-specialnames.html#pathnames-casesens=
itive

What about the OS consequently using UTF-16 as an example?

> +    </refsect1>
> +    <refsect1>
> +      <title>REPORTING BUGS</title>
> +      <para>If you find a bug in <emphasis>Cygwin</emphasis>, please rea=
d</para>
> +      <para>
> +	<ulink url=3D"http://cygwin.com/bugs.html">http://cygwin.com/bugs.html<=
/ulink>
> +      </para>
> +      <para>and follow the instructions for reporting found there.  If y=
ou are
> +      able to track down the source of the bug and can provide a fix, th=
ere are
> +      instructions for contributing patches at:</para>
> +      <para>
> +	<ulink url=3D"http://cygwin.com/contrib.html">http://cygwin.com/contrib=
.html</ulink>
> +      </para>
> +    </refsect1>
> +    <refsect1>
> +      <title>SEE ALSO</title>
> +      <para>
> +	<citerefentry>
> +	  <refentrytitle>intro</refentrytitle>
> +	  <manvolnum>1</manvolnum>

Shouldn't that be a 3 here?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJViCZLAAoJEPU2Bp2uRE+gSs4P/jxhGm47hzVsql+Z0SpCqRDS
QR0WcluElViwZiNJjphkEV46mrZGdp3L5jsQJzICcUeKV3l9cQp6DUPEtIGjyeBT
tItGBOUkqgL2T3hT2Mi3ZScdx96sPdz+/hZP/Ppx/gsbvM0JhPo/WznEi3IAuse8
//jiMjBE6z+dKYaycD7Uv7isAhI/S8pUafqbPZLgBr6r0UAGW7+EtNdTB3OwBYp7
LIOBObzwh9cBfh9Cj0UrPkVM1OAmMMJlDNkx1AsnbMkxIoPV6Fzf2rzBSljtRSxB
T7fyC6QobmvKT5GZ5KTotUf2E4gHO2u5ribJ6eetqP5X78hfLDFb2dalRSFCo5gu
A85XieQGGDbHw0D6/DQNH44d2buEiNUvOwYJYaclDpztlDgx4V6+oMXXF7W6004G
LEW+ThpHnNAa0m80L3QQHsaAFxetJIKfeY9ufErHk/Kbm7NazDfZ2i0xhXLj2J+H
kHmv4at9MzhgrMYdkENhlExt2+iEXA7Uf1Q/P79BD+kEO0hqOHteTnpJ/H0Pt5ko
oGFL8n8EuD4Paja9FTDNoJwHit/STshLODzvzG+o90gebbh+nnen/eWr/OvkdaY6
zFT6GlI0hKL0Fz5/ZlbScIhVu/EixTaYR3vWaC1TUTc1dLPp9X/lvWa4rwztNi3C
iGTq9oG+avGEgvtV6L61
=GBpr
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
