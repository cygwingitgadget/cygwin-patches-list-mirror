Return-Path: <cygwin-patches-return-2687-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14630 invoked by alias); 23 Jul 2002 14:50:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14616 invoked from network); 23 Jul 2002 14:50:10 -0000
Date: Tue, 23 Jul 2002 07:50:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: serial patch - second attempt
Message-ID: <20020723165007.E13588@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3D327F4D.C8E80EB8@certum.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D327F4D.C8E80EB8@certum.pl>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00135.txt.bz2

On Mon, Jul 15, 2002 at 09:52:45AM +0200, Jacek Trzcinski wrote:
> 13 July 2002 Jacek Trzcinski <jacek@certum.pl>
> 
>     * fhandler.h (class fhandler_serial): Add new members of 
>     the class - rts,dtr and method ioctl(). Variables rts and dtr
>     important for Win 9x only.
>     * fhandler_serial.cc (fhandler_serial::open): Add initial setting
>     of dtr and rts. Important for Win 9x only.
>     (fhandler_serial::ioctl): New function. Implements commands TIOCMGET,
>     TIOCMSET and TIOCINQ.
>     (fhandler_serial::tcflush): Fixed found error.
>     (fhandler_serial::tcsetattr): Add settings of rts and dtr. Important
>     for Win 9x only. 
>     * termios.h: Add new defines as a support for ioctl() function
>     on serial device.

It's applied.  Today I've changed the

	if (!wincap.is_winnt ())

to using a new capability

	if (wincap.must_init_serial_line ())

which is set to true for each 9x/Me, to false for NT/2K/XP.

If you think that the name of the new capability is inappropriate,
please suggest another name.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
