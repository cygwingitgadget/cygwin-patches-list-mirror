Return-Path: <cygwin-patches-return-5202-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16101 invoked by alias); 14 Dec 2004 12:17:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16072 invoked from network); 14 Dec 2004 12:17:50 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.112.111)
  by sourceware.org with SMTP; 14 Dec 2004 12:17:50 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 5FAB258092; Tue, 14 Dec 2004 13:19:58 +0100 (CET)
Date: Tue, 14 Dec 2004 12:17:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] bug # 512 (cygwin console handling)
Message-ID: <20041214121958.GJ22056@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <E1CZFaa-00086S-00@mrelayng.kundenserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CZFaa-00086S-00@mrelayng.kundenserver.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00203.txt.bz2

On Nov 30 22:31, Thomas Wolff wrote:
> This is a small patch that fixes
>  http://sourceware.org/bugzilla/show_bug.cgi?id=512
> 
> Please integrate it into the cygwin DLL.
> 
> 2004-11-26  Thomas Wolff  <towo@computer.org>
> 
> * fhandler_console.cc (read) <mouse position detection>: 
>      Considering offset within scrolling region of the DOS box window.
>      See http://sourceware.org/bugzilla/show_bug.cgi?id=512

Thanks, applied with a modified ChangeLog entry.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
