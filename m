Return-Path: <cygwin-patches-return-2453-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32475 invoked by alias); 18 Jun 2002 02:41:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32425 invoked from network); 18 Jun 2002 02:41:48 -0000
Message-Id: <3.0.5.32.20020617223823.00808640@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Mon, 17 Jun 2002 19:41:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Reorganizing internal_getlogin() patch is in
In-Reply-To: <20020618020018.GB20377@redhat.com>
References: <3.0.5.32.20020617213433.007fcca0@mail.attbi.com>
 <3.0.5.32.20020616000701.007f7df0@mail.attbi.com>
 <20020613052709.GA17779@redhat.com>
 <20020613052709.GA17779@redhat.com>
 <3.0.5.32.20020616000701.007f7df0@mail.attbi.com>
 <3.0.5.32.20020617213433.007fcca0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00436.txt.bz2

At 10:00 PM 6/17/2002 -0400, Christopher Faylor wrote:
>>>I don't understand what you mean by "env" and "/bin/env".  The type command
>>>in bash tells me that env == /bin/env.
>I'm sorry but I'm still not getting it.  "type bin" returns "command not
>found" on my system.  AFAIK, I only have one "env" command and it is
>"/usr/bin/env".

Dyslexia, I meant "type env" returns /usr/bin/env, which is on a cygexec
drive. So your optimization kicks in when I type "env".
/bin/env invokes exactly the same program, but somehow it's not recognized
as being on a cygexec drive and your optimization does not kick in.
  
>>>For the same reason as we are meticulously saving all of these other
>>>environment variables, I guess.  Somebody could use them.
>>
>>Silly me.  But shouldn't USERPROFILE also be saved?

I see where USERPROFILE is evaluated from get_registry_hive_path()
when it is copied back to the environmnet. Similarly HOMEPATH
*can* be obtained from NetUserGetInfo ().
However HOMEPATH, but apparently not USERPROFILE, is initialized 
from the env on startup.
 
>I did add some code to only perform the expensive calculations when cygwin
>was setuid'ed but I think that won't work correctly when a cygwin child of
>an setuid'ed program tries to start a windows-only program and endeavors
>to recalculate things.  If I understand the problem correctly it sounds
>like the child will become confused due to the fact that it was created
>by CreateProcessAsUser.  However, hasn't this always been how it worked?

You understand the problem perfectly.
The old way out was to call LookupAccountSid(childsid) BEFORE calling
CreateProcessAsUser, and to pass the USERNAME and USERDOMAIN in the
environment, to be read by internal_getlogin. 

Your new way (passing the info in "user") is much more efficient.
However "user" needs to be updated before calling CreateProcessAsUser.
That's what the patch I sent on Sat is doing.

There is no need to copy the "user" fields to USERNAME and USERDOMAIN,
except possibly when calling a Windows program. They are, AFAWK, the only
practical means for the program to find out its user name! (but 
there are ways to find the domain).

Pierre
