Return-Path: <cygwin-patches-return-2451-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28701 invoked by alias); 18 Jun 2002 01:37:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28678 invoked from network); 18 Jun 2002 01:37:38 -0000
Message-Id: <3.0.5.32.20020617213433.007fcca0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Mon, 17 Jun 2002 18:37:00 -0000
To: cygwin-patches@cygwin.comX,cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Reorganizing internal_getlogin() patch is in
In-Reply-To: <20020616051506.GA6188@redhat.com>
References: <3.0.5.32.20020616000701.007f7df0@mail.attbi.com>
 <20020613052709.GA17779@redhat.com>
 <20020613052709.GA17779@redhat.com>
 <3.0.5.32.20020616000701.007f7df0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00434.txt.bz2

At 01:15 AM 6/16/2002 -0400, Christopher Faylor wrote:
>On Sun, Jun 16, 2002 at 12:07:01AM -0400, Pierre A. Humblet wrote:
>>I noticed several nits:
>>spawn.cc:    line accidentally deleted, diff below.
>
>That's odd.  I thought that the removal of this line was one of the
>goals of your changes.  I guess we should rename this field, as you
>suggested, since it is being used as a flag now.

Well, the assignment of that variable to myself->uid was nuked, but
it's needed as a flag. By the way I failed to notice that the line
      ciresrv.moreinfo->uid = getuid32 ();
in the normal CreateProcess branch was also removed.
You may want to change to something like 
      ciresrv.moreinfo->newuid = FALSE;

>I am still having a hard time understanding why we have to set these
>variables at all.  My preference would be to wipe them from the
>environment.

I second that. Those variables are not present in Win95/98/Me, 
so I expect most programs must have another way of getting the 
info if it isn't in the env.
Unfortunately Microsoft keep adding such personalized variables. 
On Win2000 I noticed APPDATA, TMP and TEMP. TMP and TEMP seem 
particularly bad, the child may not be able to access it after setuid(). 
Should they be nuked also or replaced by something sensible?

>One of the things I liked about my patch was that it could potentially
>speed up process spawning a lot since there is no need to do things like
>query the domain.  I hate the fact that every cygwin program has to pay
>the penalty for the probably unusual occurrence of a program or script
>relying on these environment variables.

The current Cygwin is already efficient when there is not setuid().
The changes impact the setuid case, and help greatly for 
"forking servers".

>>b) Unfortunately, postponing the evaluation of variables cannot be done
past 
>>CreateProcessAsUser. After that point LookupAccountSid returns 
>>incorrect values (this would happen when the child is cygwin but the 
>>grandchild isn't).
>
>Why is this?  How does Windows manage to allow you to login, then?  Is it
>using some kind of undocumented mechanism?

Corinna is the real expert on this. See sentence "> But _inside_ of "
toward the bottom of
http://www.cvsnt.org/pipermail/cvsnt/2001-December/002863.html

>I don't understand what you mean by "env" and "/bin/env".  The type command
>in bash tells me that env == /bin/env.

Sorry I thought I had a standard setup... Here c:\xxxxx\cygwin is mounted to /
and  c:\xxxxx\cygwin\bin to /usr/bin  (cygexec). "Type bin" returns
/usr/bin/env
So /bin/env and env can produce diff results.

>>I don't understand the logic for SYSTEMDRIVE and SYSTEMROOT. It looks
>>like if they are not in the cygwin env then they are looked up in the
>>Windows env (this would mean that the program has deleted them (?)).
>
>This is nothing new.  This is the code that Egor introduced some time
>ago.  The environment being studied in this code is not necessarily the
>complete user environment.  It can be the environment passed in via
>something like execvpe.

Good point, but when Igor did it, was the optimization where
the Windows env could be NULL already there? 
Won't  "if (GetEnvironmentVariable (name, p + namelen, vallen))"
fail in that case? Using the Windows system call should always work. 
By the way, do you know why Igor thought these were needed?
 
>If a user actually goes out of their way to remove these variables from
>their environment then we're just following their wishes.  

Does removing it from the Cygwin env cause GetEnvironmentVariable (name, ..)
to fail?

>>uinfo.cc:  (no diff yet, can use help)
>>a) cygheap_user.pname is set to the Cygwin user name. There should also 
>>be an entry for the Windows user name. It should be initialized from the 
>>same LookupAccountSid call that returns the domain. I don't provide a patch 
>>because I don't see how to do that elegantly... 
>
>Is this new?  It sounds like env_name should be returning the Windows name.
>I've done that.

Corinna allowed different Cygwin and Windows name a while ago. I find it 
useful, e.g. when Windows names have spaces, or when the same name appears
in different domains. env_name returns "name ()", which is set in set_name(),
which is called in seteuid() with the Cygwin name from passwd. 
name () is also returned by getlogin () (in uinfo.cc).

>>b) NetUserGetInfo() must always be called with the env_logsrv, otherwise
>>name aliasing can occur. Don't call if env_logsrv is NULL, which should
>>be the case only for SYSTEM.

See next e-mail. 

>>Also I don't see the need to copy HOMEDRIVE and HOMEPATH to
homedrive_env_buf
>>and homepath_env_buf when HOME already exists.
>
>For the same reason as we are meticulously saving all of these other
environment
>variables, I guess.  Somebody could use them.

Silly me. But shouldn't USERPROFILE also be saved? 
Also, depending on what you want to do about those variables, it may make
sense
to save them when you process the Windows environment when a cygwin program
is 
first entered, together with the other special cases.

Pierre
