Return-Path: <cygwin-patches-return-2287-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4600 invoked by alias); 2 Jun 2002 16:38:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4563 invoked from network); 2 Jun 2002 16:38:09 -0000
Date: Sun, 02 Jun 2002 09:38:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: bug fix for empty files in /proc/<n>
Message-ID: <20020602163809.GC12502@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000a01c20a25$6440a0e0$0100a8c0@advent02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000a01c20a25$6440a0e0$0100a8c0@advent02>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00270.txt.bz2

On Sun, Jun 02, 2002 at 12:05:22PM +0100, Chris January wrote:
>This patch fixes the empty files bug that cropped up a little while back. I
>don't plan on doing any more patches except bug fixes until 1.3.11 is
>released because I don't have the time.
>
>Regards
>Chris
>
>2002-02-26  Christopher January <chris@atomice.net>
>
>    * fhandler_process.cc (fhandler_process::open): Set fileid.

I've applied this patch, but you might want to look at your system's
time and date.

Thanks,
cgf
