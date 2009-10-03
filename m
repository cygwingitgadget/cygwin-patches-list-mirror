Return-Path: <cygwin-patches-return-6672-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30665 invoked by alias); 3 Oct 2009 12:49:21 -0000
Received: (qmail 30653 invoked by uid 22791); 3 Oct 2009 12:49:21 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f218.google.com (HELO mail-ew0-f218.google.com) (209.85.219.218)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 03 Oct 2009 12:49:17 +0000
Received: by ewy18 with SMTP id 18so1897503ewy.43         for <cygwin-patches@cygwin.com>; Sat, 03 Oct 2009 05:49:14 -0700 (PDT)
Received: by 10.210.160.10 with SMTP id i10mr920030ebe.10.1254574154461;         Sat, 03 Oct 2009 05:49:14 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 10sm43577eyz.10.2009.10.03.05.49.12         (version=SSLv3 cipher=RC4-MD5);         Sat, 03 Oct 2009 05:49:13 -0700 (PDT)
Message-ID: <4AC74BB5.9060503@gmail.com>
Date: Sat, 03 Oct 2009 12:49:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Update build flags for new compiler feature
References: <4AC66C72.7070102@gmail.com> <20091002221933.GB12372@ednor.casa.cgf.cx> <20091003120854.GA22019@calimero.vinschen.de>
In-Reply-To: <20091003120854.GA22019@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00003.txt.bz2

Corinna Vinschen wrote:

> I just built a gcc 4.3.4 Linux->Cygwin cross compiler using the sources
> from the Cygwin 1.7 distro.  I used the following build flags:
> 
>   --disable-bootstrap --enable-version-specific-runtime-libs \
>   --enable-static --enable-shared --enable-shared-libgcc \
>   --disable-__cxa_atexit --with-gnu-ld --with-gnu-as --with-dwarf2 \
>   --disable-sjlj-exceptions --enable-languages=c,c++ --disable-symvers \
>   --enable-threads=posix --with-arch=i686 --with-tune=generic \
>   --with-newlib
    ^^^^^^^^^^^^^^

  Are you doing something tricky w.r.t. the headers and libs you supply to the
build process?  You appear to be using none-at-all out of --with-headers,
--with-includes and --with-sysroot.

> When I try to build Cygwin I get:
> 
>   cc1plus: error: command line option '-muse-libstdc-wrappers' is not
>   supported by this configuration
> 
> What am I doing wrong?

  Take a look in $objdir/gcc/config.log; what happened during the "checking
for __wrap__Znaj" test?  Hmmmmm, I may have the config set up wrong so it only
works in bootstrap, not crossbuilds.  You could try manually hacking
"-DUSE_CYGWIN_LIBSTDCXX_WRAPPERS=1" into the CFLAGS.  Meanwhile, I need to go
figure out how to make sure and check the target rather than host libraries
for the presence of a function.  (It's worth adding fixing this to the to-do
list for -2).

    cheers,
      DaveK
