Return-Path: <cygwin-patches-return-4490-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16761 invoked by alias); 9 Dec 2003 04:14:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16731 invoked from network); 9 Dec 2003 04:14:42 -0000
Message-Id: <3.0.5.32.20031208231312.0082aaf0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 09 Dec 2003 04:14:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Fixing the PROCESS_DUP_HANDLE security hole (part
   1).
In-Reply-To: <3.0.5.32.20031208224603.0082cc00@incoming.verizon.net>
References: <20031209032857.GA11205@redhat.com>
 <3.0.5.32.20031208221010.0082f7b0@incoming.verizon.net>
 <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
 <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
 <3.0.5.32.20031208221010.0082f7b0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q4/txt/msg00209.txt.bz2

At 10:46 PM 12/8/2003 -0500, Pierre A. Humblet wrote:
>At 10:28 PM 12/8/2003 -0500, Christopher Faylor wrote:
>>
>>Does that solve the problem?
>
>Yes, but now I see another one: open_fhs is off.
>fhandler_tty_slave::close: decremented open_fhs -1

I have to stop for now.
One minor thing:
	(fhandler_tty_common::close): Set io_handle to NULL after closing.
should be done after the termios_printf. 

Pierre
