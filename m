Return-Path: <cygwin-patches-return-1700-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19593 invoked by alias); 14 Jan 2002 23:33:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19579 invoked from network); 14 Jan 2002 23:33:00 -0000
Message-ID: <20020114233300.88722.qmail@web14502.mail.yahoo.com>
Date: Mon, 14 Jan 2002 15:33:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: Re: src/winsup/w32api ChangeLog include/winnt.h
To: Corinna Vinschen <cygwin-patches@cygwin.com>
In-Reply-To: <20020115001207.K2015@cygbert.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q1/txt/msg00057.txt.bz2

 --- Corinna Vinschen <cygwin-patches@cygwin.com> wrote: > On Tue, Jan 15,
2002 at 12:07:46AM +0100, cygpatch wrote:
> >
>
http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/filesio_9pgz.asp

Thanks. Google didn't find that for me.

> 
> Oh, btw., I put it into winnt.h since all FILE_ATTRIBUTE_* defines
> are in winnt.h.  MSDN requires INVALID_FILE_ATTRIBUTES to be in
> winbase.h.  Do you think I should move it?
> 

No, the doc cited above says that the function GetFileAttributes is in
winbase.h.  It doesn't say where the defines are. I think they should be
kept together. If you move INVALID, then should also move the valid ones as
well. Hmm,I wonder why they didn't call it FILE_ATTRIBUTE_INVALID ?


http://my.yahoo.com.au - My Yahoo!
- It's My Yahoo! Get your own!
