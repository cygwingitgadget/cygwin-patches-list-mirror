Return-Path: <cygwin-patches-return-6483-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32766 invoked by alias); 6 Apr 2009 20:51:42 -0000
Received: (qmail 32755 invoked by uid 22791); 6 Apr 2009 20:51:41 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 06 Apr 2009 20:51:33 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 232BF6D5521; Mon,  6 Apr 2009 22:51:22 +0200 (CEST)
Date: Mon, 06 Apr 2009 20:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fstat() problem in libc/rexec.cc
Message-ID: <20090406205121.GV852@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49DA641F.8070901@agilent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49DA641F.8070901@agilent.com>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00025.txt.bz2

Hi Earl,

On Apr  6 13:20, Earl Chew wrote:
> The current implementation of rexec() uses fstat() and it seems
> to pick up the wrong values for st_mode. As a consequence
> the code keeps complaining about the permissions for ~/.netrc
> and won't complete successfully.
>
> I don't know enough about the how the re-mapping of stat/stat64
> works within cygwin1.dll itself, but changing to fstat64()
> like libc/iruserok.c resolves the problem.

That's exactly the right thing to do.  The mapping from fstat to fstat64
only works for applications and libs linked against Cygwin, not within
Cygwin itself.  So the call to fstat in rexec calls the old fstat
function which uses the old backward compatible style struct stat with
different member sizes.  This explains that the mode bits are not
correct.  I really thought I had catched them all, but this slipped
through my cracks, apparently :}

> winsup/cygwin/Changlog
>
>     * libc/rexec.cc: Use fstat64() instead of fstat().

Patch applied.


Thank you,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
