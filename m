Return-Path: <cygwin-patches-return-2967-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26557 invoked by alias); 15 Sep 2002 19:05:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26543 invoked from network); 15 Sep 2002 19:05:36 -0000
Date: Sun, 15 Sep 2002 12:05:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin part of pseudo-relocs patch
Message-ID: <20020915190545.GC32609@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <17051818150.20020903103820@logos-m.ru> <20020914184315.GA19372@redhat.com> <101436798232.20020915155139@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <101436798232.20020915155139@logos-m.ru>
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00415.txt.bz2

On Sun, Sep 15, 2002 at 03:51:39PM +0400, egor duda wrote:
>Hi!
>
>Saturday, 14 September, 2002 Christopher Faylor cgf@redhat.com wrote:
>
>CF> On Tue, Sep 03, 2002 at 10:38:20AM +0400, egor duda wrote:
>>>This is an updated cygwin part of pseudo-relocs patch.  Relocations are
>>>performed inside of cygwin1.dll, as Chris suggested, and it seems to
>>>work ok in case of one dll referencing another one.  After new binutils
>>>package is released, it can go into cygwin release.
>
>CF> Sorry for the long delay in reviewing this.  As the mantra goes "I've
>CF> been incredibly busy".  I could tell you just how busy I am but I don't
>CF> have time right now.  Anyway, I thought that this patch would take some
>CF> time to review so I've been avoiding it.
>
>CF> As it turns out, it took very little time at all.
>
>CF> It seems to be ok, as far as I can tell, but I would prefer it if you
>CF> would use the cygwin_internal interface for adding new cygwin-specific
>CF> functionality.  That can allow a program to gracefully degrade when
>CF> a feature is not available rather than popping up an "entry point not
>CF> found" dialog.
>
>This entry point was added intentionally, to diagnose the case
>when application, linked using --enable-pseudo-relocs, is linked
>(statically or dynamically) with a runtime which doesn't support such
>relocations. Actually, i don't see the way for application to handle
>such situation in other way than simply exiting with some kind of
>"fatal error" message.

Which is much more graceful than displaying a dialog box.

cgf
