Return-Path: <cygwin-patches-return-3640-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8103 invoked by alias); 27 Feb 2003 18:44:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8092 invoked from network); 27 Feb 2003 18:44:00 -0000
Date: Thu, 27 Feb 2003 18:44:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: interruptable connect
Message-ID: <20030227184354.GC24097@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0302271616590.314-200000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0302271616590.314-200000@algeria.intern.net>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00289.txt.bz2

On Thu, Feb 27, 2003 at 04:21:33PM +0100, Thomas Pfaff wrote:
> +      /* Unset events for connecting socket and
> +         switch back to blocking mode */
> +      WSAEventSelect (get_socket (), ev[0], 0);

Just a question:  Shouldn't it be ok to call WSACloseEvent() already at this
point?  This would eliminate the need for the `goto done;', also in the
accept() code.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
