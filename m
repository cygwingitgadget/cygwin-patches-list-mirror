Return-Path: <cygwin-patches-return-1584-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24511 invoked by alias); 14 Dec 2001 15:17:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24495 invoked from network); 14 Dec 2001 15:17:53 -0000
Date: Sat, 03 Nov 2001 22:09:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf packages]
Message-ID: <20011214161713.P740@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <m3zo4x7obb.fsf@appel.lilypond.org> <m38zcdssxd.fsf@appel.lilypond.org> <01a801c18036$3d447350$0200a8c0@lifelesswks> <m3itbhqowz.fsf@appel.lilypond.org> <027001c18040$c91651f0$0200a8c0@lifelesswks> <m3wuzth3l1.fsf@appel.lilypond.org> <04db01c18302$e66cae60$0200a8c0@lifelesswks> <m3667ax540.fsf@appel.lilypond.org> <20011213215355.GA20040@redhat.com> <3C19F354.1E85323C@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C19F354.1E85323C@yahoo.com>; from earnie_boyd@yahoo.com on Fri, Dec 14, 2001 at 07:40:52AM -0500
X-SW-Source: 2001-q4/txt/msg00116.txt.bz2

On Fri, Dec 14, 2001 at 07:40:52AM -0500, Earnie Boyd wrote:
> Christopher Faylor wrote:
> > 
> > I believe that the prompt reflects DJ Delorie's prompt preference, which
> > was, apparently, two lines.
> > 
> 
> I agree, although I don't dislike it.
> 
> > *I'd* prefer no prompt setting at all, actually.  I think that prompt
> > setting should be up to the user or the local sysadmin.  AFAICT, even
> > Red Hat doesn't try to make a prompt decision for you.
> > 
> 
> I'd prefer no prompt setting also by default but leave the PS1 commented
> out for an example of use.  The problem with the current PS1 is that
> it's SHELL specific, I.E.: it only works in bash.

Agree.  I'm still for giving a nice PS1 by default (aka not '$ ')
but it should get simplified so that it works for all bourne shell
clones.

In general a question raises (again, perhaps?):  Shouldn't we provide
a default /etc/csh.login file as well?  At least as part of the tcsh
package?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
