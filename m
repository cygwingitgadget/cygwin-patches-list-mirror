Return-Path: <cygwin-patches-return-2414-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17786 invoked by alias); 13 Jun 2002 15:08:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17772 invoked from network); 13 Jun 2002 15:08:13 -0000
Message-ID: <3D08B663.21AF56C2@ieee.org>
Date: Thu, 13 Jun 2002 08:08:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Reorganizing internal_getlogin()
References: <3.0.5.32.20020609231253.008044d0@mail.attbi.com> <20020610035228.GC6201@redhat.com> <20020610111359.R30892@cygbert.vinschen.de> <20020610151016.GG6201@redhat.com> <3D04C62B.E7804DC0@ieee.org> <20020611022812.GA30113@redhat.com> <20020612053233.GA21398@redhat.com> <20020613160337.K30892@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00397.txt.bz2

Christopher Faylor wrote:

> Stupid question time: Do we *really* need to set these environment
> variables?  What would break if we just didn't set them?  I can't
> imagine any well-written software relying on these being set correctly.
> How can you rely on something that a user could modify?  

Excellent question. Answer: only to do as Windows, presumably when
calling Windows program. I can't imagine any unix programmer using 
them.

I will look at Chris version tonight, at home...


Corinna Vinschen wrote:

> > One thing that I changed was to not query for a user name if you've
> > already gotten the user name from GetUserName.  I also changed the HOME
> 
> This isn't correct since GetUserName() returns the old username after
> impersonating another user so it returns a value but it's incorrect.
> Therefore we can't rely on that value in NT.  It's just used for 9x
> and it's used in NT to get a string for debug_printf.
> 
Corinna,

Among the stuff that I sent last night, I think that the change to 
syscalls.cc is non controversial.  It avoids calling internal_getlogin
from seteuid (assuming somebody else with set the Windows env). 
Could you have a look at it and possibly apply it?

Similarly the essence of the change to uinfo_init (and drct0.cc) is also 
non-controversial. That is 
1) deciding if a "parent" is non-Cygwin should be done based on 
child_proc_info, either as a global or (more modularly) passed as a 
flag.
2) calling internal_getlogin from uinfo_init is only necessary when 
the "parent" is non-cygwin.

With those changes, internal_getlogin is only called when entering from
outside Cygwin. In that case, GetUserName() will return the correct name, 
except in the case where 
a) a cygwin program impersonates a user
b) the impersonated user eventually calls a non-cygwin program
c) the non-cygwin program eventually calls a cygwin program 
However in that case the passwd file will have sids, the user
will be found from its sid, and the output of GetUserName will
be ignored. So we are OK.

By the way, note that calling GetUserName() in internal_getlogin is 
perfectly useless because cygheap->user.name was ALREADY initialized
in shared.cc:memory_init (from GetUserName() !) 

Another non-controversial change is in spawn.cc where the sid passed
to __sec_user() can be cygheap->user.sid () [simpler/faster than 
getting it from the token], and the test before RevertToSelf can be 
removed (a good compiler would remove it..).
Could you edit the file directly [or apply only that part of my patch]. 
Thanks.

Pierre
