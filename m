Return-Path: <cygwin-patches-return-3328-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10763 invoked by alias); 16 Dec 2002 16:01:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10753 invoked from network); 16 Dec 2002 16:01:24 -0000
Date: Mon, 16 Dec 2002 08:01:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] to_slave pipe is full fix
Message-ID: <20021216170122.G19104@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021215144314.A28430@eris.io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021215144314.A28430@eris.io.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00279.txt.bz2

Hi Steve,

On Sun, Dec 15, 2002 at 02:43:14PM -0600, Steve O wrote:
> Hi,
> Here is the next tty patch.  The previous patches have provided
> the ground work for accept_input () to fail.  This patch makes accept_input
> fail if the slave tty pipe is full.  In the current cygwin code this
> will only get called in rather extreme situations. 
> 
> Thanks,
> -steve
> 
> ChangeLog:
> 2002-12-15  Steve Osborn  <bub@io.com>
> 
> 	* fhandler_termios.cc (fhandler_termios::line_edit): Return 
> 	line_edit_error and remove last char from readahead buffer 
> 	if accept_input() fails.
> 	* fhandler_tty.cc (fhandler_pty_master::accept_input): Return 0 
> 	and restore readahead buffer when tty slave pipe is full.

did you perhaps forgot to attach the patch?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
