Return-Path: <cygwin-patches-return-10104-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79907 invoked by alias); 22 Feb 2020 08:01:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79898 invoked by uid 89); 22 Feb 2020 08:01:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=investigated
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 22 Feb 2020 08:01:19 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id 01M81BYv009492	for <cygwin-patches@cygwin.com>; Sat, 22 Feb 2020 17:01:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 01M81BYv009492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582358471;	bh=oSuhb/oLuhsdPijEP/7qDjMilU9kdOB3TEjacXZd34g=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=ISlToIuQ9RAgebrxOoDemqaO3aOf32pIyk9d9Z84Aly/xADzJSoYiQZNY2H5EwP6H	 evDa3AOO+bkYV9aAt0swoIHpRf8qyC0nm6439id+rrzyaeURDstJBN4CS21djjaTgR	 mOxI9KAIVgtKWn9fIHRZw1KDFRzIWbj2lck+3SycEP+PS0Hc60K4HICg6r3TyLgcOQ	 A5fRVir4GqbZzPvcLA0aueQDbpbkXwGDLANq7a5GbSucuFEwvjntgPA9KtgpjHnP7/	 Z5yCGW0XYOVgMxPKUBhw6+3Al65JJ57DNvYJkJ4Ko1oFUPYI1jI7oxMxuV+UqpPpPm	 v5JudarNhSU3w==
Date: Sat, 22 Feb 2020 08:01:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix segfault on shared_console_info access.
Message-Id: <20200222170123.23099cf86117791daa1722c5@nifty.ne.jp>
In-Reply-To: <20200221194333.GZ4092@calimero.vinschen.de>
References: <20200221191000.1027-1-takashi.yano@nifty.ne.jp>	<20200221194333.GZ4092@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00210.txt

Hi Corinna,

On Fri, 21 Feb 2020 20:43:33 +0100
Corinna Vinschen wrote:
> On Feb 22 04:10, Takashi Yano wrote:
> > - Accessing shared_console_info accidentaly causes segmentation
> >   fault when it is a NULL pointer. The cause of the problem reported
> >   in https://cygwin.com/ml/cygwin/2020-02/msg00197.html is this NULL
> >   pointer access in request_xterm_mode_output(). This patch fixes
> >   the issue.
> 
> When does this occur?  I guess this is during initialization.  Is it
> really necessary to switch to xterm mode at all at that time?  If not,
> it might be simpler to just
> 
> -  if (con_is_legacy)
> +  if (con_is_legacy || !shared_console_info)
> 
> at the start of the functions and only switch to xterm mode when
> fully up and running.

This happens when request_xterm_mode_output() is called from
close(). Usually, shared_console_info has been set when it is
called from close(), buf this happnes in mintty case. Since I
was not sure why shared_console_info is NULL in mintty case,
I have investigated deeper.

And I found the following code causes the same situation.

/* fork-setsid.c: */
/* gcc -mwindows fork-setsid.c -o fork-setsid */
#include <unistd.h>

int main()
{
    if (!fork()) setsid();
    return 0;
}

In this case, close() is called via cygheap->close_ctty() from
setsid() even though console is not opened.

Therefore, the following patch also fixes the mintty issue.
However, I am not sure this is the right thing.

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index 4652de929..47a78bae4 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -937,6 +937,7 @@ dtable::fixup_after_exec ()
 void
 dtable::fixup_after_fork (HANDLE parent)
 {
+  bool ctty_opened = false;
   fhandler_base *fh;
   for (size_t i = 0; i < size; i++)
     if ((fh = fds[i]) != NULL)
@@ -957,7 +958,11 @@ dtable::fixup_after_fork (HANDLE parent)
 	  SetStdHandle (std_consts[i], fh->get_handle ());
 	else if (i <= 2)
 	  SetStdHandle (std_consts[i], fh->get_output_handle ());
+	if (cygheap->ctty == fh)
+	  ctty_opened = true;
       }
+  if (!ctty_opened)
+    cygheap->ctty = NULL;
 }
 
 static void

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
