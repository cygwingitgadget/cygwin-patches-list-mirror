Return-Path: <cygwin-patches-return-3164-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32009 invoked by alias); 13 Nov 2002 22:36:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32000 invoked from network); 13 Nov 2002 22:36:50 -0000
Date: Wed, 13 Nov 2002 14:36:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: ioctl.cc fix
Message-ID: <20021113223709.GA29682@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <001c01c28460$ca1e5eb0$0201a8c0@sos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001c01c28460$ca1e5eb0$0201a8c0@sos>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00115.txt.bz2

On Mon, Nov 04, 2002 at 07:17:51PM -0500, Sergey Okhapkin wrote:
>I see no output from "debug_printf ("returning %d", res);" in trace file
>without this fix... gcc bug?
>
>2002-11-04  Sergey Okhapkin  <sos@prospect.com.ru>
>
>        * ioctl.cc (ioctl): Add default case.

I reorganized this function slightly into something I think makes
a little more sense.  It should solve this problem.

Thanks for the heads up.

Did you see the serial issues that were reported in the cygwin mailing
list, btw?

cgf
