Return-Path: <cygwin-patches-return-2557-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18720 invoked by alias); 1 Jul 2002 11:36:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18706 invoked from network); 1 Jul 2002 11:35:58 -0000
Date: Mon, 01 Jul 2002 04:36:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] interruptable accept
Message-ID: <20020701133556.G20028@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0207011223180.359-200000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0207011223180.359-200000@algeria.intern.net>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00005.txt.bz2

On Mon, Jul 01, 2002 at 01:12:24PM +0200, Thomas Pfaff wrote:
> 
> This patch is not 100% perfect and could be done better (faster response
> on incoming signal) with async Events but this would require a much larger
> patch (Call AsyncEventSelect, WaitForMultipleObjects (socket and signal),
> check for pending connection and set socket back to blocking mode).

Do you mean WSAEventSelect?  Would that be actually that big a patch?  
I'm not quite sure if a busy loop is a better solution.

> 2002-07-01  Thomas Pfaff  <tpfaff@gmx.net>
> 
> 	*net.cc: Include select.h
> 	(cygwin_accept): If socket is nonblocking check for a pending
> 	signal every 100ms.

Ahem, did you have a look into the current CVS sources?  Your patch
isn't against the latest from CVS.  I've moved most of the socket
funtionality into the fhandler_socket class the week before.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
