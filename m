Return-Path: <cygwin-patches-return-5319-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3709 invoked by alias); 25 Jan 2005 22:01:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3690 invoked from network); 25 Jan 2005 22:01:27 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 25 Jan 2005 22:01:27 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id IAW7U7-0000SE-9C
	for cygwin-patches@cygwin.com; Tue, 25 Jan 2005 17:01:19 -0500
Message-ID: <41F6C1AD.AD2FFAC0@phumblet.no-ip.org>
Date: Tue, 25 Jan 2005 22:01:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: setting errno to ENOTDIR rather than ENOENT
References: <41F6B1F6.5207C318@phumblet.no-ip.org> <20050125212445.GG31117@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q1/txt/msg00022.txt.bz2



Corinna Vinschen wrote:
> 
> Well done!  I looked into this a few hours ago and missed how easy a
> solution would be.  *mumbling something about needing glasses*

Ah, I see your message on the list.

You found out that
  lstat("dir/x")  with dir non-existing. => ENOENT

So
>               if (pcheck_case == PCHECK_STRICT)
>                 {
>                   case_clash = true;
> > -                 error = ENOENT;
> > +                 error = component?ENOTDIR:ENOENT;

shouldn't be done after all. OK?

Pierre
