Return-Path: <cygwin-patches-return-3916-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13407 invoked by alias); 27 May 2003 08:01:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13395 invoked from network); 27 May 2003 08:01:44 -0000
Date: Tue, 27 May 2003 08:01:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: [corinna-cygwin@cygwin.com: Re: ENOTSOCK errors with cygwin dll 1.3.21 and 1.3.22]
Message-ID: <20030527080142.GB19957@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <F0E13277A26BD311944600500454CCD05217D2@antarctica.intern.net> <Pine.WNT.4.44.0305261633550.288-200000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0305261633550.288-200000@algeria.intern.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00143.txt.bz2

Hi Thomas,

On Tue, May 27, 2003 at 09:15:10AM +0200, Thomas Pfaff wrote:
> 	* fhandler_socket.cc (sock_event::~sock_event): New method.
> 	(sock_event::load): Change to void. Check if winsock2 is available.
> 	(socke_event::wait): Return 0 if interruptible mode is not available.
> 	(fhandler_socket::connect): Remove checks for winsock2 availability.
> 	(fhandler_socket::accept): Ditto.

that looks pretty good, just...

> --- fhandler_socket.cc.org	2003-05-26 16:08:16.000000000 +0200
> +++ fhandler_socket.cc	2003-05-27 09:05:38.000000000 +0200
> @@ -131,31 +131,44 @@ public:
>        ev[0] = WSA_INVALID_EVENT;
>        ev[1] = signal_arrived;
>      }
> -  bool load (SOCKET sock, int type_bit)
> +  ~sock_event ()
>      {
> -      if ((ev[0] = WSACreateEvent ()) == WSA_INVALID_EVENT)
> -	return false;
> +      if (ev[0] != WSA_INVALID_EVENT)
> +        CloseHandle (ev[0]);
           ^^^^^^^^^^^
	   ...shouldn't that be a WSACloseEvent?

> +    }

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
