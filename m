Return-Path: <cygwin-patches-return-1696-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9391 invoked by alias); 14 Jan 2002 23:07:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9376 invoked from network); 14 Jan 2002 23:07:51 -0000
Date: Mon, 14 Jan 2002 15:07:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Danny Smith <danny_r_smith_2001@yahoo.co.nz>
Cc: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/w32api ChangeLog include/winnt.h
Message-ID: <20020115000746.J2015@cygbert.vinschen.de>
Mail-Followup-To: Danny Smith <danny_r_smith_2001@yahoo.co.nz>,
	cygpatch <cygwin-patches@cygwin.com>
References: <20020114201534.26518.qmail@sources.redhat.com> <20020114230034.36669.qmail@web14504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114230034.36669.qmail@web14504.mail.yahoo.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00053.txt.bz2

On Tue, Jan 15, 2002 at 10:00:34AM +1100, Danny Smith wrote:
>  --- corinna@cygwin.com wrote: > CVSROOT:	/cvs/src
> > Module name:	src
> > Changes by:	corinna@sources.redhat.com	2002-01-14 12:15:34
> > 
> > Modified files:
> > 	winsup/w32api  : ChangeLog 
> > 	winsup/w32api/include: winnt.h 
> > 
> > Log message:
> > 	* include/winnt.h: Add INVALID_FILE_ATTRIBUTES.
> > 
> 
> Although, I agree that DWORD(-1) is what GetFileAttributes returns on
> error, I can't find any documentation for this define.   Can you help?
> If it is "non-MSDN" w32api define, it should be commented as such.

http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/filesio_9pgz.asp

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
