Return-Path: <cygwin-patches-return-5827-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7649 invoked by alias); 18 Apr 2006 00:37:45 -0000
Received: (qmail 7639 invoked by uid 22791); 18 Apr 2006 00:37:45 -0000
X-Spam-Check-By: sourceware.org
Received: from mtiwmhc11.worldnet.att.net (HELO mtiwmhc11.worldnet.att.net) (204.127.131.115)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 18 Apr 2006 00:37:44 +0000
Received: from dfw5rb41 (h-66-167-81-67.chcgilgm.dynamic.covad.net[66.167.81.67])           by worldnet.att.net (mtiwmhc11) with SMTP           id <200604180037421110050m9ie>; Tue, 18 Apr 2006 00:37:42 +0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: mkstemp vs. text mode
Date: Tue, 18 Apr 2006 00:37:00 -0000
Message-ID: <001601c66280$4be7dba0$020aa8c0@DFW5RB41>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20060417151018.GB28972@trixie.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00015.txt.bz2

> From: Christopher Faylor
[snip]
> Yes, I think it makes sense to open temp files in binary but 
> I'll bet that someone is relying on textmode behavior.  

I'll see that bet and raise you; I'll bet this results in massive problems.

> Nevertheless, I've applied the patch.
> 
> Let the cygwin ML whines begin...
> 
> cgf

Ok, I'm about to give it a try (assuming this is in the latest snapshot).
When I have some positive results, I shall post them to cygwin@.  If I have
negative results, should I post them there as well, or would that be
considered a "whine"?

-- 
Gary R. Van Sickle
 
