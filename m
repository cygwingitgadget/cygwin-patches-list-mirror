Return-Path: <cygwin-patches-return-9902-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80476 invoked by alias); 6 Jan 2020 14:38:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80464 invoked by uid 89); 6 Jan 2020 14:38:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=UD:cygwin.com, Speed, me, sleep
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 06 Jan 2020 14:38:54 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-05.nifty.com with ESMTP id 006EcgVM003746;	Mon, 6 Jan 2020 23:38:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com 006EcgVM003746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1578321528;	bh=dZeAdgGSBxvkUQPk4P6LyMFh9UqzePGxHbhzdYcchEY=;	h=From:To:Cc:Subject:Date:From;	b=vlbvUmumd06Zm/8poksQ3c3obiRx72j37YKDrmw7UUvB0UONOhzHera19VywIyA4y	 kofhidvQ0x3LVQ5rbzDoYNiPuEf/ARNzyThJVPGtGJHzm7boKVk0dBWaCOgM1h/XVc	 MXGduuTqxpkonAfc3/rW0CecXL6CjxkveT+K9JU5HJmpgKQnVR2li0WKal3nqz7KC2	 yxRWuqNlgpl7ctC6FGdK4tuhsBKqUepfeSCZYbifBP95UwW44INNwii/C+/clUEeml	 zS+O4/pjaRgzQJ7GkMoGJp49fP/ClkbsZcMAbgfOBOeeT5WKIgp+TMw0mAyI9Oje1m	 D611zIH302m6A==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: select: Speed up select() call for pty, pipe and fifo.
Date: Mon, 06 Jan 2020 14:38:00 -0000
Message-Id: <20200106143834.1994-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00008.txt

- The slowing down issue of X11 forwarding using ssh -Y, reported
  in https://www.cygwin.com/ml/cygwin/2019-12/msg00295.html,
  is due to the change of select() code for pty in the commit
  915fcd0ae8d83546ce135131cd25bf6795d97966. cygthread::detach()
  takes at most about 10msec because Sleep() is used in the thread.
  For this issue, this patch uses cygwait() instead of Sleep() and
  introduces an event to abort the wait. For not only pty, but pipe
  and fifo also have the same problem potentially, so this patch
  applies same strategy to them as well.
---
 winsup/cygwin/select.cc | 15 ++++++++++++---
 winsup/cygwin/select.h  |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index e7014422b..b3aedf20f 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -744,7 +744,7 @@ thread_pipe (void *arg)
 	  }
       if (!looping)
 	break;
-      Sleep (sleep_time >> 3);
+      cygwait (pi->bye, sleep_time >> 3);
       if (sleep_time < 80)
 	++sleep_time;
       if (pi->stop_thread)
@@ -763,6 +763,7 @@ start_thread_pipe (select_record *me, select_stuff *stuff)
     {
       pi->start = &stuff->start;
       pi->stop_thread = false;
+      pi->bye = CreateEvent (&sec_none_nih, TRUE, FALSE, NULL);
       pi->thread = new cygthread (thread_pipe, pi, "pipesel");
       me->h = *pi->thread;
       if (!me->h)
@@ -780,8 +781,10 @@ pipe_cleanup (select_record *, select_stuff *stuff)
   if (pi->thread)
     {
       pi->stop_thread = true;
+      SetEvent (pi->bye);
       pi->thread->detach ();
     }
+  CloseHandle (pi->bye);
   delete pi;
   stuff->device_specific_pipe = NULL;
 }
@@ -924,7 +927,7 @@ thread_fifo (void *arg)
 	  }
       if (!looping)
 	break;
-      Sleep (sleep_time >> 3);
+      cygwait (pi->bye, sleep_time >> 3);
       if (sleep_time < 80)
 	++sleep_time;
       if (pi->stop_thread)
@@ -943,6 +946,7 @@ start_thread_fifo (select_record *me, select_stuff *stuff)
     {
       pi->start = &stuff->start;
       pi->stop_thread = false;
+      pi->bye = CreateEvent (&sec_none_nih, TRUE, FALSE, NULL);
       pi->thread = new cygthread (thread_fifo, pi, "fifosel");
       me->h = *pi->thread;
       if (!me->h)
@@ -960,8 +964,10 @@ fifo_cleanup (select_record *, select_stuff *stuff)
   if (pi->thread)
     {
       pi->stop_thread = true;
+      SetEvent (pi->bye);
       pi->thread->detach ();
     }
+  CloseHandle (pi->bye);
   delete pi;
   stuff->device_specific_fifo = NULL;
 }
@@ -1279,7 +1285,7 @@ thread_pty_slave (void *arg)
 	  }
       if (!looping)
 	break;
-      Sleep (sleep_time >> 3);
+      cygwait (pi->bye, sleep_time >> 3);
       if (sleep_time < 80)
 	++sleep_time;
       if (pi->stop_thread)
@@ -1303,6 +1309,7 @@ pty_slave_startup (select_record *me, select_stuff *stuff)
     {
       pi->start = &stuff->start;
       pi->stop_thread = false;
+      pi->bye = CreateEvent (&sec_none_nih, TRUE, FALSE, NULL);
       pi->thread = new cygthread (thread_pty_slave, pi, "ptyssel");
       me->h = *pi->thread;
       if (!me->h)
@@ -1325,8 +1332,10 @@ pty_slave_cleanup (select_record *me, select_stuff *stuff)
   if (pi->thread)
     {
       pi->stop_thread = true;
+      SetEvent (pi->bye);
       pi->thread->detach ();
     }
+  CloseHandle (pi->bye);
   delete pi;
   stuff->device_specific_ptys = NULL;
 }
diff --git a/winsup/cygwin/select.h b/winsup/cygwin/select.h
index ae98c658d..98fde3a89 100644
--- a/winsup/cygwin/select.h
+++ b/winsup/cygwin/select.h
@@ -44,6 +44,7 @@ struct select_info
 {
   cygthread *thread;
   bool stop_thread;
+  HANDLE bye;
   select_record *start;
   select_info (): thread (NULL), stop_thread (0), start (NULL) {}
 };
-- 
2.21.0
