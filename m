Return-Path: <cygwin-patches-return-2429-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4659 invoked by alias); 14 Jun 2002 11:32:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4618 invoked from network); 14 Jun 2002 11:32:17 -0000
Date: Fri, 14 Jun 2002 04:32:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: passwd edited /etc/passwd patch
Message-ID: <20020614133215.D30892@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <20020613180714.N30892@cygbert.vinschen.de> <20020614040411.54096.qmail@web20003.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020614040411.54096.qmail@web20003.mail.yahoo.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00412.txt.bz2

On Thu, Jun 13, 2002 at 09:04:11PM -0700, Joshua Daniel Franklin wrote:
> --- Corinna Vinschen <cygwin-patches@cygwin.com> wrote:
> > On Tue, Jun 11, 2002 at 08:18:15PM -0500, Joshua Daniel Franklin wrote:
> > > +  /* Try getting a Win32 username in case the user edited /etc/passwd */
> > > +  if (ret == NERR_UserNotFound)
> > > +  {
> > > +    if ((pw = getpwnam (user)))
> > > +      cygwin_internal (CW_EXTRACT_DOMAIN_AND_USER, pw, domain, (char *)
> > user);
> > 
> > Thanks for the patch but, hmm, I think I'd prefer to look always for
> > the Cygwin username first.
> > It's unlikely and probably just an academic case but you could have
> > the Cygwin username user_a for the windows user user_b and vice versa.
> > 
> 
> Umm...kay. I was trying to avoid the extra system call, but I guess it
> probably won't make much difference. I'm having build problems right now 
> but I think this patch will do what you're asking. 

Applied.  I've checked in some additional changes.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
