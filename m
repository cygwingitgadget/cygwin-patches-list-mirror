Return-Path: <cygwin-patches-return-6447-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16915 invoked by alias); 14 Mar 2009 15:58:54 -0000
Received: (qmail 16905 invoked by uid 22791); 14 Mar 2009 15:58:53 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-111.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.111)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 14 Mar 2009 15:58:45 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id A74F213C022 	for <cygwin-patches@cygwin.com>; Sat, 14 Mar 2009 11:58:34 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 8B6C82B385; Sat, 14 Mar 2009 11:58:34 -0400 (EDT)
Date: Sat, 14 Mar 2009 15:58:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: errno.h: ESTRPIPE
Message-ID: <20090314155834.GA31983@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49B8A1F8.1030306@users.sourceforge.net> <20090312085748.GE14431@calimero.vinschen.de> <49B98AC4.1040202@users.sourceforge.net> <20090313103036.GA13010@calimero.vinschen.de> <49BA4D48.1030705@etr-usa.com> <20090313145026.GB11253@ednor.casa.cgf.cx> <20090313205949.GE9322@calimero.vinschen.de> <20090313214754.GB12746@ednor.casa.cgf.cx> <20090314092559.GG9322@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090314092559.GG9322@calimero.vinschen.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q1/txt/msg00045.txt.bz2

On Sat, Mar 14, 2009 at 10:25:59AM +0100, Corinna Vinschen wrote:
>On Mar 13 17:47, Christopher Faylor wrote:
>>On Fri, Mar 13, 2009 at 09:59:49PM +0100, Corinna Vinschen wrote:
>>>On Mar 13 10:50, Christopher Faylor wrote:
>>>>Defining a unique value means that, if we do decide at some point to
>>>>add functionality which utilizes that errno there will be no need to
>>>>recompile the application.
>>>
>>>That's quite a good argument.  If you both think it's a good idea to
>>>define this new errno, I'm fine with it, too.
>>
>>I was wondering if we should add a conditionalized "#include
>><cygwin/errno.h>" to newlib's errno.h.  Then we could add things
>>without littering the file with #ifdef CYGWIN's.
>
>Actually I was going to propose the same idea yesterday when I wrote my
>reply.  But then it occured to me that, *if* we add our own errno.h, we
>would have to make sure that we start with our own errnos at a value
>way above EOWNERDEAD so that we don't get an errno clash when new
>errnos are added to newlib.  But in this case we raise the size of
>_sys_errlist with empty slots for no good reason.  And the worst case,
>newlib adds an errno with another value than what's defined in
>cygwin/errno.h.

Ah, right.  I think I go through the cycle of thinking this is a good
idea and then realizing it won't work every year or so.  I guess I
needed you to complete the cycle.

>So, if we add this errno, just stick it to newlib's sys/errno.h as in
>Yaakovs original patch.
>
>If that's ok with you I'll apply Yaakov's patch on Monday.

No objections.

cgf
