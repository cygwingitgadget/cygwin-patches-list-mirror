Return-Path: <cygwin-patches-return-6406-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6566 invoked by alias); 18 Jan 2009 05:49:19 -0000
Received: (qmail 6549 invoked by uid 22791); 18 Jan 2009 05:49:17 -0000
X-SWARE-Spam-Status: No, hits=-1.3 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_92,SARE_MSGID_LONG40,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f11.google.com (HELO mail-ew0-f11.google.com) (209.85.219.11)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 18 Jan 2009 05:49:13 +0000
Received: by ewy4 with SMTP id 4so380973ewy.2         for <cygwin-patches@cygwin.com>; Sat, 17 Jan 2009 21:49:10 -0800 (PST)
Received: by 10.210.11.17 with SMTP id 17mr1600445ebk.113.1232257750645;         Sat, 17 Jan 2009 21:49:10 -0800 (PST)
Received: by 10.210.81.20 with HTTP; Sat, 17 Jan 2009 21:49:10 -0800 (PST)
Message-ID: <2ca21dcc0901172149u761a74b3p54942cdd9417225d@mail.gmail.com>
Date: Sun, 18 Jan 2009 05:49:00 -0000
From: "Dave Korn" <dave.korn.cygwin@googlemail.com>
To: cygwin-patches@cygwin.com, gcc-patches@gcc.gnu.org
Subject: Re: [PATCH/libiberty] Fix PR38903 Cygwin GCC bootstrap failure [was Re: Libiberty issue vs cygwin [was Re: This is a Cygwin failure yeah?]]
In-Reply-To: <20090118050614.GA14669@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ca21dcc0901171652s44c72ca7teb1ca6041344e4a4@mail.gmail.com> 	 <20090118050614.GA14669@ednor.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00004.txt.bz2

[Cc list trimmed]
Christopher Faylor wrote:
> On Sun, Jan 18, 2009 at 12:52:14AM +0000, Dave Korn wrote:
>> I've tested
>> this by doing (separate) native builds of GCC, winsup,
                                                  ^^^^^^ :P see below!

>> GCC is in stage 4, but this is target-specific and fixes a bootstrap
>> failure on a secondary platform.
>>
>> Ok for HEAD of both gcc/ and src/ ?
>>
>> libiberty/ChangeLog
>>
>> * configure.ac (funcs, vars, checkfuncs): Don't munge on Cygwin, as it
>> no longer shares libiberty object files.  * configure: Regenerated.
>
> Just in case you need confirmation:  this looks fine.

  Thanks, I thought it would be the right thing to do.  Just waiting on DJ or
ILT's approval now.

> I removed the dependence on libiberty a while ago partially because,
> AFAICT, it actually subverted Red Hat's claim of owning all source code
> in Cygwin.  You can't really say that if there are pure FSF GPLed or
> LGPLed pieces.

  Yep, I discovered that you removed it from the winsup module definition, I
only "tested" it for a winsup build (as mentioned above) because I had an old
source tree that still had it there by accident of "cvs -dP" not removing
subdirectories that only get changed in the modules list.  In a fresh checkout
there's nothing to test!

    cheers,
      DaveK
