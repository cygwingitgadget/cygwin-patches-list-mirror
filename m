Return-Path: <cygwin-patches-return-2021-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27258 invoked by alias); 3 Apr 2002 18:12:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27237 invoked from network); 3 Apr 2002 18:12:07 -0000
Date: Wed, 03 Apr 2002 10:12:00 -0000
To: cygwin-apps@cygwin.com,
    cygwin-patches@cygwin.com
Subject: Re: Patch for Setup.exe problem and for mklink2.cc
Message-Id: <VA.00000b1a.003b4a45@thesoftwaresource.com>
From: Brian Keener <bkeener@thesoftwaresource.com>
Reply-To: bkeener@thesoftwaresource.com
In-Reply-To: <E16qEjA-0007iC-00@smtp2.cistron.nl>
References: <E16qEjA-0007iC-00@smtp2.cistron.nl>
X-SW-Source: 2002-q2/txt/msg00005.txt.bz2

 wrote:
> > As for the &'s, I wonder if it's a w32api reference issue? The compiler
> 
> > complains if they are present for me.
> 
> For me it is the opposite. g++ complains when they are *not*
> 
> present.
>
I believe this might be related to the above discussion so I thought I would 
add this - I updated my cinstall (Setup.exe) node from HEAD in cvs (cvs update 
-rHEAD) on Monday and now when I try to compile on my Win2000 laptop I get the 
following error:

make[2]: Entering directory `/usr/develop/obj/i686-pc-cygwin/winsup/cinstall'
/usr/bin/c++ -L/usr/develop/obj/i686-pc-cygwin/winsup 
-L/usr/develop/obj/i686-pc-cygwin/winsup/cygwin 
-L/usr/develop/obj/i686-pc-cygwin/winsup/w32api/lib -isystem 
/usr/develop/src/winsup/include -isystem /usr/develop/src/winsup/cygwin/include 
-isystem /usr/develop/src/winsup/w32api/include -isystem 
/usr/develop/src/newlib/libc/sys/cygwin -isystem 
/usr/develop/src/newlib/libc/sys/cygwin32 
-B/usr/develop/obj/i686-pc-cygwin/newlib/ -isystem 
/usr/develop/obj/i686-pc-cygwin/newlib/targ-include -isystem 
/usr/develop/src/newlib/libc/include -MMD -g -O2 -mno-cygwin -I. 
-I/usr/develop/src/winsup/cinstall -I/usr/develop/src/winsup/mingw/include  
-I/usr/develop/src/winsup/bz2lib -mwindows -c -o mklink2.o 
/usr/develop/src/winsup/cinstall/mklink2.cc
/usr/develop/src/winsup/cinstall/mklink2.cc: In function `void 
make_link_2(const char *, const char *, const char *, const char *)':
/usr/develop/src/winsup/cinstall/mklink2.cc:24: cannot convert 
`CLSID_ShellLink' from type `const GUID' to type `const CLSID *'
/usr/develop/src/winsup/cinstall/mklink2.cc:25: cannot convert 
`IID_IPersistFile' from type `_GUID' to type `const IID *'
make[2]: *** [mklink2.o] Error 1
make[2]: Leaving directory `/usr/develop/obj/i686-pc-cygwin/winsup/cinstall'
make[1]: *** [cinstall] Error 1
make[1]: Leaving directory `/usr/develop/obj/i686-pc-cygwin/winsup'
make: *** [all-target-winsup] Error 2
~
$ 

I have tried reinstalling the w32api packages for version 1.1-1, 1.2-1 and 
1.2-2 as well as other various packages in an attempt to resolve but still get 
the same error when I compile.  

I see the patch that Ton van Overbeek and I am about to try that - will this 
become a standard patch.


