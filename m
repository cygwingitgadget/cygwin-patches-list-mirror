Return-Path: <cygwin-patches-return-2580-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7319 invoked by alias); 2 Jul 2002 09:37:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7301 invoked from network); 2 Jul 2002 09:37:18 -0000
Date: Tue, 02 Jul 2002 02:37:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to pass file descriptors
Message-ID: <20020702113716.K23555@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.LNX.4.33.0207011735010.2716-100000@this> <06d801c2214d$f155ddd0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06d801c2214d$f155ddd0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00028.txt.bz2

On Mon, Jul 01, 2002 at 11:23:35PM +0100, Conrad Scott wrote:
> Unless anyone has any objection, if you send this to the list, I'll
> put it into the cygwin_daemon branch. It's not a complete or final

I have objections.  This is neither fully discussed nor is it clear
how to incorporate the call together with the cygserver-less descriptor
passing code into fhandler_socket.cc so far.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
