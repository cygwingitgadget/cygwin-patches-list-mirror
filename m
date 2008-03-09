Return-Path: <cygwin-patches-return-6277-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21226 invoked by alias); 9 Mar 2008 23:20:21 -0000
Received: (qmail 21216 invoked by uid 22791); 9 Mar 2008 23:20:20 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-250.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.250)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 09 Mar 2008 23:20:02 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id A83903FFDB4; Sun,  9 Mar 2008 19:20:00 -0400 (EDT)
Date: Sun, 09 Mar 2008 23:20:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
Message-ID: <20080309232000.GC14815@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <20080309143819.GB8192@ednor.casa.cgf.cx> <20080309151440.GB18407@calimero.vinschen.de> <20080309162800.GB13754@ednor.casa.cgf.cx> <47D4266A.CE301EDE@dessent.net> <20080309195509.GD18407@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080309195509.GD18407@calimero.vinschen.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00051.txt.bz2

On Sun, Mar 09, 2008 at 08:55:09PM +0100, Corinna Vinschen wrote:
>On Mar  9 11:03, Brian Dessent wrote:
>> Christopher Faylor wrote:
>> 
>> > I guess I misunderstood.  I thought that the current working directory
>> > could be derived through some complicated combination of Nt*() calls.
>> 
>> I could be wrong here but the way I understood it, there is no concept
>> of a working directory at the NT level, that is something that is
>> maintained by the Win32 layer.
>
>That's right.  NT doesn't have a notion what a cwd is.  It only has the
>OBJECT_ATTRIBUTES structure which defines an object by an absolute path,
>or by a path relative to a directory handle.
>
>The cwd is maintained by kernel32.dll in a per-process structure called
>RTL_USER_PROCESS_PARAMETERS.  The cwd is stored as path (always with
>trailing backslash) and as handle.

Duh, right.  I knew that.  I've seen the code.

So, maybe we could make sure the handle was inherited and pass it along
in a _CYGWIN_PWD=0x239487 format to the child?

cgf
