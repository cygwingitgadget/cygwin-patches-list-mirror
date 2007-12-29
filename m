Return-Path: <cygwin-patches-return-6217-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20319 invoked by alias); 29 Dec 2007 17:57:58 -0000
Received: (qmail 20309 invoked by uid 22791); 29 Dec 2007 17:57:57 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 29 Dec 2007 17:57:53 +0000
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Sat, 29 Dec 2007 17:57:51 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
References: <050e01c84401$be876720$2e08a8c0@CAM.ARTIMI.COM> <20071221234102.GA23118@trixie.casa.cgf.cx> <071a01c84a0d$b1b79d50$2e08a8c0@CAM.ARTIMI.COM> <20071229170412.GA24999@ednor.casa.cgf.cx> <074201c84a3f$64bf8fd0$2e08a8c0@CAM.ARTIMI.COM> <20071229172937.GB24999@ednor.casa.cgf.cx>
Subject: RE: Export fast *rint* functions
Date: Sat, 29 Dec 2007 17:57:00 -0000
Message-ID: <074a01c84a44$5459ec30$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20071229172937.GB24999@ednor.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00069.txt.bz2

On 29 December 2007 17:30, Christopher Faylor wrote:

> On Sat, Dec 29, 2007 at 05:22:31PM -0000, Dave Korn wrote:
>> On 29 December 2007 17:04, Christopher Faylor wrote:
>> 
>>> I assume that the above comment about aliasing needs to know right?
>> 
>>  Sorry, can't parse that.  ENOCOFFEE?  ;-)
> 
> I meant "go" above.  I got distracted by my stupid turtle who, after
> twelve years of docility in the tank behind me, has decided to spend the
> last two months frantically trying to claw his way out of his tank.
> 
> I guess I just don't understand what the aliasing is all about here.

  Right, it goes like this:

-  At the moment, all the new x87 *rint* functions are implemented as fast
math variants in newlib, with '_f_' prefixes to the function names.  (I'm not
convinced this is necessarily correct, but that's the way it is right now;
when Jeff gets back I'll discuss whether and why they can or can't be
considered first-class implementations).

-  For the functions that didn't already exist (i.e., all except
rint/rintf/lrint/lrintf), Jeff added wrappers using the POSIX standard names
that call through to the equivalent _f_ hard-fp version of the same function.

  Now, these wrappers are fairly superfluous.  They set up a stack frame,
immediately tear it down, then tail-call to the underlying _f_ function.

  So, I figured, if someone's linking against the DLL and needs one of these
functions, why not get the link to resolve directly to the _f_ function and
avoid the wrapper?  It won't make a great deal of impact to debuggability or
stack traces and it saves a few wasted instructions.

  Also, the existing soft-float implementations of rint/rintf/lrint/lrintf are
still present in newlib; they are not overridden by the _f_ versions.  So any
app that links against these will continue to get the old slow soft float
version.  By exporting the _f_ version with the name of the non-_f_ version,
apps will link against the hard fp version instead.

  OTOH, I can see how this could be a bit confusing and make setting
breakpoints a bit tricky.  I could remove the aliasing for the new functions
and make calls go through the wrapper, but there aren't any wrappers for the
existing functions, just soft-float implementations, so at least those
functions would still need to be aliased to the _f_ versions.  Long-term, my
plan is to either provide wrappers for those existing functions (in a
cygwin-only patch to newlib), or if there are no compliance problems to
promote all the _f_*rint* functions to first-class versions, losing the _f_
prefix and wrapper altogether.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
