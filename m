Return-Path: <cygwin-patches-return-6251-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23836 invoked by alias); 22 Feb 2008 16:12:36 -0000
Received: (qmail 23824 invoked by uid 22791); 22 Feb 2008 16:12:35 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 22 Feb 2008 16:12:04 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.13.8+Sun/8.13.8) with ESMTP id m1MGBNNZ013510; 	Fri, 22 Feb 2008 11:11:23 -0500 (EST)
Date: Fri, 22 Feb 2008 16:12:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Noel Burton-Krahn <noel@burton-krahn.com>
cc: cygwin-patches@cygwin.com
Subject: Re: PATCH: avoid system shared memory version mismatch detected by  versioning shared memory name
In-Reply-To: <674fdff20802212117k1936a3bcrb79175546d973ce3@mail.gmail.com>
Message-ID: <Pine.GSO.4.63.0802221107310.10844@access1.cims.nyu.edu>
References: <674fdff20802211641p19f7b3a1pb3f843ba262dfde6@mail.gmail.com>    <674fdff20802211701u1a866d2fw2bb21047ecc5e8ea@mail.gmail.com>    <20080222050020.GA17196@ednor.casa.cgf.cx> <674fdff20802212117k1936a3bcrb79175546d973ce3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00025.txt.bz2

Ugh, top-posting...  Reformatted.

On Thu, 21 Feb 2008, Noel Burton-Krahn wrote:

> On 2/21/08, Christopher Faylor
> <cgf-use-the-mailinglist-please@XXXXXX.XXX> wrote:

<http://cygwin.com/acronyms/#PCYMTNQREAIYR>.  Thanks.

> > On Thu, Feb 21, 2008 at 05:01:20PM -0800, Noel Burton-Krahn wrote:
> >  >This is a patch to avoid the "system shared memory version mismatch
> >  >detected" problem when two applications use different versions of
> >  >Cygwin.  My solution is to append the Cygwin version number to the
> >  >name of the shared memory segment, so only Cygwin with the same
> >  >version share a memory space.
> >  >
> >  >ChangeLog
> >  >2008-02-21  Noel Burton-Krahn  <noel@burton-krahn.com>
> >  >
> >  >    * shared.cc (shared_name): always add USER_VERSION_MAGIC to the
> >  >    shared memory space name so multiple versions of Cygwin keep their
> >  >     own shared memory space.  No more "system shared memory version
> >  >    mismatch detected"  errors.

FYI, you get that automatically when you build a debug version of the DLL.

> > Thanks for the patch but the whole reason for this detection and
> > others in the DLL is to disallow multiple copies of cygwin1.dll from
> > running at the same time.  This isn't a bug, it's a feature.  That's
> > why we have the detection in the first place.
> >
> > As you can see from other checks in the dll, the shared memory region
> > is just one of the things that are checked for.  If you need to have
> > two copies of the DLL for debugging then there are ways to do that.
> > But, in general, it is not a good idea to use two versions of the DLL
> > unless you really know what you are doing, so we are not going to be
> > making it trivially possible for everyone to do that.
>
> The problem is there are several installable apps built on Cygwin, like
> EAC, ClamAV, and one I just found which is a Cygwin-on-a-thumbdrive.
> The problem is they can't all coexist because they're distributed with
> different versions of the cygwin dlls. Making them work with the current
> cygwin means hand-copying cygwin dlls into application directories, and
> repeating that every time you upgrade. People used to give Windows a
> hard time for DLL hell!  I don't see the benefit of forcing users to
> hand-maintain cygwin dlls across multiple applications.

Don't copy DLLs -- that will only compound the problem.  Put c:\cygwin\bin
(or wherever you installed Cygwin to) in the system PATH, and let those
apps find the latest cygwin1.dll from there.

Besides, even if this patch were accepted (which it won't), you still
would not have fixed *those* versions of cygwin1.dll, so those apps would
still conflict with each other.

And this discussion is no longer pertinent to cygwin-patches.  If you wish
to continue, let's move to the main list, <cygwin at cygwin dot com>.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"That which is hateful to you, do not do to your neighbor.  That is the whole
Torah; the rest is commentary.  Go and study it." -- Rabbi Hillel
