Return-Path: <cygwin-patches-return-2124-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11374 invoked by alias); 30 Apr 2002 08:32:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11345 invoked from network); 30 Apr 2002 08:32:15 -0000
Date: Tue, 30 Apr 2002 01:32:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: SSH -R problem
Message-ID: <20020430103200.C18891@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020429205809.007f2920@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020429205809.007f2920@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00108.txt.bz2

On Mon, Apr 29, 2002 at 08:58:09PM -0400, Pierre A. Humblet wrote:
> 2) The reason the sockets persist is that they are 
> non-blocking. On Win95/98/ME close() doesn't work 
> correctly for non-blocking sockets, as reported in
> http://cygwin.com/ml/cygwin-patches/2002-q2/msg00095.html 
> 
> The patch in fhandler_socket::close() would be something like:
> /* HACK */
> If the socket is non blocking
>   then make it blocking 
>        set linger to Off 
>          (which will make close() non-blocking, as desired)
>   else set linger to On, as done currently
> The WSAEWOULDBLOCK stuff could go away.
> 
> I don't have the time to test and submit a real patch for the 
> moment, perhaps Steve could help.
> My rough test code basically adds
>  int request = 0;
>  ioctl (FIONBIO, &request);
>  linger.l_onoff = 0; 
> I have made > 500 calls into a connection created by ssh -R 
> from WinME to WinME and > 100 calls into ssh -L from a client 
> on WinME to a server on Win98. 

I think it's worth a try.  I'll probably check in something
similar to the above hack but...

> Of course we are then exposed to the issue that Cygwin was trying
> to fix by setting linger to On, i.e. the case of a process 
> exiting just after the close(). Fortunately sockets are usually 

...why cant we keep that, i. e.

   If the socket is non blocking
     then make it blocking
    set linger to On, as done currently

?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
