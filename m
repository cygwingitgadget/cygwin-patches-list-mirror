Return-Path: <cygwin-patches-return-2266-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4475 invoked by alias); 30 May 2002 07:17:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4449 invoked from network); 30 May 2002 07:17:41 -0000
Date: Thu, 30 May 2002 00:17:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: passwd help/version patch
Message-ID: <20020530091739.W30892@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <20020529091720.G30892@cygbert.vinschen.de> <20020530002630.44094.qmail@web20003.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020530002630.44094.qmail@web20003.mail.yahoo.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00249.txt.bz2

On Wed, May 29, 2002 at 05:26:30PM -0700, Joshua Daniel Franklin wrote:
> --- Corinna Vinschen <cygwin-patches@cygwin.com> wrote:
> > Or perhaps change passwd to take the Cygwin name and
> > convert it to the windows name???
> > 
> > Corinna
> 
> Maybe I'm missing something, but there doesn't seem to be any Win32 
> function to get a username from a uid other than NetUserEnum, but 
> I really don't think people running 'passwd bob' are wanting to enum
> all users. The code to do it wouldn't be that hard, but it wouldn't
> work for those people with domains (unless they specify a domain like
> for mkpasswd).
> 
> Maybe mkpasswd should cache the info somewhere other than just /etc/passwd 
> for this purpose? Or use the GECOS field?

I'm sorry if my mail wasn't clear but I just asked for getting the
Win32 name from the cygwin name.  The cygwin name is the one given
on the command line or what is returned by getlogin().  The information
about the Win32 name is then returned in the pw_gecos field by
getpwnam().  Either a U-DOMAIN\NAME or a S-1-5-xxx sid.  If the
U- field is given, it contains the name, otherwise a LookupAccountSid()
gives the Win32 name from the SID.  If neither is given, the Cygwin
username is equal to the Win32 name.

There is already a function `extract_nt_dom_user()' in Cygwin, file
security.cc which contains this functionality.  Unfortunately it
isn't exported so it would have to be copied to passwd.c (and
transformed to plain c). 

Or we export that function.  I think it is a useful functionality for
Cygwin tools.  Perhaps with the "cygwin_" prefix.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
