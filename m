Return-Path: <cygwin-patches-return-2933-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31007 invoked by alias); 4 Sep 2002 09:39:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30988 invoked from network); 4 Sep 2002 09:39:49 -0000
Date: Wed, 04 Sep 2002 02:39:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: readv/writev patch for sockets
Message-ID: <20020904113947.F1213@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <003c01c25350$b10c0800$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003c01c25350$b10c0800$6132bc3e@BABEL>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00381.txt.bz2

On Tue, Sep 03, 2002 at 02:49:14PM +0100, Conrad Scott wrote:
> 2002-09-03  Conrad Scott  <conrad.scott@dsl.pipex.com>
> 
> 	* fhandler.h (fhandler_socket::read): Remove method.
> 	(fhandler_socket::write): Ditto.
> 	(fhandler_socket::readv): New method.
> 	(fhandler_socket::writev): Ditto.
> 	(fhandler_socket::recvmsg): Add new optional argument.
> 	(fhandler_socket::sendmsg): Ditto.
> 	* fhandler.cc (fhandler_socket::read): Remove method.
> 	(fhandler_socket::write): Ditto.
> 	(fhandler_socket::readv): New method.
> 	(fhandler_socket::writev): Ditto.
> 	(fhandler_socket::recvmsg): Use win32's scatter/gather IO where
> 	possible.
> 	(fhandler_socket::sendmsg): Ditto.
> 	* net.cc (cygwin_recvmsg): Check the msghdr's iovec fields.
> 	(cygwin_sendmsg): Ditto.  Add omitted sigframe.

Applied.

Thanks!
Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
