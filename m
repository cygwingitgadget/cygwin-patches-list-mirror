Return-Path: <cygwin-patches-return-2871-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7993 invoked by alias); 27 Aug 2002 09:25:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7798 invoked from network); 27 Aug 2002 09:24:59 -0000
Date: Tue, 27 Aug 2002 02:25:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_socket & sigframe patch
Message-ID: <20020827112453.A1352@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <015b01c24d09$50499840$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015b01c24d09$50499840$6132bc3e@BABEL>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00319.txt.bz2

On Mon, Aug 26, 2002 at 03:03:10PM +0100, Conrad Scott wrote:
> 2002-08-26  Conrad Scott  <conrad.scott@dsl.pipex.com>
> 
> 	* fhandler_socket.cc (fhandler_socket::check_peer_secret_event):
> 	Fix strace message.
> 	(fhandler_socket::connect): Remove sigframe.
> 	(fhandler_socket::accept): Ditto.
> 	(fhandler_socket::getsockname): Ditto.
> 	(fhandler_socket::getpeername): Ditto.
> 	(fhandler_socket::recvfrom): Ditto.
> 	(fhandler_socket::recvmsg): Ditto.
> 	(fhandler_socket::sendto): Ditto.
> 	(fhandler_socket::sendmsg): Ditto.
> 	(fhandler_socket::close): Ditto.
> 	(fhandler_socket::ioctl): Ditto.
> 	* ioctl.cc (ioctl): Add sigframe.
> 	*net.cc (cygwin_sendto): Ditto.
> 	(cygwin_recvfrom): Ditto.
> 	(cygwin_recvfrom): Ditto.
> 	(cygwin_connect): Ditto.
> 	(cygwin_shutdown): Ditto.
> 	(cygwin_getpeername): Ditto.
> 	(cygwin_accept): Ditto.  Improve strace message.
> 	(cygwin_getsockname): Ditto.  Ditto.
> 	(cygwin_recvmsg): Ditto.  Ditto.
> 	(cygwin_sendmsg): Fix strace message.

Thanks!  Applied.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
