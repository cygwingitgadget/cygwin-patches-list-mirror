Return-Path: <cygwin-patches-return-4451-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19653 invoked by alias); 30 Nov 2003 02:08:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19641 invoked from network); 30 Nov 2003 02:08:22 -0000
Date: Sun, 30 Nov 2003 02:08:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH]:  Add flock syscall emulation
Message-ID: <20031130020821.GA10649@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0311271409240.1064139@reddragon.clemson.edu> <20031129230104.GA6964@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031129230104.GA6964@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00170.txt.bz2

On Sun, Nov 30, 2003 at 12:01:04AM +0100, Corinna Vinschen wrote:
>On Thu, Nov 27, 2003 at 02:51:10PM -0500, Nicholas Wourms wrote:
>> Hi All,
>> 
>> Here is a patch to add the flock() syscall to Cygwin.  I've noticed that some
>
>Applied with changes.
>
>I've run indent on flock.c since its formatting was non-GNU.  I've
>removed the _DEFUN, since it's nowhere else used in Cygwin.  I've
>added a change message to include/sys/file.h according to the
>licensing terms in include/sys/copying.dj.  I removed the _flock
>from cygwin.din.  This should in future really only be used if newlib
>expects a new syscall.

Is there any reason this can't be a .cc rather than a .c

cgf
