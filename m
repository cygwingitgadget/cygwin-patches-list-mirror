Return-Path: <SRS0=smak=VY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 314103858C31
	for <cygwin-patches@cygwin.com>; Wed,  5 Mar 2025 14:34:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 314103858C31
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 314103858C31
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741185281; cv=none;
	b=I00eJC5h1xaYyTa6eaXRNaZMsl09Prmt4voTuf+/6CS8UEX0WSJN4WKAqMfn05hBFxrWY1RVTjWQUE0qYpRpiCXZSyRhY8bGcngI3C0K+UIZSpTb/9n0TzY+oexnR8KojsXt7Qp2YFbM2FIn/EXqCxNN1Rk6mfeA6XcC7wm4vkk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741185281; c=relaxed/simple;
	bh=6FDBGnIYXFpxiOKyZxbDu44OtPSLaf6j482fDtAlw68=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=b5e1/67ksD3nmkh4L7wjrAufivig/QMdTRY0HjARbw8/YLgqV8eoRVdGYX/kBZsQqPkVgBkwd9bRIwbUIY5oTsIv2SBowBQSPJ8dFaKEbLMe+WiCKGNHiOtcQ+3VlXGW/XWz815U1PQx4tE7sAfq8/jFX6aGWFtQ6MixxIX08ig=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 314103858C31
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kJU4QlLY
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20250305143438063.HEJT.98325.localhost.localdomain@nifty.com>;
          Wed, 5 Mar 2025 23:34:38 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Jay M Martin <jaymmartin_buy@cox.net>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH] Cygwin: pipe: Fix 'lost connection' issue in scp
Date: Wed,  5 Mar 2025 23:34:10 +0900
Message-ID: <20250305143420.6703-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741185278;
 bh=gYS+s/09ncLddWwv+x9qkhPuktUKRTo8OOxsddjNA1A=;
 h=From:To:Cc:Subject:Date;
 b=kJU4QlLY9UGH6ZzmuNZBW3PjamaqMYR0iV6AA3Gm7PJx97b+0eWM60J48sAQ6wjPJs79VxbM
 mMv3+pKtC0BFYd9DaRe97grisTu8kxlVG8FLXUGNeFwVz8UZMSA6k1VDxk75AfYKbngUlNqWDA
 ZlFeiFWbsRpiouP1yvA6vRpVPImodJ26WgaLH97O/BII0v+5+SbofVGS26tYXqth64+6dVG6Yl
 Vwixa/BbyY/lNLtkYoB1NhfD1QKodb4uCpssjlB3ZcC6JXYBuQAV90skByS/I6Q3QqChdne50L
 Is8PnDISBkIOzmDVb6/+zZrAKR1L03VWea5i0/Ip7GBCJPzg==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

When transferring huge file using scp, the "lost connection" error
sometimes happen. This is due to fhandler_pipe_fifo::raw_write()
accidentally sends data that is not reported in th return value when
interrupted by a signal. The cause of the problem is that CancelIo()
responds success even if NtWriteFile() already sends the data.

The following testcase using plain Win32 APIs reproduces the issue.
The output will be something like:
W: 8589934592
R: 9280061440
Much more data was received than the sender thought it had sent.

#include <windows.h>
#include <stdio.h>

DWORD WINAPI read_thread(LPVOID arg)
{
  char buf[32768];
  ssize_t sum = 0;
  HANDLE pr = (HANDLE) arg;
  while (1) {
    DWORD nb;
    BOOL res = ReadFile(pr, buf, sizeof(buf), &nb, NULL);
    if (!res) break;
    sum += nb;
  }
  printf("R: %lld\n", sum);
}

int main()
{
  const char pipename[] = "\\\\.\\pipe\\testpipe";
  char buf[65536*4] = {0,};
  OVERLAPPED ov = {0,};
  ssize_t sum = 0;

  HANDLE pw = CreateNamedPipe(pipename,
                PIPE_ACCESS_OUTBOUND | FILE_FLAG_OVERLAPPED,
                PIPE_TYPE_BYTE, 1, 65536, 0, 0, NULL);
  HANDLE pr = CreateFile(pipename, GENERIC_READ, 0, NULL, OPEN_EXISTING,
                FILE_ATTRIBUTE_NORMAL, NULL);
  HANDLE thr = CreateThread(NULL, 0, read_thread, pr, 0, NULL);
  ov.hEvent = CreateEvent(NULL, FALSE, FALSE, NULL);

  int cnt = 0;
  while (sum < 8192LL*1024*1024) {
    DWORD nb;
    BOOL res = WriteFile(pw, buf, sizeof(buf), &nb, &ov);
    if (res) sum += nb;
    else if (GetLastError() == ERROR_IO_PENDING) {
      if ((cnt & 3) == 0) CancelIo (pw);
      res = GetOverlappedResult(pw, &ov, &nb, TRUE);
      if (!res && GetLastError() != ERROR_OPERATION_ABORTED) {
        printf("%08x\n", GetLastError());
        break;
      }
      sum += nb;
    }
    cnt++;
  }

  printf("W: %lld\n", sum);
  CloseHandle(pw);
  CloseHandle(ov.hEvenet);

  WaitForSingleObject(thr, INFINITE);
  CloseHandle(pr);

  return 0;
}

It seems that CancelIo() works as expected when the NtWriteFile()
is stucked on the pipe full. If the writing is on-going, CancelIo()
reports cancelled, but the data may already be written.

To avoid this issue, this patch waits for completion of writing a
while before issuing CancelIo(), and if it has not completed yet,
call CancelIo().
The wait is done using existing cygwait(select_sem, 10, cw_cancel).
If the semaphore select_sem is released in the read side, the write
operation will be on-going. Otherwise, the write operation is still
stucking, so CancelIo() can safely cancel the I/O.

Addresses: https://cygwin.com/pipermail/cygwin/2025-January/257143.html
Fixes: 4003e3dfa1b9 ("Cygwin: pipes: always terminate async IO in blocking mode")
Reported-by: Jay M Martin <jaymmartin_buy@cox.net>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc | 28 ++++++++++++++++++++--------
 winsup/cygwin/release/3.6.0    |  3 +++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index e24252dee..ac8bbe7d6 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -590,14 +590,23 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	  else
 	    status = NtWriteFile (get_handle (), evt, NULL, NULL, &io,
 				  (PVOID) ptr, len1, NULL, NULL);
+	  bool signalled = false;
+	  bool saw_select_sem = false;
 	  if (status == STATUS_PENDING)
 	    {
 	      do
 		{
 		  waitret = cygwait (evt, (DWORD) 0);
-		  /* Break out if no SA_RESTART. */
-		  if (waitret == WAIT_SIGNALED)
+		  if (signalled && !saw_select_sem
+		      && WAIT_OBJECT_0 == cygwait (pipe_mtx, (DWORD) 0))
 		    break;
+		  /* Break out if no SA_RESTART. But not now. After waiting
+		     for completion of NtWriteFile() for a while. */
+		  if (waitret == WAIT_SIGNALED)
+		    {
+		      signalled = true;
+		      saw_select_sem = false;
+		    }
 		  /* Break out on completion */
 		  if (waitret == WAIT_OBJECT_0)
 		    break;
@@ -608,17 +617,19 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 		      waitret = WAIT_SIGNALED;
 		      break;
 		    }
-		  cygwait (select_sem, 10, cw_cancel);
+		  if (WAIT_OBJECT_0 == cygwait (select_sem, 10, cw_cancel))
+		    saw_select_sem = true;
 		}
-	      while (waitret == WAIT_TIMEOUT);
+	      while (waitret == WAIT_TIMEOUT || waitret == WAIT_SIGNALED);
 	      /* If io.Status is STATUS_CANCELLED after CancelIo, IO has
 		 actually been cancelled and io.Information contains the
 		 number of bytes processed so far.
 		 Otherwise IO has been finished regulary and io.Status
 		 contains valid success or error information. */
 	      CancelIo (get_handle ());
-	      if (waitret == WAIT_SIGNALED && io.Status != STATUS_CANCELLED)
-		waitret = WAIT_OBJECT_0;
+	      ReleaseMutex (pipe_mtx);
+	      if (signalled)
+		waitret = WAIT_SIGNALED;
 
 	      if (waitret == WAIT_CANCELED)
 		status = STATUS_THREAD_CANCELED;
@@ -629,7 +640,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	      else
 		status = io.Status;
 	    }
-	  if (status != STATUS_THREAD_SIGNALED && !NT_SUCCESS (status))
+	  if (!NT_SUCCESS (status))
 	    break;
 	  if (io.Information > 0 || len <= PIPE_BUF || short_write_once)
 	    break;
@@ -684,7 +695,8 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
       else
 	__seterrno_from_nt_status (status);
 
-      if (nbytes_now == 0 || short_write_once)
+      if (nbytes_now == 0 || short_write_once
+	  || status == STATUS_THREAD_SIGNALED)
 	break;
     }
 
diff --git a/winsup/cygwin/release/3.6.0 b/winsup/cygwin/release/3.6.0
index 00cf8753c..8225f2ccc 100644
--- a/winsup/cygwin/release/3.6.0
+++ b/winsup/cygwin/release/3.6.0
@@ -123,3 +123,6 @@ Fixes:
   filesystem-compressed files, potentially triggering a hang in cp(1).
   Addresses: https://sourceware.org/pipermail/cygwin/2025-January/257082.html
              https://cygwin.com/pipermail/cygwin/2025-February/257326.html
+
+- Fix 'lost connection' error in scp.
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-January/257143.html
-- 
2.45.1

