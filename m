Return-Path: <cygwin-patches-return-2080-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6079 invoked by alias); 19 Apr 2002 00:20:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6038 invoked from network); 19 Apr 2002 00:20:06 -0000
Message-ID: <013401c1e737$e9d78e00$2000a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: "Robert Collins" <robert.collins@itdomain.com.au>,
	<cygwin-patches@cygwin.com>
References: <FC169E059D1A0442A04C40F86D9BA7600C5E68@itdomain003.itdomain.net.au>
Subject: Re: [PATCH]setup.exe mklink2.cc some function arguments need to be pointers
Date: Thu, 18 Apr 2002 17:20:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00064.txt.bz2

From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>; <cygwin-patches@cygwin.com>
Sent: Thursday, April 18, 2002 14:59
Subject: RE: [PATCH]setup.exe mklink2.cc some function arguments need to be
pointers


> Update your win32api - And it should not need the patch,

I ran a complete CVS update for the Cygwin source, deleted all .o, .a, and
.d files in the obj/ tree, and ran configure for the entire tree just before
I attempted to make everything including setup.exe.  The only compile that
fails is mklink2.cc.

Both functions in mklink2.cc are extern "C" so the automatic referencing
done by C++ to function call parameters doesn't occur.

# first make attempt:
c++ -L/cygwin-build/obj/i686-pc-cygwin/winsup -L/cygwin-build/obj/i686-pc-cy
gwin/winsup/cygwin -L/cygwin-build/obj/i686-pc-cygwin/winsup/w32api/lib -isy
stem /cygwin-build/src/winsup/include -isystem
/cygwin-build/src/winsup/cygwin/include -isystem
/cygwin-build/src/winsup/w32api/include -isystem
/cygwin-build/src/newlib/libc/sys/cygwin -isystem
/cygwin-build/src/newlib/libc/sys/cygwin32 -B/cygwin-build/obj/i686-pc-cygwi
n/newlib/ -isystem
/cygwin-build/obj/i686-pc-cygwin/newlib/targ-include -isystem
/cygwin-build/src/newlib/libc/include -MMD -g -O2 -mno-cygwin -I. -I/cygwin-
build/src/winsup/cinstall -I/cygwin-build/src/winsup/mingw/include  -I/cygwi
n-build/src/winsup/bz2lib -mwindows -c -o mklink2.o
/cygwin-build/src/winsup/cinstall/mklink2.cc

/cygwin-build/src/winsup/cinstall/mklink2.cc: In function `void
make_link_2(const char *, const char *, const char *, const char *)':
/cygwin-build/src/winsup/cinstall/mklink2.cc:24: cannot convert
`CLSID_ShellLink' from type `const GUID' to type `const CLSID *'
/cygwin-build/src/winsup/cinstall/mklink2.cc:25: cannot convert
`IID_IPersistFile' from type `_GUID' to type `const IID *'

# second make attempt after first two arguments &ed
c++ -L/cygwin-build/obj/i686-pc-cygwin/winsup -L/cygwin-build/obj/i686-pc-cy
gwin/winsup/cygwin -L/cygwin-build/obj/i686-pc-cygwin/winsup/w32api/lib -isy
stem /cygwin-build/src/winsup/include -isystem
/cygwin-build/src/winsup/cygwin/include -isystem
/cygwin-build/src/winsup/w32api/include -isystem
/cygwin-build/src/newlib/libc/sys/cygwin -isystem
/cygwin-build/src/newlib/libc/sys/cygwin32 -B/cygwin-build/obj/i686-pc-cygwi
n/newlib/ -isystem
/cygwin-build/obj/i686-pc-cygwin/newlib/targ-include -isystem
/cygwin-build/src/newlib/libc/include -MMD -g -O2 -mno-cygwin -I. -I/cygwin-
build/src/winsup/cinstall -I/cygwin-build/src/winsup/mingw/include  -I/cygwi
n-build/src/winsup/bz2lib -mwindows -c -o mklink2.o
/cygwin-build/src/winsup/cinstall/mklink2.cc

/cygwin-build/src/winsup/cinstall/mklink2.cc: In function `void
make_link_2(const char *, const char *, const char *, const char *)':
/cygwin-build/src/winsup/cinstall/mklink2.cc:24: cannot convert
`IID_IShellLinkA' from type `const GUID' to type `const IID *'

--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.html
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

