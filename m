Return-Path: <cygwin-patches-return-1701-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26188 invoked by alias); 14 Jan 2002 23:43:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26172 invoked from network); 14 Jan 2002 23:43:57 -0000
Date: Mon, 14 Jan 2002 15:43:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/w32api ChangeLog include/winnt.h
Message-ID: <20020115004355.M2015@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <20020115001207.K2015@cygbert.vinschen.de> <20020114233300.88722.qmail@web14502.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114233300.88722.qmail@web14502.mail.yahoo.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00058.txt.bz2

On Tue, Jan 15, 2002 at 10:33:00AM +1100, Danny Smith wrote:
>  --- Corinna Vinschen <cygwin-patches@cygwin.com> wrote: > On Tue, Jan 15,
> > Oh, btw., I put it into winnt.h since all FILE_ATTRIBUTE_* defines
> > are in winnt.h.  MSDN requires INVALID_FILE_ATTRIBUTES to be in
> > winbase.h.  Do you think I should move it?
> 
> No, the doc cited above says that the function GetFileAttributes is in
> winbase.h.  It doesn't say where the defines are. I think they should be
> kept together. If you move INVALID, then should also move the valid ones as
> well. Hmm,I wonder why they didn't call it FILE_ATTRIBUTE_INVALID ?

Too logical?  Too easy?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
