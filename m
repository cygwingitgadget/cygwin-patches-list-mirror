From: "Gerrit P. Haase" <freeweb@nyckelpiga.de>
To: cygwin-patches@cygwin.com
Cc: cygwin@cygwin.com
Subject: Re: need help to build xerces
Date: Fri, 23 Nov 2001 04:40:00 -0000
Message-ID: <1195690372.20011123133335@nyckelpiga.de>
References: <93127483090.20011113225111@familiehaase.de>
X-SW-Source: 2001-q4/msg00242.html
Content-type: multipart/mixed; boundary="----------=_1583532850-65438-118"
Message-ID: <20011123044000.XlUaToB5mKzo1N_vkKeHXVdRH1CFjTXZheIccl5gCqc@z>

This is a multi-part message in MIME format...

------------=_1583532850-65438-118
Content-length: 1455

Hallo Gerrit,

2001-11-13 23:08:54, du schriebst:

> Hallo Cygwinners,

> I get every sourcefile compiled but one.
> The compiler (g++) doesn't want to build it because of this error:

> In file included from IconvTransService.cpp:68:
> /usr/include/wchar.h:24: syntax error before `('
> make[2]: *** [IconvTransService.o] Error 1

Ahh, I found it, patch is attached.

> The file looks like this:

> /* wchar.h

>    Copyright 1998, 1999, 2000, 2001 Red Hat, Inc.

> This file is part of Cygwin.

> This software is a copyrighted work licensed under the terms of the
> Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
> details. */

> #ifndef _WCHAR_H
> #define _WCHAR_H

> #include <sys/cdefs.h>

> /* Get wchar_t and wint_t from <stddef.h>.  */
> #define __need_wchar_t
> #define __need_wint_t
> #include <stddef.h>

> __BEGIN_DECLS

> int wcscmp (const wchar_t *__s1, const wchar_t *__s2);
> size_t wcslen (const wchar_t *__s1);                    <--------- line 24 is here

> __END_DECLS

> #endif /* _WCHAR_H */


> So what goes wrong here? I don't know.
> Thanks in advance for a hint,

> Gerrit


-- 
convey Information Systems GmbH                   http://www.convey.de/
                                                  VitalisstraÃe 326-328
Gerrit P. Haase                                   D-50933 KÃ¶ln
gerrit.haase@convey.de                            Fon: ++49 221 6903922
Attachment:
wchar.h.patch
Description: Binary data


------------=_1583532850-65438-118
Content-Type: text/x-diff; charset=us-ascii; name="wchar.h.patch"
Content-Disposition: inline; filename="wchar.h.patch"
Content-Transfer-Encoding: base64
Content-Length: 346

LS0tIHdjaGFyLmgub3JpZwlUdWUgTm92IDEzIDIyOjQwOjQzIDIwMDEKKysr
IHdjaGFyLmgJVHVlIE5vdiAxMyAyMzowNTo1NSAyMDAxCkBAIC0xNiw2ICsx
Niw3IEBACiAvKiBHZXQgd2NoYXJfdCBhbmQgd2ludF90IGZyb20gPHN0ZGRl
Zi5oPi4gICovCiAjZGVmaW5lIF9fbmVlZF93Y2hhcl90CiAjZGVmaW5lIF9f
bmVlZF93aW50X3QKKyNkZWZpbmUgX19uZWVkX3NpemVfdAogI2luY2x1ZGUg
PHN0ZGRlZi5oPgogCiBfX0JFR0lOX0RFQ0xTCg==

------------=_1583532850-65438-118--
