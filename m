Return-Path: <cygwin-patches-return-5321-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6155 invoked by alias); 25 Jan 2005 22:38:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6083 invoked from network); 25 Jan 2005 22:38:41 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.112.219)
  by sourceware.org with SMTP; 25 Jan 2005 22:38:41 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 8912C57D73; Tue, 25 Jan 2005 23:38:39 +0100 (CET)
Date: Tue, 25 Jan 2005 22:38:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: setting errno to ENOTDIR rather than ENOENT
Message-ID: <20050125223839.GI31117@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <41F6B1F6.5207C318@phumblet.no-ip.org> <20050125212445.GG31117@cygbert.vinschen.de> <41F6C1AD.AD2FFAC0@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F6C1AD.AD2FFAC0@phumblet.no-ip.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00024.txt.bz2

On Jan 25 17:01, Pierre A. Humblet wrote:
> Ah, I see your message on the list.
> 
> You found out that
>   lstat("dir/x")  with dir non-existing. => ENOENT
> 
> So
> >               if (pcheck_case == PCHECK_STRICT)
> >                 {
> >                   case_clash = true;
> > > -                 error = ENOENT;
> > > +                 error = component?ENOTDIR:ENOENT;
> 
> shouldn't be done after all. OK?

Erm... yes, that sounds right.  After all the case_clash means that the
directory component doesn't exist.


Thanks for catching this,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
