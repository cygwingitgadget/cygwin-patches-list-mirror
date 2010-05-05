Return-Path: <cygwin-patches-return-7027-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27764 invoked by alias); 5 May 2010 23:28:48 -0000
Received: (qmail 27750 invoked by uid 22791); 5 May 2010 23:28:47 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-ww0-f43.google.com (HELO mail-ww0-f43.google.com) (74.125.82.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 05 May 2010 23:28:36 +0000
Received: by wwi18 with SMTP id 18so1147763wwi.2        for <cygwin-patches@cygwin.com>; Wed, 05 May 2010 16:28:33 -0700 (PDT)
Received: by 10.227.145.197 with SMTP id e5mr3301305wbv.190.1273102113695;        Wed, 05 May 2010 16:28:33 -0700 (PDT)
Received: from [192.168.2.99] (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])        by mx.google.com with ESMTPS id y23sm2389401wby.22.2010.05.05.16.28.30        (version=SSLv3 cipher=RC4-MD5);        Wed, 05 May 2010 16:28:31 -0700 (PDT)
Message-ID: <4BE203AD.4080606@gmail.com>
Date: Wed, 05 May 2010 23:28:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: CFA: pseudo-reloc v2
References: <4AC7910E.1010900@cwilson.fastmail.fm> <4AC82056.7060308@cwilson.fastmail.fm> <4BE1A2C5.4090604@gmail.com> <20100505175614.GA6651@ednor.casa.cgf.cx> <4BE1BFCC.6060703@gmail.com> <20100505191317.GA14692@ednor.casa.cgf.cx> <4BE1CB8C.8020301@gmail.com> <20100505203042.GA15996@ednor.casa.cgf.cx>
In-Reply-To: <20100505203042.GA15996@ednor.casa.cgf.cx>
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
X-SW-Source: 2010-q2/txt/msg00010.txt.bz2

On 05/05/2010 21:30, Christopher Faylor wrote:

> I have something written now.  I'll dig through the cygwin archives to
> see if I can find the original message which started this but are there
> other test cases that I could use to verify that I caught all of the
> code paths in the DLL?

  http://cygwin.com/ml/cygwin/2010-04/msg00957.html comes with a couple of
testcases attached, although you can only be sure they've worked by running
them and seeing that no .stackdump file was generated in your $CWD.

> Chuck?  Do you have anything I could use to test what I did?

  There were some fork-related testcases in the original thread, but I didn't
refer back to them when I was revising this, so they're probably worth verifying:
   http://www.cygwin.com/ml/cygwin-developers/2009-10/msg00052.html

> What I did:
> 
> 1) Move pseudo-reloc.c out of lib and into the dll (making
> it a c++ file in the process).
> 
> 2) Record the three values needed by _pei386_runtime_relocator in the
> per_process structure.

  That bit worries me - even adding a single pointer in a place where there
would never have been a field before caused us enough trouble!  But, it's
probably the right thing to do; it's the defined mechanism for conveying
image-specific information from the module to the cygwin dll.

> 3) Modify _pei386_runtime_relocator() to take a per_process * argument
> and to check that the api of the per_process structure supports the
> additional three values.

  Changing per_process was not as easy as I had hoped when I did it!

> 4) For fork call _pei386_runtime_relocator() before the copy of the program's
> data/bss in child_info_fork::handle_fork().
> 
> 5) For non-fork, call _pei386_runtime_relocator() in dll_crt0_1().
> 
> 6) For dll's, call _pei386_runtime_relocator() in dll_list::alloc().

  Re-ordering startup is the thing I didn't want to approach.  The separation,
serialisation and ordering between process attach and first thread attach is
probably as reliable as anything we could hope for though.

> I haven't added any optimizations to make this implementation avoid
> copying the data/bss but that is doable using Dave's technique.  It
> just isn't needed now since the fork data copy should always trump
> _pei386_runtime_relocator().

  Well, as long as it works it must make sense; it's just a matter of which we
figure is more long-term reliable and maintainable: your approach depends on
inferences about which things happen in which order during startup, mine
depends on inferences about which sections of the EI get copied from the
parent during a fork.  So, this post is a commentary, rather than an objection.

    cheers,
      DaveK
