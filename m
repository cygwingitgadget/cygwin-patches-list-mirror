Return-Path: <cygwin-patches-return-6300-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4023 invoked by alias); 16 Mar 2008 15:11:40 -0000
Received: (qmail 3993 invoked by uid 22791); 16 Mar 2008 15:11:39 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sun, 16 Mar 2008 15:11:12 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 3A2A16D430A; Sun, 16 Mar 2008 16:11:10 +0100 (CET)
Date: Sun, 16 Mar 2008 15:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
Message-ID: <20080316151110.GB29148@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <47D3B079.C8BA614C@dessent.net> <20080309095109.GX18407@calimero.vinschen.de> <47D3BCAC.98C49164@dessent.net> <20080309103618.GZ18407@calimero.vinschen.de> <47D3D1CC.87E7D183@dessent.net> <20080309130342.GA18407@calimero.vinschen.de> <47DBD3DA.8B718E2@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47DBD3DA.8B718E2@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00074.txt.bz2

On Mar 15 06:49, Brian Dessent wrote:
> Anyway, the attached is the result of what happened when I started with
> the Cygwin code and whittled it down.  It fixes the bug in the
> grandparent of this email where it was reading the Win32 path out of a
> shortcut that didn't have an ITEMIDLIST, and it supports the new-style
> shortcut where the target > MAX_PATH gets stored at the end.  It does
> not attempt to do anything with reparse points however.

That's ok.  We won't use reparse points for our own dreadful purposes
anyway.

> 	* path.cc: Include malloc.h for alloca.
> 	(is_symlink): Rewrite.  Just read the whole file in memory rather
> 	than by parts.  Account for an ITEMIDLIST if present, as well as
> 	the new style of Cygwin shortcut supporting targets > MAX_PATH.

The patch looks ok to me.  Please check it in.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
