Return-Path: <cygwin-patches-return-5124-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14847 invoked by alias); 12 Nov 2004 04:57:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14800 invoked from network); 12 Nov 2004 04:57:13 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.170.214)
  by sourceware.org with SMTP; 12 Nov 2004 04:57:13 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I71V8F-003PKL-I2
	for cygwin-patches@cygwin.com; Fri, 12 Nov 2004 00:00:15 -0500
Message-Id: <3.0.5.32.20041111235225.00818340@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 12 Nov 2004 04:57:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
In-Reply-To: <20041112043322.GA21377@trixie.casa.cgf.cx>
References: <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00125.txt.bz2

At 11:33 PM 11/11/2004 -0500, Christopher Faylor wrote:
>On Thu, Nov 11, 2004 at 10:48:57PM -0500, Pierre A. Humblet wrote:
>>Now that 1.5.12 is out, here is a patch to fix the PROCESS_DUP_HANDLE
>>security hole.  It uses a new approach to reparenting: the parent
>>duplicates the exec'ed process handle when signaled by the child.
>
>Can you refresh my memory (a URL is fine) on "the PROCESS_DUP_HANDLE
>security hole"?

It starts with
http://cygwin.com/ml/cygwin-developers/2003-09/msg00078.html

Eventually things were broken down in several patches. The part 
about the tty gave rise to your archetype and the abandon of vfork.
Very long story.

>I'm not 100% certain but I think if you cast back into the dim recesses
>of cygwin's past, you might find that this is the way things used to be
>done, to some degree.

The patch relies heavily on your implementation of signals using a pipe,
which allows to carry extra info.

Pierre
