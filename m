Return-Path: <cygwin-patches-return-4310-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30570 invoked by alias); 23 Oct 2003 22:42:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30561 invoked from network); 23 Oct 2003 22:42:57 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Thu, 23 Oct 2003 22:42:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_tty_slave::ioctl (FIONBIO) return status
In-Reply-To: <20031023223037.GC14018@redhat.com>
Message-ID: <Pine.GSO.4.56.0310231736280.823@eos>
References: <Pine.GSO.4.56.0310231702270.823@eos> <20031023223037.GC14018@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q4/txt/msg00029.txt.bz2

On Thu, 23 Oct 2003, Christopher Faylor wrote:

> I don't think it makes sense to use get_ttyp ()->ioctl_retval = 0;
> here since we aren't actually communicating with the tty.
>
> Does something like this work?
>
Sure.  I don't actually have a test case.  This is just a hypothetical
that I ran into.  Small suggestion below.

> @@ -1086,9 +1088,9 @@ fhandler_tty_slave::ioctl (unsigned int
>      }
>
>    release_output_mutex ();
> +  retval = get_ttyp ()->ioctl_retval;
>
>  out:
> -  int retval = get_ttyp ()->ioctl_retval;
>    if (retval < 0)
>      {
>        set_errno (-retval);
>
You might want to move this if statement up too, as an optimization.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
