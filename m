Return-Path: <cygwin-patches-return-6996-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1586 invoked by alias); 2 Mar 2010 15:53:14 -0000
Received: (qmail 1560 invoked by uid 22791); 2 Mar 2010 15:53:13 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-48-46-17.bstnma.fios.verizon.net (HELO cgf.cx) (173.48.46.17)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 02 Mar 2010 15:53:08 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 37E1713C0C8 	for <cygwin-patches@cygwin.com>; Tue,  2 Mar 2010 10:53:06 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id EEB3B2B352; Tue,  2 Mar 2010 10:53:05 -0500 (EST)
Date: Tue, 02 Mar 2010 15:53:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
Message-ID: <20100302155305.GA11311@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <4B8D2F9D.4090309@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B8D2F9D.4090309@cwilson.fastmail.fm>
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
X-SW-Source: 2010-q1/txt/msg00112.txt.bz2

On Tue, Mar 02, 2010 at 10:32:45AM -0500, Charles Wilson wrote:
>Charles Wilson wrote:
>> The attached patch(es) add XDR support to cygwin. eXternal Data
>
>Now that newlib has accepted the XDR patches, the following simply
>exports those symbols. It also ensures that the (rare) xdr error
>messages are handled by cygwin as they are in glibc: print them to
>stderr (unlike the previous patch, which printed them to cygwin's debug
>strace).
>
>I know we're in the run-up to 1.7.2, so it may be prudent to delay these
>changes until after that, which is fine by me.
>
>Now, I ran into a small problem: applying the attached patch to current
>HEAD:
>
>2010-03-01  Christopher Faylor  <...>
>	* cygtls.h: Replace /*gentls_offsets*/ at end.
>
>and doing an incremental rebuild (e.g. not a full clean&rebuild), I get
>a non-functional cygwin1.dll:
>
>C:\cygwin-1.7\bin>bash
>      3 [main] bash 6840 exception::handle: Exception:
>STATUS_ACCESS_VIOLATION
>Exception: STATUS_ACCESS_VIOLATION at eip=61113909
>eax=00000000 ebx=00000000 ecx=00000001 edx=00000008 esi=6115B2B0
>edi=00000000
>ebp=0022CB18 esp=0022CB00 program=C:\cygwin-1.7\bin\bash.exe, pid 6840,
>thread m
>ain
>cs=001B ds=0023 es=0023 fs=003B gs=0000 ss=0023
>Stack trace:
>Frame     Function  Args
>0022CB18  61113909  (0022D008, 00000000, 0022CB48, 61115228)
>0022CB28  61113A22  (0022D008, 00000000, 0022CB48, 00000000)
>0022CB48  61115228  (6115B2B0, 0022CD40, 00477CE4, 00550130)
>0022CD08  610BC4B8  (0022CD40, 00000005, 0022CD68, 61006E43)
>0022CD68  61006E43  (00000000, 0022CDA4, 61006700, 7FFDC000)
>End of stack trace
>
>However, rolling back CVS to here:
>
>2010-02-26  Christopher Faylor  <...>
>	* mkimport: cd away from temp directory or Windows will
>	have problems
>
>and applying this patch, and all is well (again with an incremental).
>It could be that there is something funky going on with the recent
>commits -- or it may be something as simple as, with HEAD, I need to do
>a complete clean&rebuild.  I'll kick one of those off tonight.

The snapshot does not display this problem.  It sounds like your
tlsoffsets.h file is out of date.

cgf
