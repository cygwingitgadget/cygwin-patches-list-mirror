Return-Path: <cygwin-patches-return-5669-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31691 invoked by alias); 24 Oct 2005 10:02:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31665 invoked by uid 22791); 24 Oct 2005 10:02:21 -0000
Received: from zipcon.net (HELO zipcon.net) (209.221.136.5)
    by sourceware.org (qpsmtpd/0.30-dev) with SMTP; Mon, 24 Oct 2005 10:02:21 +0000
Received: (qmail 26503 invoked from network); 24 Oct 2005 03:06:47 -0700
Received: from unknown (HELO efn.org) (209.221.136.26)
  by mail.zipcon.net with SMTP; 24 Oct 2005 03:06:47 -0700
Received: by efn.org (sSMTP sendmail emulation); Mon, 24 Oct 2005 03:02:20 -0700
Date: Mon, 24 Oct 2005 10:02:00 -0000
From: Yitzchak Scott-Thoennes <sthoenna@efn.org>
To: cygwin-patches@cygwin.com
Subject: Re: expose creating windows-style envblock from current environment
Message-ID: <20051024100220.GA2360@efn.org>
References: <20051024010823.GA648@efn.org> <20051024094803.GA21196@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024094803.GA21196@calimero.vinschen.de>
User-Agent: Mutt/1.4.2.1i
X-SW-Source: 2005-q4/txt/msg00011.txt.bz2

On Mon, Oct 24, 2005 at 11:48:03AM +0200, Corinna Vinschen wrote:
> On Oct 23 18:08, Yitzchak Scott-Thoennes wrote:
> > I need to translate the current environment in a cygwin C program to
> > an envblock suitable for calling CreateProcess directly, and couldn't
> > think of a better way than the following patch.
> 
> I'm wondering why that's necessary at all.  You have access to the app's
> POSIX environment and you know by a simple look into Cygwin which
> variables have to be path converted and which not.  That can be done
> using cygwin_conv_to_win32_path/cygwin_posix_to_win32_path_list.  Looks
> like a task easily accomplished inside of the application.

I seem to recall changes over time in which variables get converted
(or forced to exist) it would be nice, though not mandatory, to
automatically stay in synch.  Unless you are outright rejecting
having a way to do this, I'll play with it some more.  Perhaps
a new function would be better, but I don't know how to get a new
function exported by the dll.

> > But I think there's something I'm not understanding; with the free()
> > calls in place, it coredumps, though checking the code in environ.cc
> > seems to show that all the freed chunks should have been properly
> > allocated.
> 
> envp and the envp members are allocated on the cygheap using cmalloc()
> and cstrdup() so you must free them with cfree().

(quietly) Oh.
 
> > As an aside, does the build_env call in spawn.cc leak?
> 
> How?

By never freeing moreinfo->envp in the parent?  I couldn't follow how
moreinfo/ciresrv are being used, other than that they get passed somehow
to the child.

Thanks for looking at this and giving feedback.
