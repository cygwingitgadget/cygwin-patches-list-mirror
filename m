Return-Path: <cygwin-patches-return-3997-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12555 invoked by alias); 9 Jul 2003 00:50:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12546 invoked from network); 9 Jul 2003 00:50:51 -0000
Date: Wed, 09 Jul 2003 00:50:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: start_time patch for fhandler_process.cc
Message-ID: <20030709005048.GA18400@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ICEBIHGCEJIPLNMBNCMKGEIECIAA.chris@atomice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ICEBIHGCEJIPLNMBNCMKGEIECIAA.chris@atomice.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00013.txt.bz2

On Tue, Jul 08, 2003 at 07:09:12PM +0100, Chris January wrote:
>Try this Chris and see if it solves the start time problem.
>
>Chris
>
>2003-07-28  Chris January  <kseitz@chris@atomice.net>
>
>	* fhandler_process.cc (format_process_stat): Changed the calculation for
>start_time.

Sorry, no.

Unknown HZ value! (250) Assume 100.
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
cgf       3452  0.0  1.0  2544 2680 ?        R    Aug08   0:00 procps auwx

Now that I've read the description of what the field is supposed to
contain, I'm wondering if the culprit is the "Unknown HZ value! (250)
Assume 100."

Could that be it?

cgf
