Return-Path: <cygwin-patches-return-4128-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24503 invoked by alias); 20 Aug 2003 01:47:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24494 invoked from network); 20 Aug 2003 01:47:10 -0000
Date: Wed, 20 Aug 2003 01:47:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030820014709.GB26448@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030819024617.GA6581@redhat.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <3.0.5.32.20030819193152.00817750@incoming.verizon.net> <20030820004135.GA25456@redhat.com> <3.0.5.32.20030819212357.0081eb30@incoming.verizon.net> <20030820013236.GA26448@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030820013236.GA26448@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00144.txt.bz2

On Tue, Aug 19, 2003 at 09:32:36PM -0400, Christopher Faylor wrote:
>Although, hmm.  My brain hurts.  Maybe the latter behavior is more
>correct since if something is in the middle of changing the mask it will
>be guaranteed to be correct when the signal handler is finally called.

Brain still hurts.  I see that my changes from yesterday were wrong.
Serves me right for coding so late.

cgf
