Return-Path: <cygwin-patches-return-1636-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25360 invoked by alias); 28 Dec 2001 14:39:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25343 invoked from network); 28 Dec 2001 14:39:44 -0000
Message-ID: <3C2C8436.9C672C84@yahoo.com>
Date: Fri, 09 Nov 2001 04:48:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: cygwin-patches@sourceware.cygnus.com
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
CC: cygwin-patches@sourceware.cygnus.com
Subject: Re: [PATCH] Setup.exe "other URL" functionality
References: <NCBBIHCHBLCMLBLOBONKGEBKCIAA.g.r.vansickle@worldnet.att.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2001-q4/txt/msg00168.txt.bz2

"Gary R. Van Sickle" wrote:
> 
> > Thanks. BTW: If you can identify what made that huge patch (my money is
> > on indent 2.2.7 inserting ^M's)'s that would be handy.
> >
> > Rob
> 
> It's highly bizarre, but AFAICT it's not indent but rather something wrong with
> "cvs diff".  Here's my investigation so far, I'm on all text mounts:
> 

That would be the problem.  You need to switch to binary mounts or
modify the CVS code to do the right thing.


> So I guess I'm out of WAGes now, unless cvs is tracking the file-moving and
> claiming that a file with, say, the same contents but a different creation date
> or something is completely different, regardless of contents.  But I don't think
> that would explain the initial problem because I never moved any files.
> 

There's nothing to WAG, \n to \r\n conversion is happening because of
your text mounts and now CVS or rather `cvs diff' sees the differences.

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

