Return-Path: <cygwin-patches-return-6249-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11033 invoked by alias); 22 Feb 2008 05:18:23 -0000
Received: (qmail 11010 invoked by uid 22791); 22 Feb 2008 05:18:21 -0000
X-Spam-Check-By: sourceware.org
Received: from wf-out-1314.google.com (HELO wf-out-1314.google.com) (209.85.200.168)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 22 Feb 2008 05:17:58 +0000
Received: by wf-out-1314.google.com with SMTP id 28so252636wff.20         for <cygwin-patches@cygwin.com>; Thu, 21 Feb 2008 21:17:56 -0800 (PST)
Received: by 10.143.157.10 with SMTP id j10mr8330723wfo.229.1203657475718;         Thu, 21 Feb 2008 21:17:55 -0800 (PST)
Received: by 10.142.125.4 with HTTP; Thu, 21 Feb 2008 21:17:55 -0800 (PST)
Message-ID: <674fdff20802212117k1936a3bcrb79175546d973ce3@mail.gmail.com>
Date: Fri, 22 Feb 2008 05:18:00 -0000
From: "Noel Burton-Krahn" <noel@burton-krahn.com>
To: cygwin-patches@cygwin.com
Subject: Re: PATCH: avoid system shared memory version mismatch detected by versioning shared memory name
In-Reply-To: <20080222050020.GA17196@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <674fdff20802211641p19f7b3a1pb3f843ba262dfde6@mail.gmail.com> 	 <674fdff20802211701u1a866d2fw2bb21047ecc5e8ea@mail.gmail.com> 	 <20080222050020.GA17196@ednor.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00023.txt.bz2

The problem is there are several installable apps built on Cygwin,
like EAC, ClamAV, and one I just found which is a
Cygwin-on-a-thumbdrive.  The problem is they can't all coexist because
they're distributed with different versions of the cygwin dlls.
Making them work with the current cygwin means hand-copying cygwin
dlls into application directories, and repeating that every time you
upgrade. People used to give Windows a hard time for DLL hell!  I
don't see the benefit of forcing users to hand-maintain cygwin dlls
across multiple applications.

~Noel



On 2/21/08, Christopher Faylor
<cgf-use-the-mailinglist-please@cygwin.com> wrote:
> On Thu, Feb 21, 2008 at 05:01:20PM -0800, Noel Burton-Krahn wrote:
>  >This is a patch to avoid the "system shared memory version mismatch
>  >detected" problem when two applications use different versions of
>  >Cygwin.  My solution is to append the Cygwin version number to the
>  >name of the shared memory segment, so only Cygwin with the same
>  >version share a memory space.
>  >
>  >ChangeLog
>  >2008-02-21  Noel Burton-Krahn  <noel@burton-krahn.com>
>  >
>  >    * shared.cc (shared_name): always add USER_VERSION_MAGIC to the
>  >    shared memory space name so multiple versions of Cygwin keep their
>  >     own shared memory space.  No more "system shared memory version
>  >    mismatch detected"  errors.
>
>
> Thanks for the patch but the whole reason for this detection and others
>  in the DLL is to disallow multiple copies of cygwin1.dll from running at
>  the same time.  This isn't a bug, it's a feature.  That's why we have
>  the detection in the first place.
>
>  As you can see from other checks in the dll, the shared memory region
>  is just one of the things that are checked for.  If you need to have
>  two copies of the DLL for debugging then there are ways to do that.
>  But, in general, it is not a good idea to use two versions of the DLL
>  unless you really know what you are doing, so we are not going to
>  be making it trivially possible for everyone to do that.
>
>  cgf
>
