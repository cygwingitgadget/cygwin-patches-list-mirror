Return-Path: <cygwin-patches-return-4449-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19692 invoked by alias); 29 Nov 2003 23:01:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19683 invoked from network); 29 Nov 2003 23:01:09 -0000
Date: Sat, 29 Nov 2003 23:01:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@sources.redhat.com
Subject: Re: [PATCH]:  Add flock syscall emulation
Message-ID: <20031129230104.GA6964@cygbert.vinschen.de>
Mail-Followup-To: Corinna Vinschen <cygwin-patches@cygwin.com>,
	cygwin-patches@sources.redhat.com
References: <Pine.CYG.4.58.0311271409240.1064139@reddragon.clemson.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0311271409240.1064139@reddragon.clemson.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00168.txt.bz2

On Thu, Nov 27, 2003 at 02:51:10PM -0500, Nicholas Wourms wrote:
> Hi All,
> 
> Here is a patch to add the flock() syscall to Cygwin.  I've noticed that some

Applied with changes.

I've run indent on flock.c since its formatting was non-GNU.  I've
removed the _DEFUN, since it's nowhere else used in Cygwin.  I've
added a change message to include/sys/file.h according to the
licensing terms in include/sys/copying.dj.  I removed the _flock
from cygwin.din.  This should in future really only be used if newlib
expects a new syscall.

> As a side note, I noticed that sys/file.h was from DJGPP.  Will DJ allow us to
> use code from DJGPP in Newlib/Cygwin?  If so, I noticed some code in the DJGPP
> libc which I could port and use in future contributions.

This is a question you should ask DJ.  AFAIK, DJGPP is GPLd.  This
would mean that its code isn't suitable for use in Cygwin itself.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
