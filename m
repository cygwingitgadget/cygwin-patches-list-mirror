Return-Path: <cygwin-patches-return-4113-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 738 invoked by alias); 19 Aug 2003 02:57:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 725 invoked from network); 19 Aug 2003 02:57:46 -0000
Message-Id: <3.0.5.32.20030818225650.008121c0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Tue, 19 Aug 2003 02:57:00 -0000
To: cygwin-patches@cygwin.com,cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Signal handling tune up.
In-Reply-To: <20030819015817.GA6091@redhat.com>
References: <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com>
 <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00129.txt.bz2

At 09:58 PM 8/18/2003 -0400, Christopher Faylor wrote:
>
>I only applied the reversal of the movl with the call above since I'm
>not convinced that moving the set_process_mask into interrupt_setup
>doesn't introduce a race.  It seems like your code could be setting the
>signal mask in interrupt_setup while it is also being restured in
>sigreturn.  That would end up with the signal mask being indeterminate.

Bummer. You are right.
In practice breaking out of the inner loop (decrementing sigtodo)
should have about the same effect as having the sigthread itself set
the mask, i.e. when sigtodo is > 1 , the sigthread will only start one 
handler and won't find the sigsave busy.

Pierre
