Return-Path: <cygwin-patches-return-4846-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15111 invoked by alias); 23 Jun 2004 16:20:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15090 invoked from network); 23 Jun 2004 16:20:50 -0000
Date: Wed, 23 Jun 2004 16:20:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: rlogin problems
Message-ID: <20040623162052.GA19239@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040622225313.008093a0@incoming.verizon.net> <20040623073630.GA15652@cygbert.vinschen.de> <40D9AA56.8040802@etr-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D9AA56.8040802@etr-usa.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00198.txt.bz2

On Jun 23 10:05, Warren Young wrote:
> Corinna Vinschen wrote:
> >Very weird that this only affected 9x.
> [...]
> So, under Win2K+ and possibly WinNT as well, any system call should 
> reset the system error code, as happens with errno on that other class 
> of OSes.  That's why you have to set it after the WSACloseEvent() call.

Hmm.  It works on XP (and probably also 2K) even though WSACloseEvent
is called after setting the WSA error code.  So it seems the other way
around.  The successful call to WSACloseEvent does *not* reset the
error code.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
