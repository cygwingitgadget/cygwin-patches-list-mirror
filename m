Return-Path: <cygwin-patches-return-4531-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17995 invoked by alias); 23 Jan 2004 15:16:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17978 invoked from network); 23 Jan 2004 15:16:21 -0000
Date: Fri, 23 Jan 2004 15:16:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: secret event
Message-ID: <20040123151621.GC10708@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040122183313.00839860@incoming.verizon.net> <20040123095952.GC12512@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123095952.GC12512@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00021.txt.bz2

On Fri, Jan 23, 2004 at 10:59:52AM +0100, Corinna Vinschen wrote:
>On Jan 22 18:33, Pierre A. Humblet wrote:
>> 2004-01-22  Pierre Humblet <pierre.humblet@ieee.org>
>> 
>> 	* fhandler_socket.cc (fhandler_socket::create_secret_event): Avoid
>> 	creating multiple handles. Always allow event inheritance but set the
>> 	handle inheritance appropriately. Improve error handling.
>> 	(fhandler_socket::check_peer_secret_event): Improve error handling.
>> 	(fhandler_socket::close_secret_event): Simply call CloseHandle.
>> 	(fhandler_socket::set_close_on_exec): Set secret event inheritance.
>
>Looks good.  Please check it in.

I agree, with one nit.  Was there a reason for getting rid of the handle
protection in this patch?  We are apparently stumbling over a problem with
handle corruption in the current CVS so removing a chance for protection
seems like we're going backwards.

cgf
