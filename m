Return-Path: <cygwin-patches-return-2644-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9685 invoked by alias); 13 Jul 2002 20:00:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9670 invoked from network); 13 Jul 2002 20:00:45 -0000
Date: Sat, 13 Jul 2002 13:00:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: mark_closed messages
Message-ID: <20020713200054.GA4225@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <015501c225c3$d8ddcc20$6132bc3e@BABEL> <20020707180435.GA1213@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020707180435.GA1213@redhat.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00092.txt.bz2

On Sun, Jul 07, 2002 at 02:04:35PM -0400, Christopher Faylor wrote:
>It sounds like the handle list is a candidate for the cygheap, so
>that it can be properly dealt with in execed and forked processes.

FWIW, I've moved the handle list to the cygheap.  That makes the cygheap
much bigger for the debugging case, but I can live with that.

I've undoubtedly added some kind of new instability to cygwin in this
process so please report any problems to cygwin-developers.  Or, even
better, provide a patch to cygwin-patches.

cgf
