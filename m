Return-Path: <cygwin-patches-return-3926-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10258 invoked by alias); 6 Jun 2003 09:23:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10023 invoked from network); 6 Jun 2003 09:23:36 -0000
Date: Fri, 06 Jun 2003 09:23:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Return correct error code on subsequent nonblocking connect
Message-ID: <20030606092335.GG875@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0306061046440.1372-200000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0306061046440.1372-200000@algeria.intern.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00153.txt.bz2

On Fri, Jun 06, 2003 at 11:11:00AM +0200, Thomas Pfaff wrote:
> 	* fhandler_socket.cc (fhandler_socket::connect): Change error
> 	handling for nonblocking connects to return EALREADY when
> 	connect is called more than once for the same socket.

Ok with me.  Please apply.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
