Return-Path: <cygwin-patches-return-4526-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24555 invoked by alias); 23 Jan 2004 09:59:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24471 invoked from network); 23 Jan 2004 09:59:53 -0000
Date: Fri, 23 Jan 2004 09:59:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: secret event
Message-ID: <20040123095952.GC12512@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040122183313.00839860@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040122183313.00839860@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00016.txt.bz2

On Jan 22 18:33, Pierre A. Humblet wrote:
> 2004-01-22  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* fhandler_socket.cc (fhandler_socket::create_secret_event): Avoid
> 	creating multiple handles. Always allow event inheritance but set the
> 	handle inheritance appropriately. Improve error handling.
> 	(fhandler_socket::check_peer_secret_event): Improve error handling.
> 	(fhandler_socket::close_secret_event): Simply call CloseHandle.
> 	(fhandler_socket::set_close_on_exec): Set secret event inheritance.

Looks good.  Please check it in.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
