Return-Path: <cygwin-patches-return-3622-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3902 invoked by alias); 25 Feb 2003 11:58:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3893 invoked from network); 25 Feb 2003 11:58:50 -0000
Date: Tue, 25 Feb 2003 11:58:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: mkpasswd & mkgroup
Message-ID: <20030225115847.GO1677@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030224232915.007f5530@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030224232915.007f5530@mail.attbi.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00271.txt.bz2

On Mon, Feb 24, 2003 at 11:29:15PM -0500, Pierre A. Humblet wrote:
> Corinna,
> 
> Earlier I have added a -c switch to mkpasswd & mkgroup. 
> It prints the current user (if a domain account), without 
> contacting the PDC. 
> That was meant for use in postinstall scripts.
> 
> However until setup.exe is upgraded, only mkpasswd -l will
> be run by passwd-grp.bat, which causes recurring problems with
> domain users. 
> 
> Thus, at least until setup.exe is upgraded, I suggest that
> -c be implied by -l, unless -d is also specified.
> This is implemented by the attached patch.
> It pretty much insure that the main users will have proper entries.

What is the impact for setup.exe?  In my eyes the change is fine
and could be kept this way.  It wouldn't require any change to
setup.exe and *especially* it would'n be good to change mkpasswd
and mkgroup for a short period of time just to revert the patch
a few days (I'm an optimist) later.

So, either we just keep mkpasswd and mkgroup now as it is, or we
make sure that setup.exe won't rely on the -c flag in the next
version but just uses -l as today.

> Also, to support arbitrary uid's on Win95, mkpasswd prints both
> a default line with uid 500, and a line for the current user 
> with a pseudorandom uid. Other users can be added with -u.
> Cygwin uses the default line for users that do not have an entry.

That's fine.  Regardless of the above, we could apply this one.
Feel free to commit that change.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
