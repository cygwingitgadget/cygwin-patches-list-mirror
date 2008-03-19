Return-Path: <cygwin-patches-return-6310-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22356 invoked by alias); 19 Mar 2008 00:41:50 -0000
Received: (qmail 22346 invoked by uid 22791); 19 Mar 2008 00:41:50 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 19 Mar 2008 00:41:22 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.13.8+Sun/8.13.8) with ESMTP id m2J0fIwQ010778; 	Tue, 18 Mar 2008 20:41:18 -0400 (EDT)
Date: Wed, 19 Mar 2008 00:41:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Brian Dessent <brian@dessent.net>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] better stackdumps
In-Reply-To: <47E05FBE.B57EF4A2@dessent.net>
Message-ID: <Pine.GSO.4.63.0803182040020.8440@access1.cims.nyu.edu>
References: <47E05D34.FCC2E30A@dessent.net> <47E05FBE.B57EF4A2@dessent.net>
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
X-SW-Source: 2008-q1/txt/msg00084.txt.bz2

On Tue, 18 Mar 2008, Brian Dessent wrote:

> Brian Dessent wrote:
>
> > Of course the labeling works for any module/dll, not just cygwin1.dll,
> > but I didn't have a more elaborate testcase to demonstrate.
>
> Forgot to mention...
>
> The symbols are just tacked on on the right hand side there for now.  I
> wasn't really sure how to handle that.  I didn't want to remove display
> of the actual EIP for each frame as that could be removing useful info,
> but I wasn't quite sure where to put everything or how to align it... so
> as it is now it wraps wider than 80 chars which is probably pretty ugly
> on a default size terminal.

Would it make sense to force a newline before the function name and to
display it with a small indent?  That way people who want the old-style
stackdump could just feed the new one into "grep -v '^  '" or something...
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"That which is hateful to you, do not do to your neighbor.  That is the whole
Torah; the rest is commentary.  Go and study it." -- Rabbi Hillel
