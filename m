Return-Path: <cygwin-patches-return-4339-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25095 invoked by alias); 6 Nov 2003 01:31:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25085 invoked from network); 6 Nov 2003 01:31:48 -0000
Message-Id: <3.0.5.32.20031105200201.00828100@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 06 Nov 2003 01:31:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Fixing the PROCESS_DUP_HANDLE security hole (part
  1).
In-Reply-To: <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q4/txt/msg00058.txt.bz2

Ping? 

This has been pending for a while. See also
<http://cygwin.com/ml/cygwin-patches/2003-q4/msg00003.html>

Pierre

At 09:55 PM 9/29/2003 -0400, Pierre A. Humblet wrote:
>Here is a patch that allows to open master ttys without giving
>full access to the process, at least for access to the ctty. 
>
>It works by snooping the ctty pipe handles and duplicating them
>on the cygheap, for use by future opens in descendant processes.
>
>It passes all the tests I tried, but considering my lack of knowledge
>about ttys, everything is possible.
>
>Pierre
>
>
>2003-09-29  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* cygheap.h (class cygheap_ctty): Create.
>	(struct init_cygheap): Add inherited_ctty member.
>	* cygheap.cc: Include pinfo.h.
>	(cygheap_ctty::acquire): Create.
>	(cygheap_ctty::pass): Ditto.
>	(cygheap_ctty::close): Ditto.
>	* fhandler_tty.cc (fhandler_tty_slave::open): Call
>	cygheap->inherited_ctty.pass and cygheap->inherited_ctty.acquire.
>	* tty.cc (tty::common_init): Remove call to SetKernelObjectSecurity
>	and edit some comments.
>	* syscalls.cc (setsid): Call cygheap->inherited_ctty.close.
>
>Attachment Converted: "c:\Home\Pierre\Mail\attach\tty1.dif"
>
