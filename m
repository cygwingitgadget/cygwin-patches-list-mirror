Return-Path: <cygwin-patches-return-5201-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2285 invoked by alias); 14 Dec 2004 12:02:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2241 invoked from network); 14 Dec 2004 12:02:27 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.112.111)
  by sourceware.org with SMTP; 14 Dec 2004 12:02:27 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 78DF95808C; Tue, 14 Dec 2004 13:04:35 +0100 (CET)
Date: Tue, 14 Dec 2004 12:02:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: change log fix: [Patch] bug # 514 (cygwin console handling)
Message-ID: <20041214120435.GI22056@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <E1CZbmo-0000PC-00@mrelayng.kundenserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CZbmo-0000PC-00@mrelayng.kundenserver.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00202.txt.bz2

On Dec  1 08:16, Thomas Wolff wrote:
> Sorry, I missed to insert the function name in the change log 
> entry, so here it is again as an update; the patch is the same.
> 
> This is a small patch that fixes
>  http://sourceware.org/bugzilla/show_bug.cgi?id=514
> 
> Please integrate it into the cygwin DLL.

I guess the patch is pretty much ok and I'm inclined to let it pass
under the trivial patch rule... iff you change it so that the #ifdef
goes away.  Which alternative seems more appropriate resp. which one
results in the more readable output?  It's the one we should choose
(since any choice will result in complains anyway).

> 2004-11-26  Thomas Wolff  <towo@computer.org>
> 
> * fhandler_console.cc (get_win32_attr): Avoid inappropriate intensity 
>      interchanging that used to render reverse output unreadable 
>      when (non-reversed) text is bright.
>      See http://sourceware.org/bugzilla/show_bug.cgi?id=514
>      There are two useful alternatives to handle this; both are in 
>      the patch (#ifdef reverse_bright) and one is selected by #define:
>      a) (selected) bright foreground will reverse to a bright background,
>      b) bright foreground will reverse to a dim background but 
>         the background will no longer reverse to a bright foreground 
>         (which used to render reverse output unreadable).

And please shorten the ChangeLog entry to about one sentence.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
