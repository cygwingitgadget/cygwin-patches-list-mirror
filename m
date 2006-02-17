Return-Path: <cygwin-patches-return-5763-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24510 invoked by alias); 17 Feb 2006 11:35:43 -0000
Received: (qmail 24496 invoked by uid 22791); 17 Feb 2006 11:35:41 -0000
X-Spam-Check-By: sourceware.org
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 17 Feb 2006 11:35:38 +0000
Received: from rainbow ([192.168.1.165]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.1830); 	 Fri, 17 Feb 2006 11:35:19 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] cygcheck: follow symbolic links
Date: Fri, 17 Feb 2006 11:35:00 -0000
Message-ID: <00e801c633b6$3b529490$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.GSO.4.63.0602161116540.22053@access1.cims.nyu.edu>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00072.txt.bz2

On 16 February 2006 17:27, Igor Peshansky wrote:

> On Thu, 16 Feb 2006, Corinna Vinschen wrote:

>> - Couldn't you just reuse the readlink implementation in ../cygwin/path.cc
>>   as is, to avoid having to different implementations?
> 
> Umm, most of that code is very general purpose, and has too much extra
> stuff in it.

  I think you may have misoptimised for speed rather than maintainability.
Cygcheck isn't something that people expect to run a million times per second
in an inner loop.

>  I basically used part of it (symlink_info::check_shortcut)
> for my implementation.  I wanted something lightweight and easy to
> understand 

  Perhaps you could have just exported it (or a convenient interface to it)
instead?

>(also, the code in path.cc doesn't check for PE headers, so I
> had to write that part anyway).

  None of which affects /that/ bit.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
