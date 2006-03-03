Return-Path: <cygwin-patches-return-5793-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13174 invoked by alias); 3 Mar 2006 18:01:38 -0000
Received: (qmail 13163 invoked by uid 22791); 3 Mar 2006 18:01:37 -0000
X-Spam-Check-By: sourceware.org
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 03 Mar 2006 18:01:35 +0000
Received: from rainbow ([192.168.1.165]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.1830); 	 Fri, 3 Mar 2006 18:01:32 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [Patch] regtool: Add load/unload commands and --binary option
Date: Fri, 03 Mar 2006 18:01:00 -0000
Message-ID: <042c01c63eec$80b18780$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20060303174157.GA3704@efn.org>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00102.txt.bz2

On 03 March 2006 17:42, Yitzchak Scott-Thoennes wrote:

>>   Hey, how about using pseudo filename-extensions on the pseudo-files that
>> represent registry keys?
> 
> As long as we are how-bouting, I'm looking at
> 
> http://search.cpan.org/~tyemq/Win32-TieRegistry-0.24/TieRegistry.pm
> 
> as another example of non-traditional access to the registry.  How
> about /proc/registry//machinename/... to access the registry of other
> computers on the network?  Or is // not at the beginning a no-no?


  There may be POSIX-y issues with // anywhere else.

  And the idea of having /proc contain objects related to another machine
altogether does somewhat make my skin crawl.  If we wanna do this at all, I'd
rather it was done as //machine/registry/..., i.e. make a UNC share for the
registry virtual fs tree.... this I guess would require a cygwin MUP, which
isn't gonna happen any time soon though.

  Should we move this thread off the -patches list perhaps?

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
