Return-Path: <cygwin-patches-return-3035-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23319 invoked by alias); 24 Sep 2002 07:21:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23303 invoked from network); 24 Sep 2002 07:21:45 -0000
Date: Tue, 24 Sep 2002 00:21:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_tty doecho change
Message-ID: <20020924092143.J29920@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020924015053.A21742@eris.io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020924015053.A21742@eris.io.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00483.txt.bz2

On Tue, Sep 24, 2002 at 01:50:54AM -0500, Steve O wrote:
> Hi,
> A week or so ago, I found that rxvt hangs could be fixed by making
> the tty pipe non-blocking.  As I look into this more, I discovered
> that fhandler_pty_master::doecho uses the slave's side of the
> pipe to accomplish echoing characters to the terminal.  A clever
> and simple solution, but it causes a deadlock when the slave's 
> write pipe is full.  
> 
> The solution presented in this patch is to use a buffer to store the
> echo characters, similar to the readahead buffer.  I wanted to use
> the readahead buffer, but convinced myself that the data was 
> different enough that folding it in would create more complex code
> than necessary. 
> 
> Fixing this deadlock revealed a deadlock in the 
> fhandler_pty_master::accept_input code which will be the subject of 
> my next patch.

This looks interesting but is actually missing a ChangeLog entry.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
