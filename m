Return-Path: <cygwin-patches-return-7066-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26894 invoked by alias); 17 Aug 2010 19:23:40 -0000
Received: (qmail 26882 invoked by uid 22791); 17 Aug 2010 19:23:39 -0000
X-SWARE-Spam-Status: No, hits=-50.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mail-vw0-f43.google.com (HELO mail-vw0-f43.google.com) (209.85.212.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 17 Aug 2010 19:23:30 +0000
Received: by vws8 with SMTP id 8so6637696vws.2        for <cygwin-patches@cygwin.com>; Tue, 17 Aug 2010 12:23:29 -0700 (PDT)
Received: by 10.220.171.211 with SMTP id i19mr4394931vcz.112.1282073006973;        Tue, 17 Aug 2010 12:23:26 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [24.76.240.202])        by mx.google.com with ESMTPS id v11sm4455519vbb.14.2010.08.17.12.23.25        (version=SSLv3 cipher=RC4-MD5);        Tue, 17 Aug 2010 12:23:26 -0700 (PDT)
Subject: Re: [PATCHes] Misc aliasing fixes for building DLL with gcc-4.5.0
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <4A7F8FF5.5060701@gmail.com>
References: <4A7F8FF5.5060701@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 17 Aug 2010 19:23:00 -0000
Message-ID: <1282073012.8848.8.camel@YAAKOV04>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00026.txt.bz2

On Mon, 2009-08-10 at 04:11 +0100, Dave Korn wrote:
>   I tried compiling winsup with GCC-4.5.0 HEAD, and it finds a bunch of things
> to complain about (which then break the -Werror build).  They are mostly
> "dereferencing type-punned pointer will break strict-aliasing rules" errors, but
> there is also some possibly-undefined behaviour in passwd.cc (looks like a
> problem with sequence points to me).

Sorry to resurrect such an old thread, but now that Dave released
gcc-4.5, this is no longer theoretical.  Here are the warnings-as-errors
that I get with gcc-4.5.1 with Dave's 4.5.0 patch set:

winsup/cygwin/fhandler_floppy.cc: In member function âint
fhandler_dev_floppy::get_drive_info(hd_geometry*)â:
winsup/cygwin/fhandler_floppy.cc:59:37: error: dereferencing type-punned
pointer will break strict-aliasing rules

winsup/cygwin/fhandler_socket.cc: In function âbool address_in_use(const
sockaddr*)â:
winsup/cygwin/fhandler_socket.cc:918:7: error: dereferencing type-punned
pointer will break strict-aliasing rules
winsup/cygwin/fhandler_socket.cc:918:7: error: dereferencing type-punned
pointer will break strict-aliasing rules

winsup/cygwin/hookapi.cc: In function âvoid* hook_or_detect_cygwin(const
char*, const void*, WORD&)â:
winsup/cygwin/hookapi.cc:255:7: error: âiâ may be used uninitialized in
this function

winsup/cygwin/passwd.cc: In function âpasswd*
internal_getpwsid(cygpsid&)â:
winsup/cygwin/passwd.cc:101:54: error: operation on âpwâ may be
undefined

winsup/cygwin/syscalls.cc: In function âlong int gethostid()â:
winsup/cygwin/syscalls.cc:3711:43: error: dereferencing type-punned
pointer will break strict-aliasing rules
winsup/cygwin/syscalls.cc:3712:49: error: dereferencing type-punned
pointer will break strict-aliasing rules


Yaakov

