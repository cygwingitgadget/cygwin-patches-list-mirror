Return-Path: <cygwin-patches-return-5221-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20094 invoked by alias); 16 Dec 2004 22:06:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19860 invoked from network); 16 Dec 2004 22:05:54 -0000
Received: from unknown (HELO pmesmtp01.mci.com) (199.249.20.1)
  by sourceware.org with SMTP; 16 Dec 2004 22:05:54 -0000
Received: from pmismtp02.mcilink.com ([166.38.62.37])
 by firewall.mci.com (Iplanet MTA 5.2)
 with ESMTP id <0I8U001235DPDG@firewall.mci.com> for cygwin-patches@cygwin.com;
 Thu, 16 Dec 2004 22:05:50 +0000 (GMT)
Received: from pmismtp02.mcilink.com by pmismtp02.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with SMTP id <0I8U001015DPWQ@pmismtp02.mcilink.com> for
 cygwin-patches@cygwin.com; Thu, 16 Dec 2004 22:05:49 +0000 (GMT)
Received: from WS117V6220509.mcilink.com ([166.34.132.122])
 by pmismtp02.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0I8U001855DPIS@pmismtp02.mcilink.com> for
 cygwin-patches@cygwin.com; Thu, 16 Dec 2004 22:05:49 +0000 (GMT)
Date: Thu, 16 Dec 2004 22:06:00 -0000
From: Mark Paulus <mark.paulus@mci.com>
Subject: Re: Patch to allow trailing dots on managed mounts
In-reply-to: <20041216163732.GJ23488@trixie.casa.cgf.cx>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Message-id: <0I8U001865DPIS@pmismtp02.mcilink.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Priority: Normal
X-SW-Source: 2004-q4/txt/msg00222.txt.bz2

On Thu, 16 Dec 2004 11:37:32 -0500, Christopher Faylor wrote:

>On Thu, Dec 16, 2004 at 09:23:56AM -0700, Mark Paulus wrote:
>>Which is why I did what I did.  If you look, my patch allows for
>>checking to see if "............................." was entered as an
>>argument, and throws the exception if it was.  THEN, if that is not the
>>case, it passes the FULL name to conv_to_win32_path to allow for proper
>>demangling rules.

>What you did was clear.  It was only a two line change, after all.

>Unfortunately, you seemed to assume that all the work that cygwin went
>through to figure out that trailing dot stuff was just useless and that
>the rest of cygwin will work just fine with files containing trailing
>dots regardless of whether the file is managed or not.  That is not the
>case.  The point of the section of code that you patched was not just to
>"throw the exception" it was to strip off the trailing dots.

Then I guess I'll have to wait for a fix to come down, since the amount
of work to fix this will probably be more than I can put in without a waiver.




>cgf


