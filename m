Return-Path: <cygwin-patches-return-3417-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1774 invoked by alias); 17 Jan 2003 15:04:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1754 invoked from network); 17 Jan 2003 15:04:32 -0000
Message-ID: <3E281BDA.2AB5415E@ieee.org>
Date: Fri, 17 Jan 2003 15:04:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: etc_changed, passwd & group.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00066.txt.bz2

> On Thu, Jan 16, 2003 at 02:07:18PM -0500, Christopher Faylor wrote:
> >On Thu, Jan 16, 2003 at 01:57:21AM -0500, Pierre A. Humblet wrote:
> >>Here is the code as it stands. It compiles & runs, and passes
> >>fork tests correctly. Feel free to takeover or at least
> >>have a look. I will continue testing tomorrow evening.
> >>
> >>I include only the 5 files that are related to etc_changed,
> >>the 5 others (setuid on Win9X) can wait.
> >
> >Hmm.  I have a slightly less intrusive idea for how to handle this.  I'll
> >check it in shortly.
> 
> Maybe not so "less intrusive" after all.  I broke out the etc handling
> stuff into a separate class and moved even more functionality into
> pwdgrp than you did.  I hope Corinna approves.
> 
> I also hope that I got all of your changes that didn't conflict with my
> work in.  I'm generating a new snapshot now.  I guess we should ask
> people to test it for a couple of days before I release 1.3.19.  Sigh.
> 
> Oh, and I just removed the warning when FindFirstChangeNotification
> fails.  This should make the Novell users happy even though the
> performance will be less than wonderful.
> 
> Thanks for your patch and your insight, Pierre.
 
O.K. Chris, I will take a look this weekend. I had moved ALL the etc
handling out of cygheap.cc, into a class in the passwd code, as we had
discussed (I thought).

Also I had merged the pwdgrp_check and pwdgrp_read classes into
a single class because that makes the code much simpler. For example
pwdgrp_check maintains a win32 path but pwdgrp_read recomputes 
that very same path each time it is called by pwdgrp_check
(indirectly, through read_etc_passwd). To add a cherry on the cake,
the path kept by pwdgrp_check originally comes from pwdgrp_read.

I had also simplified other parts. For example the file can be closed
and the timestamp updated as soon as the file is read. There is no reason
to wait until the internal passwd structures have been updated.

I agree that the changes look intrusive at first, but from time to
time it helps to streamline the code rather than apply another layer of
fix. 

I am also enclosing the little test program I am using. If you run
strace a.exe | fgrep 'Read /etc' you should see what gets updated
where. You have 15 seconds to touch either /etc/passwd or /etc/group.
Running strace sh -c a.exe | fgrep 'Read /etc' should yield a 
different behavior because a.exe is execed.

Pierre
 
#include <stdio.h>
#include <pwd.h>

main()
{
    if (fork() == 0)
      {
	  sleep(16);
	  printf("Child waking up %x\n", getpwuid(getuid()));
	  printf("Child waking up %x\n", getgrgid(getgid()));
	  fflush(stdout);
	  exit(0);
      }
    else
    {
	  sleep(15);
	  printf("Parent waking up %x\n", getgrgid(getgid()));
	  printf("Parent waking up %x\n", getpwuid(getuid()));
	  fflush(stdout);
	  _exit(0);
    }
}
