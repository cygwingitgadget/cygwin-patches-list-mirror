Return-Path: <cygwin-patches-return-2784-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6916 invoked by alias); 7 Aug 2002 10:08:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6899 invoked from network); 7 Aug 2002 10:08:42 -0000
Date: Wed, 07 Aug 2002 03:08:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_socket::accept() and FIONBIO
Message-ID: <20020807120840.A3921@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01de01c23da2$f1ead310$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01de01c23da2$f1ead310$6132bc3e@BABEL>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00232.txt.bz2

On Wed, Aug 07, 2002 at 12:42:36AM +0100, Conrad Scott wrote:
> I've attached a tiny patch to fix the win98 / WSAENOBUFS problem
> reported in
> http://cygwin.com/ml/cygwin-developers/2002-07/msg00167.html
> (amongst other places).

Thanks for tracking that down!  Applied.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
