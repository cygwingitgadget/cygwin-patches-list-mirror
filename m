Return-Path: <cygwin-patches-return-2637-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24469 invoked by alias); 12 Jul 2002 07:55:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24317 invoked from network); 12 Jul 2002 07:55:32 -0000
Date: Fri, 12 Jul 2002 00:55:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Jacek Trzcinski <jacek@certum.pl>
Subject: Re: Assignment received from Jacek Trzcinski
Message-ID: <20020712095524.E10982@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com,
	Jacek Trzcinski <jacek@certum.pl>
References: <20020711170416.GA29920@redhat.com> <3D2E872F.476FBDEC@certum.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2E872F.476FBDEC@certum.pl>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00085.txt.bz2

On Fri, Jul 12, 2002 at 09:37:19AM +0200, Jacek Trzcinski wrote:
> 23 May 2001 Jacek Trzcinski <jacek@certum.pl>
> 
>     * cygwin/fhandler.h: new members of fhandler_serial class - rts,
>     dtr and method ioctl()
>     * cygwin/fhandler_serial.cc: implementation of ioctl method from
>     fhandler_serial class. It supports three commands - TIOCMGET,TIOCMSET
>     and TIOCINQ. Changes made in other methods of the class caused either
>     by found error (in method tcflush) or by necessity implementation of
>     TIOCMGET(for RTS and DTR signal) in Windows 9x environment.
>     * cygwin/include/sys/termios.h: new constants added to support
>     ioctl method from class fhandler_serial

Hi Jacek,

could you please look over your ChangeLog entry again?

- Begin capitalized after the colon.
- Finish sentence with a full stop.
- Tell briefly what has changed, not why.
- Tell it for each function.
- The ChangeLog file is in the cygwin directory so don't mention
  the cygwin/ prefix before each file.

Example:

	* fhandler_serial.cc (fhandler_serial::fhandler_serial): Add
	initialization of dtr and rts.
	(fhandler_serial::ioctl): New function.

Either way, it would be nice if your changes would match current CVS
regardless what Chris said.  Quote: "If your patch is against the
current cvs source we will review it ASAP.  If it isn't, it will
take a little longer..."

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
