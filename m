Return-Path: <cygwin-patches-return-6590-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12021 invoked by alias); 10 Aug 2009 04:15:01 -0000
Received: (qmail 12010 invoked by uid 22791); 10 Aug 2009 04:15:00 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_42,J_CHICKENPOX_63,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f217.google.com (HELO mail-ew0-f217.google.com) (209.85.219.217)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 10 Aug 2009 04:14:54 +0000
Received: by ewy17 with SMTP id 17so2834917ewy.2         for <cygwin-patches@cygwin.com>; Sun, 09 Aug 2009 21:14:51 -0700 (PDT)
Received: by 10.210.80.17 with SMTP id d17mr1676519ebb.67.1249877691447;         Sun, 09 Aug 2009 21:14:51 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm10140928eyb.30.2009.08.09.21.14.50         (version=SSLv3 cipher=RC4-MD5);         Sun, 09 Aug 2009 21:14:50 -0700 (PDT)
Message-ID: <4A7FA1E0.7070209@gmail.com>
Date: Mon, 10 Aug 2009 04:15:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCHes] Misc aliasing fixes for building DLL with gcc-4.5.0
References: <4A7F8FF5.5060701@gmail.com> <20090810040452.GB610@ednor.casa.cgf.cx>
In-Reply-To: <20090810040452.GB610@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q3/txt/msg00044.txt.bz2

Christopher Faylor wrote:
> On Mon, Aug 10, 2009 at 04:11:49AM +0100, Dave Korn wrote:
>> 	* fhandler_tty.cc (process_input): Add dummy return to silence warning.
>> 	(process_ioctl): Likewise.
> 
> Shouldn't these be defined with __attribute__ ((noreturn))?

  They probably should also, but (I forgot to mention) I tried it and it didn't
solve the warning.

>> 	* fork.cc (cygfork): New name with friendable C++ linkage for ...
>> 	(fork): ... un-friendable extern "C" function becomes stub calling it.
>> 	(class frok): Declare cygfork() friend, not fork(), avoiding PR41020.
> 
> Ugh.  I don't like this.  fork is slow enough and complicated enough
> without adding this kind of workaround.  If this is a problem with
> declaring an 'extern "C"' friend function then it should be fixable by
> just making fork() a C++ function but exporting it as a "C" function
> in cygwin.din.

  My turn to say "ugh"!  The wrapper function would translate down to a single
'jmp' if -fno-omit-frame-pointer was in effect, but as things stand it's a bit
ugly.  So maybe we should let both of these rest for a while and see how things
pan out upstream.

> Also, referring to a bug without explaining what the problem either in
> the source code or the ChangeLog is a guaranteed way to cause confusion
> tomorrow after a memory cache refresh.

  You mean the PR notation?  Hopefully GCC's bugzilla will still be there
tomorrow!  Anyway, with a bit of luck we won't end up needing this one at all.

    cheers,
      DaveK
