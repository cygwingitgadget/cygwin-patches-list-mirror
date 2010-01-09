Return-Path: <cygwin-patches-return-6894-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25354 invoked by alias); 9 Jan 2010 20:22:34 -0000
Received: (qmail 25341 invoked by uid 22791); 9 Jan 2010 20:22:33 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from ey-out-1920.google.com (HELO ey-out-1920.google.com) (74.125.78.145)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 09 Jan 2010 20:22:29 +0000
Received: by ey-out-1920.google.com with SMTP id 5so16658889eyb.14         for <cygwin-patches@cygwin.com>; Sat, 09 Jan 2010 12:22:27 -0800 (PST)
Received: by 10.213.107.16 with SMTP id z16mr21410924ebo.47.1263068547081;         Sat, 09 Jan 2010 12:22:27 -0800 (PST)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 24sm8189348eyx.6.2010.01.09.12.22.25         (version=SSLv3 cipher=RC4-MD5);         Sat, 09 Jan 2010 12:22:26 -0800 (PST)
Message-ID: <4B48E972.1020200@gmail.com>
Date: Sat, 09 Jan 2010 20:22:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix multifarious bad pinfo accesses [was Re: Expect   goes  crazy... spinning cpu in kill_pgrp]
References: <4B4868EF.8010301@gmail.com> <20100109163714.GA12815@ednor.casa.cgf.cx>
In-Reply-To: <20100109163714.GA12815@ednor.casa.cgf.cx>
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
X-SW-Source: 2010-q1/txt/msg00010.txt.bz2

Christopher Faylor wrote:

> These abbreviated records are not supposed to be accessed for things
> like "ctty" since it could be irrelevant.  If something is attempting to
> access the ctty then it is wrong and that's what needs to be fixed.
> 
> One of the reasons for keeping an abbreviated structure is to catch
> situations like this, in fact.

  :) Well, it sure works for that.... 100% cpu tends to get my attention!

> True, but you still have a problem if you're accessing a pinfo structure
> which is referencing a soon-to-be-execed process.  You could be sending
> signals to it or attempting to otherwise manipulate it.

  Yeh.  *If* I understand what's happening here, we're tracking down all the
processes in a pgrp by the fact that they all live under the same master tty
in order to kill them.  I'm not really au fait with the unix tty stuff, but I
guess it's possible the child could have detached and the value cached in the
stub would be stale, relative to the changed value in the full pinfo in the
real child process?

> But you'd still be accessing ctty incorrectly.

  Would the /really/ correct thing in kill_pgrp be to ignore this pinfo and
just let it carry on looping, processing real pinfos only?

> I'd prefer something like this:
> 
> --- pinfo.cc    18 Dec 2009 20:32:04 -0000      1.258
> +++ pinfo.cc    9 Jan 2010 16:35:47 -0000
> @@ -416,7 +416,7 @@
>  bool __stdcall
>  _pinfo::exists ()
>  {
> -  return this && !(process_state & PID_EXITED);
> +  return this && !(process_state & (PID_EXITED | PID_EXECED));
>  }
> 
>  bool
> 
> That says that an execed "pinfo" doesn't really exist if it has been
> execed.  If that causes a few problems to be fixed up, that's ok.  I'd
> rather fix those than lie about the ctty of a nonexistent process.

  Yeah, but it's got a TOCTOU race doesn't it?  We'd need to wrap a lock or
critical section around every call to exists() and the subsequent accesses to
_pinfo members.  If not, how come?

    cheers,
      DaveK
