Return-Path: <cygwin-patches-return-2405-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19151 invoked by alias); 13 Jun 2002 03:29:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19137 invoked from network); 13 Jun 2002 03:29:54 -0000
Date: Wed, 12 Jun 2002 20:29:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin()
Message-ID: <20020613033021.GB14456@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020612205711.007f7300@mail.attbi.com> <3.0.5.32.20020612205711.007f7300@mail.attbi.com> <3.0.5.32.20020612230833.0080d100@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020612230833.0080d100@mail.attbi.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00388.txt.bz2

On Wed, Jun 12, 2002 at 11:08:33PM -0400, Pierre A. Humblet wrote:
>At 10:12 PM 6/12/2002 -0400, you wrote:
>>Yes, and as I explained previously, I didn't really like what you did to
>>spawn_guts or your additions to environ.cc.  
>
>You never really explained why, except the style of the names!

Ok.  Let me say it now, then -- IMO it was overly invasive.  You
invented new ways of doing things rather than extending the old ways,
which is what I did.

I'm not going to comment on the rest of your reexplanation of why
setting the environment is bad.  I'm assuming that you haven't looked at
the new code.  I agree that setting the environment only when necessary
is a good thing.  My implementation goes a step further and tries to set
it only when it is actually needed for non-cygwin programs, assuming
that only non-cygwin Windows programs will be interested in most of the
environment variables.

>The other important change I did was not to call internal_login at all
>from seteuid, and to avoid calling LookupAccountSid() [another
>logonserver lookup, really] .  Calling internal_getlogin is useless
>(except for setting the environment) and it has the additional cost of
>traversing passwd.

Yes, sounds like a good thing to do.

>>If you don't set the child's uid here then where is it going to be set?
>
>It's already set! (as is myself->gid and the rest).

Actually, I thought it was required in the spawn (P_NOWAIT) scenario,
but a code review reveals that I was wrong.  So, sorry, nevermind.

>BTW spawn_info->moreinfo->uid has a misleading name (probably for
>historical reasons).

Maybe so.

>>The correct way to find out if the parent is a cygwin process is to
>>check for ppid_handle.  If it is zero, then the parent was not a cygwin
>>process.  I've already made this change to uinfo.cc.
>
>I just checked (printed myself->procinfo in gdb), same problem as ppid. 
>If Windows starts a Cygwin process and this process exec()s.' then the 
>exec'ed process has ppid_handle==0 even though the parent is a cygwin
>process.

Ah.  Ok.  Should have read your explanation more closely.  I was using a
different definition of "parent_process".  You want to check
child_proc_info, then.  If it is non-NULL, the process has been
forked/execed.

cgf
