Return-Path: <cygwin-patches-return-4844-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28399 invoked by alias); 23 Jun 2004 07:36:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28372 invoked from network); 23 Jun 2004 07:36:29 -0000
Date: Wed, 23 Jun 2004 07:36:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: rlogin problems
Message-ID: <20040623073630.GA15652@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040622225313.008093a0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040622225313.008093a0@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00196.txt.bz2

On Jun 22 22:53, Pierre A. Humblet wrote:
> 
> 2004-06-23  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* fhandler_socket.cc (fhandler_socket::release): Call
> 	WSASetLastError last.


Thanks for this patch!  I've just applied it.  Very weird that this
only affected 9x.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
