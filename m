Return-Path: <cygwin-patches-return-2696-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19285 invoked by alias); 24 Jul 2002 08:00:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19229 invoked from network); 24 Jul 2002 08:00:15 -0000
Message-ID: <3D3E5EE3.874A9705@certum.pl>
Date: Wed, 24 Jul 2002 01:00:00 -0000
From: Jacek Trzcinski <jacek@certum.pl>
Reply-To: jacek@certum.pl
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: serial patch - second attempt
References: <3D327F4D.C8E80EB8@certum.pl> <20020723165007.E13588@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00144.txt.bz2

Hi !
I think that there is a problem with this name. In case of serial
initialization (in method fhandler_serial::open()) it could be utilized
because its goal is connected with name - it initializes RTS and DTR
serial lines. Problem is in method fhandler_serial::ioctl().
Conditional paths utilized by me are concerned with the fact that under
NT , native serial device driver supports reading of RTS and DTR lines
by DeviceIoControl() function. Under 9x native serial driver does not
support it so utilized variables dsr and rts, setting in different
places of fhandler_serial.cc. Thus in my opinion, saying
"must_init_serial_line" in ioctl() method is not accurate because there
is none initialization there.

Jacek

Corinna Vinschen wrote:
> 
> On Mon, Jul 15, 2002 at 09:52:45AM +0200, Jacek Trzcinski wrote:
> > 13 July 2002 Jacek Trzcinski <jacek@certum.pl>
> >
> >     * fhandler.h (class fhandler_serial): Add new members of
> >     the class - rts,dtr and method ioctl(). Variables rts and dtr
> >     important for Win 9x only.
> >     * fhandler_serial.cc (fhandler_serial::open): Add initial setting
> >     of dtr and rts. Important for Win 9x only.
> >     (fhandler_serial::ioctl): New function. Implements commands TIOCMGET,
> >     TIOCMSET and TIOCINQ.
> >     (fhandler_serial::tcflush): Fixed found error.
> >     (fhandler_serial::tcsetattr): Add settings of rts and dtr. Important
> >     for Win 9x only.
> >     * termios.h: Add new defines as a support for ioctl() function
> >     on serial device.
> 
> It's applied.  Today I've changed the
> 
>         if (!wincap.is_winnt ())
> 
> to using a new capability
> 
>         if (wincap.must_init_serial_line ())
> 
> which is set to true for each 9x/Me, to false for NT/2K/XP.
> 
> If you think that the name of the new capability is inappropriate,
> please suggest another name.
> 
> Corinna
> 
> --
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Developer                                mailto:cygwin@cygwin.com
> Red Hat, Inc.
