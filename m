Return-Path: <cygwin-patches-return-4486-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1948 invoked by alias); 8 Dec 2003 15:11:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1939 invoked from network); 8 Dec 2003 15:11:06 -0000
Message-ID: <3FD49489.89622F66@phumblet.no-ip.org>
Date: Mon, 08 Dec 2003 15:11:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
X-Accept-Language: en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Fixing the PROCESS_DUP_HANDLE security hole (part 1).
References: <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net> <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net> <3.0.5.32.20031207222431.00829420@incoming.verizon.net> <20031208062734.GA6855@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q4/txt/msg00205.txt.bz2



Christopher Faylor wrote:
> 
> On Sun, Dec 07, 2003 at 10:24:31PM -0500, Pierre A. Humblet wrote:
> >It's mostly fine (rxvt and notty) but starting the following from DOS
> >creates a slew of warning from the handler protection code (below).
> >However the shell is functional.
> >tty reports /dev/tty, instead of /dev/ttyN with 1.5.5
> >
> >@echo off
> >set CYGWIN=tty
> >C:
> >chdir \progra~1\cygwin\bin
> >bash --login -i
> 
> This is odd, since this is specifically how I tested cygwin prior to checking
> everything in.  I can't duplicate this.
> 
> I initially couldn't duplicate the 'tty' problem either, but after my
> 15th clean rebuild, I did see it.  I don't know why I wasn't seeing it
> before.
> 
> I've checked in a fix for the ttyname and a shot in the dark for the
> mark_closed problems.

Thanks Chris, I will try that tonight.
Did you test with both CYGWIN=tty and --login?

Pierre
