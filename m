Return-Path: <cygwin-patches-return-4360-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11299 invoked by alias); 12 Nov 2003 09:27:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11288 invoked from network); 12 Nov 2003 09:27:34 -0000
Date: Wed, 12 Nov 2003 09:27:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dtable.cc (build_fh_pc): serial port handling
Message-ID: <20031112092733.GB7542@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0311111612280.9584@eos> <Pine.GSO.4.56.0311111819230.9584@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0311111819230.9584@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00079.txt.bz2

On Tue, Nov 11, 2003 at 06:25:41PM -0600, Brian Ford wrote:
> Here is one I think I do understand.
> 
> 2003-11-11  Brian Ford  <ford@vss.fsi.com>
> 
>  	* dtable.cc (build_fh_pc): Use DEV_SERIAL_MAJOR to catch all
> 	serial ports.
> 
> -- 
> Brian Ford
> Senior Realtime Software Engineer
> VITAL - Visual Simulation Systems
> FlightSafety International
> Phone: 314-551-8460
> Fax:   314-551-8444
> Index: dtable.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
> retrieving revision 1.119
> diff -u -p -r1.119 dtable.cc
> --- dtable.cc	1 Oct 2003 12:36:39 -0000	1.119
> +++ dtable.cc	12 Nov 2003 00:25:16 -0000
> @@ -339,6 +339,9 @@ build_fh_pc (path_conv& pc)
>        case DEV_TAPE_MAJOR:
>  	fh = cnew (fhandler_dev_tape) ();
>  	break;
> +      case DEV_SERIAL_MAJOR:
> +	fh = cnew (fhandler_serial) ();
> +	break;
>        default:
>  	switch (pc.dev)
>  	  {
> @@ -355,9 +358,6 @@ build_fh_pc (path_conv& pc)
>  	    break;
>  	  case FH_WINDOWS:
>  	    fh = cnew (fhandler_windows) ();
> -	    break;
> -	  case FH_SERIAL:
> -	    fh = cnew (fhandler_serial) ();
>  	    break;
>  	  case FH_FIFO:
>  	    fh = cnew (fhandler_fifo) ();

This looks right to me.  Chris?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
