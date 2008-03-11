Return-Path: <cygwin-patches-return-6285-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24373 invoked by alias); 11 Mar 2008 16:01:36 -0000
Received: (qmail 24363 invoked by uid 22791); 11 Mar 2008 16:01:35 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 11 Mar 2008 16:01:19 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 857846D430A; Tue, 11 Mar 2008 17:01:16 +0100 (CET)
Date: Tue, 11 Mar 2008 16:01:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
Message-ID: <20080311160116.GH18407@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <47D6A6E1.F8C89DFF@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47D6A6E1.F8C89DFF@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00059.txt.bz2

On Mar 11 08:36, Brian Dessent wrote:
> Corinna Vinschen wrote:
> 
> > Given that Cygwin changes to support long path names, I don't really
> > like to see new code still using MAX_PATH and Win32 Ansi functions
> > in the utils dir.  I know that the Win32 cwd is always restricted to
> > 259 chars.  However, there *is* a way to recognize the current working
> > directory of the parent Cygwin application.
> 
> Here's an updated version of the patch.  It addresses the problem of
> resolving symlink targets relative to the dir of the link without a
> gratuitous Get/SetCurrentDirectory sequence by introducing
> cygpath_rel().  It does not yet address the issue of modernizing the
> symlink reading code, that will follow.
> 
> This patch still has two cases of MAX_PATH usage: one in a buffer that
> is used for GetCurrentDirectory(), so I don't see how making it larger
> there helps.  The second is in a static buffer for the dirname()
> helper.  I could simply make this one larger, however, the context where
> this dirname() is used is a filename that's used with CreateFile() so
> until that is plumbed to use WCHAR and \\?\ I don't really think it
> makes sense to use more than MAX_PATH.  I could update that instance of
> CreateFile, but the thing that provides the filename passed here is
> itself driven by GetFileAttributes(), so it would need to be updated
> too... and so on.  It looks like a lot of work to go completely
> longfile-clean here.

The patch looks basically ok with me.  Please check in.

Btw., you don't need to make the buffers MAX_PATH + 1.  MAX_PATH is
defined including the trailing NUL.  Existing code shows a lot of
irritation about this...


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
