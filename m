Return-Path: <cygwin-patches-return-4216-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8931 invoked by alias); 15 Sep 2003 08:03:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8920 invoked from network); 15 Sep 2003 08:03:23 -0000
Date: Mon, 15 Sep 2003 08:03:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Part 2 of Fixing a security hole in pinfo.
Message-ID: <20030915080322.GV9981@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030913220742.0082d260@incoming.verizon.net> <20030914023055.GA10962@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914023055.GA10962@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00232.txt.bz2

On Sat, Sep 13, 2003 at 10:30:55PM -0400, Christopher Faylor wrote:
> On Sat, Sep 13, 2003 at 10:07:42PM -0400, Pierre A. Humblet wrote:
> >This is the second and final part of the pinfo security patch. 
> 
> Looks like a Corinna yea or nay on this one.

The changes look good.  Please apply, Pierre.

FYI:

What bugged me when reading the patch was my decision at one point to
use the phrase "orig_sid".  The "orig_sid" is basically what is called
a "saved id" in POSIX systems and I think it would help reading the
code if we also rename orig_sid/orig_uid/orig_gid to saved_sid/saved_uid/
saved_gid and using the phrase "saved" instead of "orig" or "original"
throughout.

So, after you have applied the patch, I'll do all the renaming within
this week.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
