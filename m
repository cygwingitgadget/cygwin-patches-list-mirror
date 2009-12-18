Return-Path: <cygwin-patches-return-6877-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10982 invoked by alias); 18 Dec 2009 03:32:48 -0000
Received: (qmail 10971 invoked by uid 22791); 18 Dec 2009 03:32:47 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-77.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.77)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 18 Dec 2009 03:32:42 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 976D53B0002 	for <cygwin-patches@cygwin.com>; Thu, 17 Dec 2009 22:32:32 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 8BBE32B352; Thu, 17 Dec 2009 22:32:32 -0500 (EST)
Date: Fri, 18 Dec 2009 03:32:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] ps command returns 1 if PID not found
Message-ID: <20091218033232.GA3575@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <b4864b490912171610k4c462d43p1298b0b1116af018@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4864b490912171610k4c462d43p1298b0b1116af018@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00208.txt.bz2

On Fri, Dec 18, 2009 at 11:10:40AM +1100, Ryan Dortmans wrote:
>>Sorry but returning 1 doesn't make sense and it isn't the way that linux
>>works.  It actually returns 0.
>
>dortmans> /bin/ps -p 4549 ; echo "Return val: $?"
>  PID TTY          TIME CMD
> 4549 ?        00:00:00 sshd
>Return val: 0
>dortmans> /bin/ps -p 1111 ; echo "Return val: $?"
>  PID TTY          TIME CMD
>Return val: 1
>
>dortmans> /bin/ps --version
>procps version 3.2.3
>
>I get these results in Solaris Unix and Red Hat Linux. The above
>commands were executed on a Red Hat Linux system.

Yes, I'm officially stupid.  Not only did I misread your subject, I
misinterpreted the sense of the patch.  Sorry.

Nevertheless, I think that my patch does the right thing so I'll check
that in since it affects fewer lines of code.

Thanks for the patch and apologies for the inexplicable
misunderstanding.

cgf
