Return-Path: <cygwin-patches-return-7328-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8320 invoked by alias); 11 May 2011 10:32:35 -0000
Received: (qmail 7300 invoked by uid 22791); 11 May 2011 10:32:09 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 11 May 2011 10:31:52 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 093632C0577; Wed, 11 May 2011 12:31:49 +0200 (CEST)
Date: Wed, 11 May 2011 10:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
Message-ID: <20110511103149.GA11041@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCA1E59.4070800@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DCA1E59.4070800@cs.utoronto.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00094.txt.bz2

Hi Ryan,

On May 11 01:27, Ryan Johnson wrote:
> Hi all,
> 
> Please find attached three patches which extend the functionality of
> /proc/*/maps.

Thanks!

I applied youyr two first patches with a couple of changes:

- Formatting: Setting of curly braces in class and method defintions,
  a lot of missing spaces, "int *foo" instead of "int* foo", stuff
  like that.  Please compare what I checked in against your patch. 
  That doesn't mean I always get it right myself, but basically that's
  how it should be.

- NT_MAX_PATH is the maximum size of a path including the trailing \0,
  so a buffer size of NT_MAX_PATH + 1 isn't required.

- Please always use sys_wcstombs rather than wcstombs for filenames.

- I replaced the call to GetMappedFileNameEx with a call to
  NtQueryVirtualMemory (MemorySectionName).  This avoids to add another
  dependency to psapi.  I intend to get rid of them entirely, if
  possible.

> NOTE 1: I do not attempt to identify PEB, TEB, or thread stacks. The
> first could be done easily enough, but the second and third require
> venturing into undocumented/private Windows APIs.

Go ahead!  We certainly don't shy away from calls to
NtQueryInformationProcess or NtQueryInformationThread.

> NOTE 2: If desired, we could easily extend format_process_maps
> further to report section names of mapped images (linux does this
> for .so files), [...]

Sorry if I'm dense, but isn't that exactly what GetMappedFileNameEx or
NtQueryVirtualMemory (MemorySectionName) do?  I also don't see any extra
information for .so files in the Linux maps output.  What detail am I
missing?


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
