Return-Path: <cygwin-patches-return-2328-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30090 invoked by alias); 6 Jun 2002 01:34:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29998 invoked from network); 6 Jun 2002 01:34:09 -0000
Date: Wed, 05 Jun 2002 18:34:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Make CW_STRACE_TOGGLE toggle
Message-ID: <20020606013422.GA851@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01c501c20cf6$987d45b0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01c501c20cf6$987d45b0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00311.txt.bz2

On Thu, Jun 06, 2002 at 02:07:57AM +0100, Conrad Scott wrote:
>Another patch but very small.
>
>Currently calls to:
>
>    cygwin_internal (CW_STRACE_TOGGLE, pid)
>
>doesn't toggle the stracing of pid but simply turns it on again, i.e. a
>no-op after the first call.

Did you look at strace::hello?  This is supposed to toggle but, since
the "inited" field in the strace class is never set, it never toggles.

>I've got a small program that makes this call for a given process, so you
>can turn stracing on and off around events of interest etc. I'll send it
>along once I've thought of a good name for it (strtoggle? stroggle?
>stronoff? . . . ) Any suggestions?

I don't understand what this program does.  Are you saying that you run this
other program while stracing a running program?

I've never had a real use for this myself, but it sounds like this is an
strace option, not another program.

cgf
