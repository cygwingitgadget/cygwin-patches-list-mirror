Return-Path: <cygwin-patches-return-2279-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26385 invoked by alias); 1 Jun 2002 22:38:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26371 invoked from network); 1 Jun 2002 22:38:47 -0000
Date: Sat, 01 Jun 2002 15:38:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: strace -f fix
Message-ID: <20020601223846.GB8326@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <06eb01c209b9$11c491d0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06eb01c209b9$11c491d0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00262.txt.bz2

On Sat, Jun 01, 2002 at 11:09:57PM +0100, Conrad Scott wrote:
>I've been playing around with the strace program some more and noticed a
>minor glitch: it's only meant to trace forked children if the -f flag is
>given on the command line. Unfortunately it currently always traces
>children, and the this flag has no effect.
>
>Having read the MS documentation, I fully understand this: the documentation
>of the relevant flag (DEBUG_ONLY_THIS_PROCESS) is at the least utterly
>ambiguous and most likely contradictory.

What are you trying to fix?  AFAICT, the -f option is working correctly.

cgf
