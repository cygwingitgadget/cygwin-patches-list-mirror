Return-Path: <cygwin-patches-return-1571-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20559 invoked by alias); 11 Dec 2001 00:24:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20511 invoked from network); 11 Dec 2001 00:24:49 -0000
Date: Fri, 02 Nov 2001 15:55:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Serial code stack corruption
Message-ID: <20011211002507.GA31233@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <E1740305C340D411AC5500B0D020FF7A010656F2@stmail01.good.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1740305C340D411AC5500B0D020FF7A010656F2@stmail01.good.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2001-q4/txt/msg00103.txt.bz2

On Mon, Dec 10, 2001 at 03:22:28PM -0800, Victor Tsou wrote:
>
>WaitCommEvent was called in overlapped mode with a pointer to a stack
>variable passed in for lpEvtMask. When the asynchronous request completes in
>the future, the function might no longer be in scope. In such cases, data on
>the stack is erroneously overwritten with the event mask.
>
>This patch cancels the WaitCommEvent request by calling SetCommMask. This is
>the only documented method of cancelling the eventmask update.

Do you actually have a test case that illustrates this scenario?

I don't remember any more but I thought that raw_read wasn't supposed to be
exited unless I/O was complete.

However, I've added an 'ev' field to the fhandler_serial class which can
be used for this.  I think that should eliminate any possibility of
stack corruption.

Thanks for the patch.

cgf
