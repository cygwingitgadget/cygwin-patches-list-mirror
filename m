Return-Path: <cygwin-patches-return-2964-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14739 invoked by alias); 14 Sep 2002 18:43:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14725 invoked from network); 14 Sep 2002 18:43:22 -0000
Date: Sat, 14 Sep 2002 11:43:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin part of pseudo-relocs patch
Message-ID: <20020914184315.GA19372@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <17051818150.20020903103820@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17051818150.20020903103820@logos-m.ru>
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00412.txt.bz2

On Tue, Sep 03, 2002 at 10:38:20AM +0400, egor duda wrote:
>This is an updated cygwin part of pseudo-relocs patch.  Relocations are
>performed inside of cygwin1.dll, as Chris suggested, and it seems to
>work ok in case of one dll referencing another one.  After new binutils
>package is released, it can go into cygwin release.

Sorry for the long delay in reviewing this.  As the mantra goes "I've
been incredibly busy".  I could tell you just how busy I am but I don't
have time right now.  Anyway, I thought that this patch would take some
time to review so I've been avoiding it.

As it turns out, it took very little time at all.

It seems to be ok, as far as I can tell, but I would prefer it if you
would use the cygwin_internal interface for adding new cygwin-specific
functionality.  That can allow a program to gracefully degrade when
a feature is not available rather than popping up an "entry point not
found" dialog.

Assuming that you agree to this change, feel free to check in a version
based on this concept.

Thanks and apologies again for the delay in reviewing this patch.

cgf
