Return-Path: <cygwin-patches-return-5603-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11890 invoked by alias); 2 Aug 2005 09:18:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11867 invoked by uid 22791); 2 Aug 2005 09:18:14 -0000
Received: from p54941596.dip0.t-ipconnect.de (HELO calimero.vinschen.de) (84.148.21.150)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 02 Aug 2005 09:18:14 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DE11A6D4256; Tue,  2 Aug 2005 11:18:11 +0200 (CEST)
Date: Tue, 02 Aug 2005 09:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] TIOCMBI[SC]
Message-ID: <20050802091811.GM14783@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050801111552.GA2844@efn.org> <20050801165639.GK14783@calimero.vinschen.de> <20050801192510.GA3656@efn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801192510.GA3656@efn.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q3/txt/msg00058.txt.bz2

On Aug  1 12:25, Yitzchak Scott-Thoennes wrote:
> On Mon, Aug 01, 2005 at 06:56:39PM +0200, Corinna Vinschen wrote:
> > On Aug  1 04:15, Yitzchak Scott-Thoennes wrote:
> > > I don't have a serial device to test this with, but it's just selected
> > > parts of the TIOCMSET handling slightly adapted.
> > 
> > I'm not serial I/O savvy, but the change looks pretty much ok.  I'm just
> > not exactly glad that the functionality itself is duplicated.  Would you
> > mind a rewrite so that the functionality is not copied, for instance by
> > creating a private method which does it, or by recursively calling
> > fhandler_serial::ioctl() with tweaked arguments (TIOCMSET)?
> 
> No problem.  How does this look?
> 
> 2005-08-01  Yitzchak Scott-Thoennes  <sthoenna@efn.org>
> 
> 	* include/sys/termios.h: Define TIOCMBIS and TIOCMBIC.
>         * fhandler.h (class fhandler_serial): Declare switch_modem_lines.
> 	* fhandler_serial.cc (fhandler_serial::switch_modem_lines): New
>         static function to set or clear DTR and/or RTS.
>         (fhandler_serial::ioctl): Use switch_modem_lines for TIOCMSET
>         and new TIOCMBIS and TIOCMBIC.

Thanks, applied.  I've also bumped the API minor version number in
include/cygwin/version.h.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
