From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch: socket protocol parameter not handled correctly.
Date: Sat, 17 Mar 2001 09:05:00 -0000
Message-id: <20010317180512.P20900@cygbert.vinschen.de>
References: <001a01c0aef5$26d22260$b20c1918@nc.rr.com>
X-SW-Source: 2001-q1/msg00196.html

On Sat, Mar 17, 2001 at 10:15:50AM -0500, Mathew Brozowski wrote:
> I have been recently working on a port or a ping program to cygwin.  After I
> got past the header problems (which I hope to send a separate patch for
> soon) and got everything building it still wasn't working.  I used tcpdump
> on a linux machine and found that the packets being sent were not encoded
> with the ICMP protocol identifier but with the identifier 0.  I tracked it
> down to the fact that the cygwin_socket routine wasn't passing the protocol
> parameter to the Windows socket call.  After fixing this rebuilding the
> cygwin1.dll the ping program worked great!  Here's the patch minor though it
> is.
> 
> Matt Brozowski
> 
> Sat Mar 17 09:51:32 2001 Mathew Brozowski <brozow@tavve.com>
> 
>  * net.cc (cygwin_socket): Pass protocol parameter to socket call.
> 
> --- net.cc-orig Sat Mar 17 09:46:08 2001
> +++ net.cc Sat Mar 17 09:49:10 2001
> @@ -352,7 +352,7 @@ cygwin_socket (int af, int type, int pro
>      {
>        debug_printf ("socket (%d, %d, %d)", af, type, protocol);
> 
> -      soc = socket (AF_INET, type, 0);
> +      soc = socket (AF_INET, type, protocol);
> 
>        if (soc == INVALID_SOCKET)
>   {

Thanks for tracking this down.

Applied,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
