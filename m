Return-Path: <cygwin-patches-return-5670-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5845 invoked by alias); 24 Oct 2005 13:46:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5822 invoked by uid 22791); 24 Oct 2005 13:46:22 -0000
Received: from mail-n.franken.de (HELO ilsa.franken.de) (193.175.24.27)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 24 Oct 2005 13:46:22 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])
	by ilsa.franken.de (Postfix) with ESMTP id 97A54245C6
	for <cygwin-patches@cygwin.com>; Mon, 24 Oct 2005 15:46:19 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])
	by aqua.hirmke.de (Postfix) with ESMTP id 0E4ECAAFF6
	for <cygwin-patches@cygwin.com>; Mon, 24 Oct 2005 15:46:19 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 098F5544122; Mon, 24 Oct 2005 15:46:19 +0200 (CEST)
Date: Mon, 24 Oct 2005 13:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: expose creating windows-style envblock from current environment
Message-ID: <20051024134618.GJ27476@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20051024010823.GA648@efn.org> <20051024094803.GA21196@calimero.vinschen.de> <20051024100220.GA2360@efn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024100220.GA2360@efn.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q4/txt/msg00012.txt.bz2

On Oct 24 03:02, Yitzchak Scott-Thoennes wrote:
> On Mon, Oct 24, 2005 at 11:48:03AM +0200, Corinna Vinschen wrote:
> > On Oct 23 18:08, Yitzchak Scott-Thoennes wrote:
> > > I need to translate the current environment in a cygwin C program to
> > > an envblock suitable for calling CreateProcess directly, and couldn't
> > > think of a better way than the following patch.
> > 
> > I'm wondering why that's necessary at all.  You have access to the app's
> > POSIX environment and you know by a simple look into Cygwin which
> > variables have to be path converted and which not.  That can be done
> > using cygwin_conv_to_win32_path/cygwin_posix_to_win32_path_list.  Looks
> > like a task easily accomplished inside of the application.
> 
> I seem to recall changes over time in which variables get converted
> (or forced to exist) it would be nice, though not mandatory, to
> automatically stay in synch.  Unless you are outright rejecting

Hmm, it *is* pretty stable.  AFAIR there was only a SYSTEMROOT problem
once and a LD_LIBRARY_PATH which was accidentally converted.  Given that
latter example, you might even be better off with an application side
implementation.

> having a way to do this, I'll play with it some more.  Perhaps
> a new function would be better, but I don't know how to get a new
> function exported by the dll.

Definitely not.  *Iff* we add such a functionality, it should really be
using the cygwin_internal interface.  But still, I'm not sure that's the
way to go.

> > > As an aside, does the build_env call in spawn.cc leak?
> > 
> > How?
> 
> By never freeing moreinfo->envp in the parent?  I couldn't follow how
> moreinfo/ciresrv are being used, other than that they get passed somehow
> to the child.

Hmm, I must admit that I don't see freeing moreinfo in the parent myself,
so Chris might shed some light.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat, Inc.
