Return-Path: <cygwin-patches-return-5366-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14051 invoked by alias); 4 Mar 2005 08:37:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13939 invoked from network); 4 Mar 2005 08:36:53 -0000
Received: from unknown (HELO cygbert.vinschen.de) (84.148.33.203)
  by sourceware.org with SMTP; 4 Mar 2005 08:36:53 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 8B8D057D6E; Fri,  4 Mar 2005 09:36:51 +0100 (CET)
Date: Fri, 04 Mar 2005 08:37:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: fhandler_socket::ioctl
Message-ID: <20050304083651.GA18994@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050303233658.00b50ad0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20050303233658.00b50ad0@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00069.txt.bz2

On Mar  3 23:36, Pierre A. Humblet wrote:
> 2005-03-04  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* fhandler_socket.cc (fhandler_socket::ioctl): Only cancel 
>  	 WSAAsyncSelect when async mode is on.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
