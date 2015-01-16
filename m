Return-Path: <cygwin-patches-return-8046-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5041 invoked by alias); 16 Jan 2015 15:44:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 5026 invoked by uid 89); 16 Jan 2015 15:44:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 16 Jan 2015 15:44:27 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5F0F78E1421; Fri, 16 Jan 2015 16:44:25 +0100 (CET)
Date: Fri, 16 Jan 2015 15:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: tracing malloc/free call
Message-ID: <20150116154425.GG3122@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <54B6EE1F.60705@gmail.com> <20150115093451.GB10242@calimero.vinschen.de> <54B91EFD.80302@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Content-Disposition: inline
In-Reply-To: <54B91EFD.80302@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00001.txt.bz2


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1902

Hi Marco,

On Jan 16 15:23, Marco Atzeri wrote:
> On 1/15/2015 10:34 AM, Corinna Vinschen wrote:
> >Bottom line, you should be able to fetch the original return address by
> >printing the value at
> >
> >   *(void*)_my_tls->stackptr
> >
> >which points to the uppermost entry on the stack.
>=20
> Hi Corinna,
>=20
> in reality I found it is "*(_my_tls.stackptr-1)"

Oh, right!  Sorry about that.  I missed to take the behavior of xadd
into account.

> -  malloc_printf ("(%p), called by %p", p, __builtin_return_address (0));
> +  malloc_printf ("(%p), called by %p", p, *(_my_tls.stackptr-1));
>=20
> Attached patch that allows tracking of original caller,
> for the 4 memory allocation calls.
>=20
> Tested on 64 bit.
>=20
>  $ grep 0x6000D6AA1 ncview.strace4
>    20 1605112 [main] ncview 4408 free: (0x6000D6AA1), called by 0x10040E7=
44
>=20
>=20
>  $ addr2line.exe -a 0x10040E744 -e /usr/bin/ncview.exe
> 0x000000010040e744
> /usr/src/debug/ncview-2.1.4-2/src/file_netcdf.c:271

Thanks for the patch, but it won't work nicely either this way.  The
problem is that, in theory, the code has to differ between internal and
external callers.  Internal callers (that is, Cygwin functions itself)
don't hop into the function via _sigfe/_sigbe.  Thus the output for
internal callers of malloc/free is now wrong with your patch.

The solution for this problem would be a test which checks if the return
address is the _sigbe function and if so, returns *(_my_tls.stackptr-1),
otherwise __builtin_return_address(0).  However, the symbol _sigbe is
not exported since, so far, it was only used inside _sigfe.  This needs
a bit of tweaking.  I'll have a look.

Btw., when sending a patch, a matching ChangeLog entry would be quite
helpful :}


Thanks,
Corinna


--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUuTHZAAoJEPU2Bp2uRE+gHuwP/3PbdQHJf0hADqEQ37h7Eld/
vCRCIqqf+4ihMKrvBMLRyjqqmXZmTVGydYmUr0jLwIpoVPhx2UDXoky8HcALVuk0
dq1X96NWesppVATNHaYIqZhX7FHcRN5wT14HVRoI5+Vtdg0g0F7m9xz3LRAVKchS
SF0G0dRwqUibQeuIWEERcFE6XkP7lo065Wtgjl3ELMviI6he+zCgATuIxZv6q8GM
5Ojfcw47bP94EqNzYxxKbOpRG8r+ZrH6pf45tMnC0YydlRlqdciXLEQS8zW+jxfK
MmI28IuQzUcVNUYyqP8F5AQifFn4vxbNnqOIzBk0OGvvNOyTvees7dksfaiaJp83
XwaJ8SRPX6TY4/sB7a6tJ2wZ+9G4EisqhoOsYdeh8i/oNMl7BlewKf4hat0JjYEc
s7naLtTCIe9ygqK4Lx/PMye9iuZFGIhCfq96FyIekeUWIPwoT/poSkjnJT0wzMm+
ET0kXoXyXydHmsOrs3sId+dJiV15QSEdo7rCMD4UThF0xWqE/o+EQdNEmxII5btR
ZW10DzCKS9kdWxx2oX7CSLU4mAPpjZtNoWOkGz95ZWR41d3lDJdrujR1qOhtBW0c
9t/WMneS6hK9+V4N/iKAl6TwMR5+7XGOj9PA72fOoK1bBkMknpSrBgoDZAGHPi+a
+TO/+yYKpzdugJ1yPgRl
=vZih
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
