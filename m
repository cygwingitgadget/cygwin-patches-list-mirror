Return-Path: <cygwin-patches-return-2762-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7117 invoked by alias); 2 Aug 2002 11:16:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7100 invoked from network); 2 Aug 2002 11:16:16 -0000
Date: Fri, 02 Aug 2002 04:16:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: The Everyone group
Message-ID: <20020802131614.G3921@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020801215654.0080f950@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020801215654.0080f950@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00210.txt.bz2

On Thu, Aug 01, 2002 at 09:56:54PM -0400, Pierre A. Humblet wrote:
> 3 patches are included: those to syscalls.cc and security.cc
> are minor optimizations related to setgroups. The one to
> grp.cc removes Everyone from the output of getgroups32
> (as if it weren't in /etc/group).

Applied.

> Additionally I would suggest modifying mkpasswd and mkgroup to
> - remove Everyone from the output
> - set the gid of SYSTEM to 544 (instead of 18, which is redundant anyway).
>   Without this, doing setgroups(0, NULL) while running as SYSTEM removes
>   the Administrators group, which is not at all what happens in Unix when
>   running as root.
> If you think it's a good idea I'll get to that in a couple of weeks,
> after some vacations.

It sounds like a good plan.  I'd just like to be careful if nothing
weird happens when removing it from passwd and group.  However, I've
changed mkpasswd and mkgroup already and I've changed my passwd and group
files to test that.

> Note that if Everyone is removed from /etc/group applying the patch to 
> grp.cc makes no difference.

It makes a difference for existing setups so it's better to have it.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
