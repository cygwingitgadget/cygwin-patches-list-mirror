Return-Path: <cygwin-patches-return-4256-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26838 invoked by alias); 27 Sep 2003 02:36:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26829 invoked from network); 27 Sep 2003 02:36:02 -0000
Date: Sat, 27 Sep 2003 02:36:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add support for ioctl TIOCLINUX, function 6 (get key modifiers) on a TTY
Message-ID: <20030927023558.GA17011@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <10117.1059699425@www61.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10117.1059699425@www61.gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00272.txt.bz2

On Fri, Aug 01, 2003 at 02:57:05AM +0200, Pavel Tsekov wrote:
>2003-08-01  Pavel Tsekov  <ptsekov@gmx.net>
>
>	* fhandler_console.c (fhandler_console::read): Record the state of the
>	SHIFT, CTRL and ALT keys at the time of the last keyboard input event.
>	(fhandler_console::ioctl): Handle requests to retrieve the keyboard
>	modifiers via the TIOCLINUX command.
>	* fhandler_tty.c (fhandler_tty_slave::read): Ditto.
>	* include/sys/termios.h (TIOCLINUX): New macro definition.

After some delay, I've applied this patch.

Thanks,
cgf
