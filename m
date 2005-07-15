Return-Path: <cygwin-patches-return-5566-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2750 invoked by alias); 15 Jul 2005 18:11:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2740 invoked by uid 22791); 15 Jul 2005 18:11:07 -0000
Received: from nat.electric-cloud.com (HELO main.electric-cloud.com) (63.82.0.114)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 15 Jul 2005 18:11:07 +0000
Received: from fulgurite.electric-cloud.com (fulgurite.electric-cloud.com [192.168.1.58])
	by main.electric-cloud.com (8.13.1/8.13.1) with ESMTP id j6FIB5dx012639
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <cygwin-patches@cygwin.com>; Fri, 15 Jul 2005 11:11:05 -0700
Subject: [Patch]: Changes to how-programming.texinfo
From: Max Kaehn <slothman@electric-cloud.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain
Date: Fri, 15 Jul 2005 18:11:00 -0000
Message-Id: <1121451065.13490.13.camel@fulgurite>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q3/txt/msg00021.txt.bz2

Because this patch includes details addressing the Cygwin license,
I've included my conversation with Rebecca Ward (rward[at]redhat.com)
verifying the propriety of language of the patch at the end of this
message.
---
2005-07-15  Max Kaehn <slothman@electric-cloud.com>

	* how-programming.texinfo:  Add clarification on Cygwin
	licensing to "How do I use cygwin1.dll with Visual Studio
	or MinGW?"  Add mention of "configure --enable-debugging=yes"
	to "How do I build Cygwin on my own?"

Index: doc/how-programming.texinfo
===================================================================
RCS file: /cvs/src/src/winsup/doc/how-programming.texinfo,v
retrieving revision 1.42
diff -u -p -r1.42 how-programming.texinfo
--- doc/how-programming.texinfo	10 Jul 2005 19:39:31 -0000	1.42
+++ doc/how-programming.texinfo	15 Jul 2005 17:57:11 -0000
@@ -219,8 +219,21 @@ code links against the cygwin dll (and i
 functions from Cygwin, it must, as a matter of fact, be linked against
 it), you must apply the GPL to your source as well.  Of course, this
 only matters if you plan to distribute your program in binary form.
For
-more information, see @file{http://gnu.org/licenses/gpl-faq.html}.  If
-that is not a problem, read on.
+more information, see @file{http://gnu.org/licenses/gpl-faq.html}.
+
+There are two exceptions to this:
+@enumerate
+@item Your code is already under a license that complies with
+the Open Source definition.  See
+@file{http://www.opensource.org/docs/definition_plain.html} for the
+precise details.
+@item You have purchased a Cygwin Limited Buy-Out License from Red Hat,
Inc.
+For more information, see
+@file{http://www.redhat.com/software/cygwin/support/}.
+@end enumerate
+
+If your program does not qualify under either exception, you must
+distribute it under the GPL.  If that is not a problem, read on.
 
 If you want to load the DLL dynamically, read
 @code{winsup/cygwin/how-cygtls-works.txt} and the sample code in
@@ -374,6 +387,10 @@ If you get the error "shared region is c
 different versions of cygwin1.dll are running on your machine at the
 same time. Remove all but one. 
 
+Running @code{configure} with @code{--enable-debugging=yes} will
+build a version of the DLL that will warn you if you have collisions
+between Windows handles.
+
 @subsection I may have found a bug in Cygwin, how can I debug it (the
symbols in gdb look funny)?
 
 Debugging symbols are stripped from distibuted Cygwin binaries, so any
---
On Fri, 2005-07-15 at 09:33 -0700, Rebecca Ward wrote:
> On Tue, 2005-07-12 at 14:27, Max Kaehn wrote:
> > Here's the current relevant FAQ, from
> > http://cygwin.com/faq/faq_3.html#SEC102 :
> > ---
> > How do I use `cygwin1.dll' with Visual Studio or MinGW?
> > 
> > Before you begin, note that Cygwin is licensed under the GNU GPL (as
> > indeed are all other Cygwin-based libraries). That means that if your
> > code links against the cygwin dll (and if your program is calling
> > functions from Cygwin, it must, as a matter of fact, be linked against
> > it), you must apply the GPL to your source as well. Of course, this only
> > matters if you plan to distribute your program in binary form. For more
> > information, see http://gnu.org/licenses/gpl-faq.html. If that is not a
> > problem, read on.
> > ---
> > Here's my proposed change to it:
> > ---
> > How do I use `cygwin1.dll' with Visual Studio or MinGW? 
> > 
> > Before you begin, note that Cygwin is licensed under the GNU GPL (as
> > indeed are all other Cygwin-based libraries). That means that if your
> > code links against the cygwin dll (and if your program is calling
> > functions from Cygwin, it must, as a matter of fact, be linked against
> > it), you must apply the GPL to your source as well. Of course, this only
> > matters if you plan to distribute your program in binary form. For more
> > information, see http://gnu.org/licenses/gpl-faq.html.
> > 
> > There are two exceptions to this:
> > 
> >      1. Your code is already under a license that complies with the Open
> >         Source definition. See
> >         http://www.opensource.org/docs/definition_plain.html for the
> >         precise details.
> >      2. You have purchased a Cygwin Limited Buy-Out License from Red
> >         Hat, Inc. For more information, see
> >         http://www.redhat.com/software/cygwin/support/.
> > 
> > If your program does not qualify under either exception, you must
> > distribute it under the GPL. If that is not a problem, read on.
> > 
> > ---
> > If you approve this (or provide an amended version that precisely
> > complies with Red Hat's needs), I'll submit a copy of your reply and the
> > appropriate diffs to cygwin-patches.
> > 
> > Thanks,
> > Max
> 
> Max,
> 
> Good news! Our engineering services team has blessed your proposed
> changes. Feel free to go ahead and submit them to the cygwin
> community.  
> 
> Thank you!
> Rebecca

