Return-Path: <cygwin-patches-return-2452-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19915 invoked by alias); 18 Jun 2002 01:59:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19898 invoked from network); 18 Jun 2002 01:59:43 -0000
Date: Mon, 17 Jun 2002 18:59:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.comX, cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin() patch is in
Message-ID: <20020618020018.GB20377@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.comX,
	cygwin-patches@cygwin.com
References: <3.0.5.32.20020616000701.007f7df0@mail.attbi.com> <20020613052709.GA17779@redhat.com> <20020613052709.GA17779@redhat.com> <3.0.5.32.20020616000701.007f7df0@mail.attbi.com> <3.0.5.32.20020617213433.007fcca0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020617213433.007fcca0@mail.attbi.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00435.txt.bz2

On Mon, Jun 17, 2002 at 09:34:33PM -0400, Pierre A. Humblet wrote:
>>Why is this?  How does Windows manage to allow you to login, then?  Is it
>>using some kind of undocumented mechanism?
>
>Corinna is the real expert on this. See sentence "> But _inside_ of "
>toward the bottom of
>http://www.cvsnt.org/pipermail/cvsnt/2001-December/002863.html

I talked to Corinna about this today.  I do remember the amazing effort
she put into getting this working and her frustration about this
particular issue.  Somehow I thought that maybe we'd worked around this
by now.  Wishful thinking.

>>I don't understand what you mean by "env" and "/bin/env".  The type command
>>in bash tells me that env == /bin/env.
>
>Sorry I thought I had a standard setup...  Here c:\xxxxx\cygwin is
>mounted to / and c:\xxxxx\cygwin\bin to /usr/bin (cygexec).  "Type bin"
>returns /usr/bin/env So /bin/env and env can produce diff results.

I'm sorry but I'm still not getting it.  "type bin" returns "command not
found" on my system.  AFAIK, I only have one "env" command and it is
"/usr/bin/env".

>>>I don't understand the logic for SYSTEMDRIVE and SYSTEMROOT. It looks
>>>like if they are not in the cygwin env then they are looked up in the
>>>Windows env (this would mean that the program has deleted them (?)).
>>
>>This is nothing new.  This is the code that Egor introduced some time
>>ago.  The environment being studied in this code is not necessarily the
>>complete user environment.  It can be the environment passed in via
>>something like execvpe.
>
>Good point, but when Igor did it, was the optimization where
>the Windows env could be NULL already there? 

Egor implemented the entire functionality.

>Won't  "if (GetEnvironmentVariable (name, p + namelen, vallen))"
>fail in that case? Using the Windows system call should always work. 
>By the way, do you know why Igor thought these were needed?

Do you have access to CVS?  Check what environ.cc used to look like.
AFAIK, the current code is very similar to Egor's.

>>If a user actually goes out of their way to remove these variables from
>>their environment then we're just following their wishes.  
>
>Does removing it from the Cygwin env cause GetEnvironmentVariable (name, ..)
>to fail?

No.

>>>b) NetUserGetInfo() must always be called with the env_logsrv, otherwise
>>>name aliasing can occur. Don't call if env_logsrv is NULL, which should
>>>be the case only for SYSTEM.
>
>See next e-mail. 
>
>>>Also I don't see the need to copy HOMEDRIVE and HOMEPATH to
>homedrive_env_buf
>>>and homepath_env_buf when HOME already exists.
>>
>>For the same reason as we are meticulously saving all of these other
>>environment variables, I guess.  Somebody could use them.
>
>Silly me.  But shouldn't USERPROFILE also be saved?

?

/* Keep this list in upper case and sorted */
static NO_COPY spenv spenvs[] =
{
  {NL ("HOMEPATH="), &cygheap_user::env_homepath},
  {NL ("HOMEDRIVE="), &cygheap_user::env_homedrive},
  {NL ("LOGONSERVER="), &cygheap_user::env_logsrv},
  {NL ("SYSTEMDRIVE="), NULL},
  {NL ("SYSTEMROOT="), NULL},
  {NL ("USERDOMAIN="), &cygheap_user::env_domain},
  {NL ("USERNAME="), &cygheap_user::env_name},
  {NL ("USERPROFILE="), &cygheap_user::env_userprofile},
};

Again, I'm missing something.

>Also, depending on what you want to do about those variables, it may
>make sense to save them when you process the Windows environment when a
>cygwin program is first entered, together with the other special cases.

I think we're going far into "what if" territory, now.  I don't think that
the current behavior should be substantially different from previously.

I did add some code to only perform the expensive calculations when cygwin
was setuid'ed but I think that won't work correctly when a cygwin child of
an setuid'ed program tries to start a windows-only program and endeavors
to recalculate things.  If I understand the problem correctly it sounds
like the child will become confused due to the fact that it was created
by CreateProcessAsUser.  However, hasn't this always been how it worked?

Did a child of an setuid program screw up these special environment
variables?

cgf
