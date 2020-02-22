Return-Path: <cygwin-patches-return-10105-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 97477 invoked by alias); 22 Feb 2020 13:36:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 97467 invoked by uid 89); 22 Feb 2020 13:36:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-06.nifty.com
Received: from conssluserg-06.nifty.com (HELO conssluserg-06.nifty.com) (210.131.2.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 22 Feb 2020 13:35:58 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-06.nifty.com with ESMTP id 01MDZVXq004199	for <cygwin-patches@cygwin.com>; Sat, 22 Feb 2020 22:35:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 01MDZVXq004199
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582378532;	bh=08zaYiqozX/Se6VL5FgFi65Fm4q9KsP7FPjE4LGFAa4=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=WlWaS3kjYqwUvsWyw9v/BFqztUHOrW83wpp9WrT1l7hMBbZ7si0buZAgW463ltcDd	 nu86uMgSXoNTX0HX989SCZjWoat0/JU+SsuE36ZbzmtTMXBh1pqBLEpcYQs5E9IZLv	 E4H7Ez8hbsQpPK9tU+I0n6o+Cz9UptrltGgrUCANfCl9TLFM1Tho44btH5D995U0A5	 C3Vr6zzRlsYOhBsKvbKcmKBFH6DWgmnNRkyTUDyfBgZEjSzTgDlq/ycq5AFmdY84/i	 Hj4HjSy8E363dISOjLQYpM5D0j/SQRa4rDjFfViy6FbLwqwzLIJlPS6e3wCMLoHqnf	 eczIsiyMGPp7g==
Date: Sat, 22 Feb 2020 13:36:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix segfault on shared_console_info access.
Message-Id: <20200222223534.82ef1b99a3359106ce35996b@nifty.ne.jp>
In-Reply-To: <20200222170123.23099cf86117791daa1722c5@nifty.ne.jp>
References: <20200221191000.1027-1-takashi.yano@nifty.ne.jp>	<20200221194333.GZ4092@calimero.vinschen.de>	<20200222170123.23099cf86117791daa1722c5@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00211.txt

On Sat, 22 Feb 2020 17:01:23 +0900
Takashi Yano wrote:
> Hi Corinna,
> 
> On Fri, 21 Feb 2020 20:43:33 +0100
> Corinna Vinschen wrote:
> > On Feb 22 04:10, Takashi Yano wrote:
> > > - Accessing shared_console_info accidentaly causes segmentation
> > >   fault when it is a NULL pointer. The cause of the problem reported
> > >   in https://cygwin.com/ml/cygwin/2020-02/msg00197.html is this NULL
> > >   pointer access in request_xterm_mode_output(). This patch fixes
> > >   the issue.
> > 
> > When does this occur?  I guess this is during initialization.  Is it
> > really necessary to switch to xterm mode at all at that time?  If not,
> > it might be simpler to just
> > 
> > -  if (con_is_legacy)
> > +  if (con_is_legacy || !shared_console_info)
> > 
> > at the start of the functions and only switch to xterm mode when
> > fully up and running.
> 
> This happens when request_xterm_mode_output() is called from
> close(). Usually, shared_console_info has been set when it is
> called from close(), buf this happnes in mintty case. Since I
> was not sure why shared_console_info is NULL in mintty case,
> I have investigated deeper.
> 
> And I found the following code causes the same situation.
> 
> /* fork-setsid.c: */
> /* gcc -mwindows fork-setsid.c -o fork-setsid */
> #include <unistd.h>
> 
> int main()
> {
>     if (!fork()) setsid();
>     return 0;
> }
> 
> In this case, close() is called via cygheap->close_ctty() from
> setsid() even though console is not opened.
> 
> Therefore, the following patch also fixes the mintty issue.
> However, I am not sure this is the right thing.
> 
> diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> index 4652de929..47a78bae4 100644
> --- a/winsup/cygwin/dtable.cc
> +++ b/winsup/cygwin/dtable.cc
> @@ -937,6 +937,7 @@ dtable::fixup_after_exec ()
>  void
>  dtable::fixup_after_fork (HANDLE parent)
>  {
> +  bool ctty_opened = false;
>    fhandler_base *fh;
>    for (size_t i = 0; i < size; i++)
>      if ((fh = fds[i]) != NULL)
> @@ -957,7 +958,11 @@ dtable::fixup_after_fork (HANDLE parent)
>  	  SetStdHandle (std_consts[i], fh->get_handle ());
>  	else if (i <= 2)
>  	  SetStdHandle (std_consts[i], fh->get_output_handle ());
> +	if (cygheap->ctty == fh)
> +	  ctty_opened = true;
>        }
> +  if (!ctty_opened)
> +    cygheap->ctty = NULL;
>  }
>  
>  static void

This does not work as expected. How about this one?

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index 4652de929..138b7a1eb 100644
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
+	if (cygheap->ctty == fh->archetype)
+	  ctty_opened = true;
       }
+  if (!ctty_opened)
+    cygheap->ctty = NULL;
 }
 
 static void


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
