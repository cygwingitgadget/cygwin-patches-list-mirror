Return-Path: <cygwin-patches-return-2440-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16287 invoked by alias); 16 Jun 2002 05:14:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16270 invoked from network); 16 Jun 2002 05:14:34 -0000
Date: Sat, 15 Jun 2002 22:14:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin() patch is in
Message-ID: <20020616051506.GA6188@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020613052709.GA17779@redhat.com> <20020613052709.GA17779@redhat.com> <3.0.5.32.20020616000701.007f7df0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020616000701.007f7df0@mail.attbi.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00423.txt.bz2

On Sun, Jun 16, 2002 at 12:07:01AM -0400, Pierre A. Humblet wrote:
>At 09:02 PM 6/14/2002 -0400, Christopher Faylor wrote:
>>Pierre's patch + my modifications + Corinna's insights into my blunders
>>are now checked in.
>
>Kudos to Chris and Corinna for the elegant way they have reimplemented
>the Windows environment handling.
>
>I noticed several nits:
>spawn.cc:    line accidentally deleted, diff below.

That's odd.  I thought that the removal of this line was one of the
goals of your changes.  I guess we should rename this field, as you
suggested, since it is being used as a flag now.

>environ.cc: (diff below)
>a) There are cases where a variable that is not present should be added,
>and cases where an existing variable should be removed.
>That's because the SYSTEM account is missing variables (different on
>NT and Win2000 !!), as can be checked by running env from cygrunsrv with
>the production cygwin1.dll  I made spenv::retrieve return an empty string
>when a variable should not exist.

I am still having a hard time understanding why we have to set these
variables at all.  My preference would be to wipe them from the
environment.

Do we really think that someone is running a .bat file under ssh or
something?

One of the things I liked about my patch was that it could potentially
speed up process spawning a lot since there is no need to do things like
query the domain.  I hate the fact that every cygwin program has to pay
the penalty for the probably unusual occurrence of a program or script
relying on these environment variables.

>b) Unfortunately, postponing the evaluation of variables cannot be done past 
>CreateProcessAsUser. After that point LookupAccountSid returns 
>incorrect values (this would happen when the child is cygwin but the 
>grandchild isn't).

Why is this?  How does Windows manage to allow you to login, then?  Is it
using some kind of undocumented mechanism?

>However if the child is cygwin, there is no need to include the variables
>in the env (they are stored in "user") so "no_envblock" remains useful. 
>As a side effect, if /usr/bin is mounted cygexec, "env" and "/bin/env" 
>may output a different number of variables.

I don't understand what you mean by "env" and "/bin/env".  The type command
in bash tells me that env == /bin/env.

>c) adding a member "namelen" in spenv (as in win_env) seems to be helpful.

Possibly, but this is one of those situations where you sully your patch
by making it do too many things.  It's generally good practice to have
one idea per patch.

>There is also a simple possible optimization (not in the patch):
>AFAIK all this stuff is unnecessary in Win95/98/ME
>
>I don't understand the logic for SYSTEMDRIVE and SYSTEMROOT. It looks
>like if they are not in the cygwin env then they are looked up in the
>Windows env (this would mean that the program has deleted them (?)).

This is nothing new.  This is the code that Egor introduced some time
ago.  The environment being studied in this code is not necessarily the
complete user environment.  It can be the environment passed in via
something like execvpe.

If a user actually goes out of their way to remove these variables from
their environment then we're just following their wishes.  However,
Windows unaware programs which think they can just set a minimal number
of environment variables are unaware of the fact that they need
SYSTEMROOT and SYSTEMDRIVE.

>uinfo.cc:  (no diff yet, can use help)
>a) cygheap_user.pname is set to the Cygwin user name. There should also 
>be an entry for the Windows user name. It should be initialized from the 
>same LookupAccountSid call that returns the domain. I don't provide a patch 
>because I don't see how to do that elegantly... 

Is this new?  It sounds like env_name should be returning the Windows name.
I've done that.

>b) NetUserGetInfo() must always be called with the env_logsrv, otherwise
>name aliasing can occur. Don't call if env_logsrv is NULL, which should
>be the case only for SYSTEM.

I seem to recall that Corinna added this code for a reason.

I'm not sure what you mean by name aliasing though.  Do you mean that a
local name could be refused with a "network name".

>c) get_logon_server() will fail for SYSTEM. There should be a test
>"if (strcasematch (Windowname (), "SYSTEM"))" before calling it as it 
>will looked up repeatedly if plogsrv remains NULL.

AFAIK, this code has only seen very minimal change in the last week.
I'll let Corinna comment on this.  I'll add a guard to env_logsrv, though.

>In env_userprofile () I don't understand why the last two conditions
>are useful in:
>  if (strcasematch (name (), "SYSTEM") || !env_domain () || !env_logsrv ())
>The domain should never be NULL, and the logserver only NULL for SYSTEM.

The domain can be NULL if LookupAccountSid fails.  get_logon_server can
fail, also.  Certainly it makes sense to fail gracefully, no?

>Also I don't see the need to copy HOMEDRIVE and HOMEPATH to homedrive_env_buf
>and homepath_env_buf when HOME already exists.

For the same reason as we are meticulously saving all of these other environment
variables, I guess.  Somebody could use them.

I've installed your spawn.cc patch. I have to think about the rest.

Thanks,
cgf

>2002-06-12  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* spawn.cc (spawn_guts): Revert removal of
>	ciresrv.moreinfo->uid = ILLEGAL_UID.
