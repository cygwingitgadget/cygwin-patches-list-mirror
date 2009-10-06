Return-Path: <cygwin-patches-return-6723-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9212 invoked by alias); 6 Oct 2009 19:35:17 -0000
Received: (qmail 9202 invoked by uid 22791); 6 Oct 2009 19:35:16 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-2.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.2)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 19:35:12 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id C7E6A3B0002 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 15:35:02 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id C5F9B2B352; Tue,  6 Oct 2009 15:35:02 -0400 (EDT)
Date: Tue, 06 Oct 2009 19:35:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
Message-ID: <20091006193502.GA18384@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ACA4323.5080103@cwilson.fastmail.fm>  <20091005202722.GG12789@calimero.vinschen.de>  <4ACA5BC7.6090908@cwilson.fastmail.fm>  <20091006034229.GA12172@ednor.casa.cgf.cx>  <4ACAC079.2020105@cwilson.fastmail.fm>  <20091006074620.GA13712@calimero.vinschen.de>  <4ACB56D5.4060606@cwilson.fastmail.fm>  <4ACB670F.2070209@cwilson.fastmail.fm>  <20091006182221.GD18135@ednor.casa.cgf.cx>  <4ACB9042.3070104@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACB9042.3070104@cwilson.fastmail.fm>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00054.txt.bz2

On Tue, Oct 06, 2009 at 02:45:22PM -0400, Charles Wilson wrote:
>Christopher Faylor wrote:
>
>> Looks good with a minor kvetch: Could you use "bool" instead of "BOOL"
>> for variables that don't have to be passed to a Windows function that
>> takes a BOOL argument?
>
>For the static function exit_process(), sure. But the argument list
>accepted by cygwin_internal() should be C-compatible, shouldn't it? So,
>how about the following?

"bool" is C-compatible.  You just have to #include <stdbool.h> .

But now that you mention it, I wonder if we really should have to
require an #include <windows.h> to use this.  Maybe it should just
be unsigned long.

cgf

>static void exit_process (UINT, bool) __attribute__((noreturn));
>...
>static void
>exit_process (UINT status, bool useTerminateProcess)
>{
>...
>}
>...
>      case CW_EXIT_PROCESS:
>        {
>          UINT status = va_arg (arg, UINT);
>          BOOL useTerminateProcess = va_arg (arg, BOOL);
>          exit_process (status, !!useTerminateProcess); /* no return */
>        }
>
>--
>Chuck
>
