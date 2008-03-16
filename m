Return-Path: <cygwin-patches-return-6303-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22254 invoked by alias); 16 Mar 2008 15:35:20 -0000
Received: (qmail 22244 invoked by uid 22791); 16 Mar 2008 15:35:20 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-250.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.250)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 16 Mar 2008 15:35:00 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 360866641DD; Sun, 16 Mar 2008 11:34:58 -0400 (EDT)
Date: Sun, 16 Mar 2008 15:35:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] QueryDosDevice in handle_to_fn
Message-ID: <20080316153457.GA27448@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47DCF310.2E2CA04A@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47DCF310.2E2CA04A@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00077.txt.bz2

On Sun, Mar 16, 2008 at 03:14:40AM -0700, Brian Dessent wrote:
>
>It looks like handle_to_fn is again acting up for named pipes.  A
>representative strace snippet looks something like this:
>
>  428  108008 [main] readlink 3048 handle_to_fn: nt name
>'\Device\NamedPipe\Win32Pipes.0000082c.00000003'
> 1548  109556 [main] readlink 3048 normalize_posix_path: src
>\Device\NamedPipe\Win32Pipes.0000082c.00000003
>   97  109653 [main] readlink 3048 normalize_win32_path:
>c:\Device\NamedPipe\Win32Pipes.0000082c.00000003 = normalize_win32_path
>(\Device\NamedPipe\Win32Pipes.0000082c.00000003)
>   35  109688 [main] readlink 3048 mount_info::conv_to_win32_path:
>conv_to_win32_path (c:/Device/NamedPipe/Win32Pipes.0000082c.00000003)
>   42  109730 [main] readlink 3048 mount_info::conv_to_win32_path:
>src_path c:/Device/NamedPipe/Win32Pipes.0000082c.00000003, dst
>c:\Device\NamedPipe\Win32Pipes.0000082c.00000003, flags 0x0, rc 0
>
>Clearly, something is wrong, there is no such C:\devices, and it wasn't
>even trying to match it as a pipe.  I debugged this and found the
>strangest thing, when you call QueryDosDevice (NULL, fnbuf, len) to get
>the list of all DOS devices and len >= 65536, Win32 always returns 0
>with GetLastError set to ERROR_MORE_DATA.  Since len was being set as
>"sizeof (OBJECT_NAME_INFORMATION) + NT_MAX_PATH * sizeof (WCHAR)" this
>always happened, causing handle_to_fn() to simply give up and copy the
>Win32 name into the POSIX name and return.  The attached patch fixes the
>problem by just clamping the size of the buffer to under 64k.

Interesting analysis but you're doing an if test on a constant (len)
where you (apparently) know that the length is > 65535.  Why not just
use another constant and a comment in QueryDosDevice?

FWIW, this probably wouldn't cause a problem in my sandbox other than
not detecting the correct name.  My dtable.cc is slightly different.

>Another observation that I had while debugging this is that calling
>strncasematch() in this function is probably wrong -- it expands to
>cygwin_strncasecmp(), which is a wrapper that first converts both
>arguments to temporary UNICODE strings and then calls
>RtlCompareUnicodeString() -- we're doing this on strings that we had
>just converted *out* of UNICODE.  I think ascii_strncasematch() is
>probably what we want here instead, either that or try to stay in
>unicode throughout.

I guess it should be UNICODE everywhere since the most likely result
of running handle_to_fn is to return an on-disk filename.

cgf
