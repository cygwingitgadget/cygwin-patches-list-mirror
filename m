Return-Path: <cygwin-patches-return-4774-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13410 invoked by alias); 19 May 2004 08:52:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13400 invoked from network); 19 May 2004 08:52:37 -0000
Date: Wed, 19 May 2004 08:52:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] To handle Win32 pipe names
Message-ID: <20040519085237.GA7011@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BAY9-F265VSSFcl3imp0000784b@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY9-F265VSSFcl3imp0000784b@hotmail.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00126.txt.bz2

Stephen,

On May 17 12:57, Stephen Cleary wrote:
> Attached is a patch against the current CVS sources, with a ChangeLog. This 
> patch allows Win32 pipe names to be opened as files.

that's still not quite what I had in mind.  I'd like to see as less special
windows path handling in Cygwin as possible.  A //foo/pipe/whatever path is
just like any other UNC path and could be handled as such, no extra code
should be necessary.  //./pipe/whatever should also go through without any
extra code so the whole idea would be to do exactly nothing, except the
existing code has a bug, of course.  I really don't care for stat.  If
Windows named pipes are recognized as files, so be it.

I've just quickly stepped through the existing code and it looks like
\\.\foo paths can be opened normally on NT.  Just stat seems to have
a problem, since stat_worker checks for fh->exists() at one point and
GetFileAttributes returned INVALID_FILE_ATTRIBUTES on devices.  So that
explains your patch to symlink_info::check.  But it's not exactly right
to circumvent this only for pipes.  Any \\.\foo path should get the
same handling.  Wouldn't it be more straightforward to use is_unc_share
or a slightly modified version of is_unc_share?

> The legal paperwork just got in the mail this morning, but this patch may 
> be small enough that it wouldn't require it anyway.

Unfortunately it isn't.  Patches small enough to go in without paperwork
are "trivial" patches.  The rule of thumb is that such a patch shouldn't
change more than 10 lines of code.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
