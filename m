Return-Path: <cygwin-patches-return-1526-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 27507 invoked by alias); 27 Nov 2001 18:32:08 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 27444 invoked from network); 27 Nov 2001 18:32:03 -0000
Date: Wed, 17 Oct 2001 06:03:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Sergey Okhapkin <sos@prospect.com.ru>
Cc: cygwin-patches@sourceware.cygnus.com
Subject: Re: shutdown sockets on exit patch
Message-ID: <20011127193031.Q14975@cygbert.vinschen.de>
Mail-Followup-To: Corinna Vinschen <cygwin-patches@cygwin.com>,
	Sergey Okhapkin <sos@prospect.com.ru>,
	cygwin-patches@sourceware.cygnus.com
References: <001b01c1776b$0ad3c020$02af6080@cc.telcordia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001b01c1776b$0ad3c020$02af6080@cc.telcordia.com>; from sos@prospect.com.ru on Tue, Nov 27, 2001 at 12:43:36PM -0500
X-SW-Source: 2001-q4/txt/msg00058.txt.bz2

On Tue, Nov 27, 2001 at 12:43:36PM -0500, Sergey Okhapkin wrote:
> Hi!
> 
> The patch attached implements gracefull socket shutdown on application exit.
> Rexecd from inetutils package do not print an annoying message now. Corinna,
> I didn't test the fix with rshd, test it please!

I tried it.  Rexecd, rshd, sshd (and scp) seem to work fine but the
following new errors occur now:

- Calling `dir' in an ftp connection to the Windows box works but
  after finishing the connection is closed and the message
  "421 Service not available, remote server has closed connection."
  is printed.

- Connecting from the Windows box to a host using ssh with X11
  forwarding activated fails with error
  "Write failed: errno ESHUTDOWN triggered"

This is probably due to the child processes calling shutdown on the
socket on exit.

Corinna
  
-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
