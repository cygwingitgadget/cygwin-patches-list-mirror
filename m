Return-Path: <cygwin-patches-return-4315-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19958 invoked by alias); 24 Oct 2003 12:43:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19915 invoked from network); 24 Oct 2003 12:43:03 -0000
Date: Fri, 24 Oct 2003 12:43:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_base::ioctl (FIONBIO)
Message-ID: <20031024124302.GD1653@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0310231800010.823@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0310231800010.823@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00034.txt.bz2

On Thu, Oct 23, 2003 at 06:06:09PM -0500, Brian Ford wrote:
> Any reason not to support this?  It seams to me that this patch just
> parallels what is already in fhandler_base::fcntl (F_SETFL) for
> O_NONBLOCK.

Yes, I think you're right.  However, I'd like to ask you to rearrange
your patch a bit.  Most (all?) other ioctl methods are using a switch
statement rather than a if/else clause.  To allow later easier extension,
I think using a switch here would be better as well, even though there's
only one case so far.

Corinna


> 
> I was trying to fix this issue:
> 
> http://www.cygwin.com/ml/cygwin/2003-10/msg01159.html
> 
> 2003-10-23  Brian Ford  <ford@vss.fsi.com>
> 
> 	* fhandler.cc (fhandler_base::ioctl): Handle FIONBIO.
> 
> -- 
> Brian Ford
> Senior Realtime Software Engineer
> VITAL - Visual Simulation Systems
> FlightSafety International
> Phone: 314-551-8460
> Fax:   314-551-8444
> Index: fhandler.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
> retrieving revision 1.159
> diff -u -p -r1.159 fhandler.cc
> --- fhandler.cc	30 Sep 2003 21:46:08 -0000	1.159
> +++ fhandler.cc	23 Oct 2003 21:38:51 -0000
> @@ -909,13 +909,21 @@ fhandler_base::close ()
>  int
>  fhandler_base::ioctl (unsigned int cmd, void *buf)
>  {
> +  int res;
> +
>    if (cmd == FIONBIO)
> -    syscall_printf ("ioctl (FIONBIO, %p)", buf);
> +    {
> +      set_nonblocking (*(int *) buf);
> +      res = 0;
> +    }
>    else
> -    syscall_printf ("ioctl (%x, %p)", cmd, buf);
> +    {
> +      set_errno (EINVAL);
> +      res = -1;
> +    }
>  
> -  set_errno (EINVAL);
> -  return -1;
> +  syscall_printf ("%d = ioctl (%x, %p)", res, cmd, buf);
> +  return res;
>  }
>  
>  int


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
