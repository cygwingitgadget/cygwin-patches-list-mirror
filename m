Return-Path: <cygwin-patches-return-2402-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 904 invoked by alias); 13 Jun 2002 02:12:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 824 invoked from network); 13 Jun 2002 02:12:05 -0000
Date: Wed, 12 Jun 2002 19:12:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin()
Message-ID: <20020613021230.GA26392@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020612205711.007f7300@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020612205711.007f7300@mail.attbi.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00385.txt.bz2

On Wed, Jun 12, 2002 at 08:57:11PM -0400, Pierre A. Humblet wrote:
>/* I just found the mail of Chris from last nite (spend a day
>   on the road) but as all of the following was ready and tested, 
>   I am sending it anyway. Pick what you want. */
>
>As explained previously, the main purpose of the patches is to increase
>performances of servers that fork() and setuid() but do not exec().  In
>particular, the number of accesses to logonservers (either directly, or
>through LookupAccountSid ) is greatly reduced.  The performance of
>programs that setuid() and exec() is improved as well, e.g.  by not
>reading the passwd file in the child.

Yes, and as I explained previously, I didn't really like what you did to
spawn_guts or your additions to environ.cc.  I tried to clear the way
for you not to have to worry about that.  You shouldn't have to worry
about setting most environment variables either.  I see I missed
USERDOMAIN, though.

I like the concept of speeding up things, of course.  However, I don't
understand how this can be right:

>--- dcrt0.cc.orig      2002-06-11 00:05:40.000000000 -0400
>+++ dcrt0.cc   2002-06-12 19:53:06.000000000 -0400
>@@ -608,7 +608,6 @@
>                                 DUPLICATE_SAME_ACCESS | DUPLICATE_CLOSE_SOURCE))
>             h = NULL;
>           set_myself (mypid, h);
>-          myself->uid = spawn_info->moreinfo->uid;
>           __argc = spawn_info->moreinfo->argc;
>           __argv = spawn_info->moreinfo->argv;
>           envp = spawn_info->moreinfo->envp;

If you don't set the child's uid here then where is it going to be set?

>In addition the code (mostly uinfo.cc and seteuid) is greatly 
>streamlined (IMHO). The changes are pretty self explanatory,
>except perhaps the following.
>dll_crt0_1() passes a flag to uinfo_init() to indicate if the
>parent is a Cygwin process. The previous method (ppid != 1) 
>is not reliable and causes the following bug: when a cygwin 
>process with ppid == 1 exec()'s after setgid(), the new gid 
>gets lost.

The correct way to find out if the parent is a cygwin process is to
check for ppid_handle.  If it is zero, then the parent was not a cygwin
process.  I've already made this change to uinfo.cc.

>Another minor bug is fixed: LOGONSERVER is always set correctly.

This isn't obvious from your patch.  I'll have to take your word for it.

cgf
