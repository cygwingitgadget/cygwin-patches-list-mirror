Return-Path: <cygwin-patches-return-1514-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 19706 invoked by alias); 23 Nov 2001 12:40:19 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 19655 invoked from network); 23 Nov 2001 12:40:16 -0000
Date: Mon, 15 Oct 2001 19:12:00 -0000
From: "Gerrit P. Haase" <freeweb@nyckelpiga.de>
X-Mailer: The Bat! (v1.53t) Business
Reply-To: "Gerrit P. Haase" <freeweb@nyckelpiga.de>
Organization: don't eat dead animals
X-Priority: 3 (Normal)
Message-ID: <1195690372.20011123133335@nyckelpiga.de>
To: cygwin-patches@cygwin.com
CC: cygwin@cygwin.com
Subject: Re: need help to build xerces
In-Reply-To: <93127483090.20011113225111@familiehaase.de>
References: <93127483090.20011113225111@familiehaase.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------AE1BF251FE7BAB0"
X-SW-Source: 2001-q4/txt/msg00046.txt.bz2

------------AE1BF251FE7BAB0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Content-length: 1400

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
                                                  Vitalisstraße 326-328
Gerrit P. Haase                                   D-50933 Köln
gerrit.haase@convey.de                            Fon: ++49 221 6903922
------------AE1BF251FE7BAB0
Content-Type: application/octet-stream; name="wchar.h.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="wchar.h.patch"
Content-length: 346

LS0tIHdjaGFyLmgub3JpZwlUdWUgTm92IDEzIDIyOjQwOjQzIDIwMDEKKysr
IHdjaGFyLmgJVHVlIE5vdiAxMyAyMzowNTo1NSAyMDAxCkBAIC0xNiw2ICsx
Niw3IEBACiAvKiBHZXQgd2NoYXJfdCBhbmQgd2ludF90IGZyb20gPHN0ZGRl
Zi5oPi4gICovCiAjZGVmaW5lIF9fbmVlZF93Y2hhcl90CiAjZGVmaW5lIF9f
bmVlZF93aW50X3QKKyNkZWZpbmUgX19uZWVkX3NpemVfdAogI2luY2x1ZGUg
PHN0ZGRlZi5oPgogCiBfX0JFR0lOX0RFQ0xTCg==

------------AE1BF251FE7BAB0--
