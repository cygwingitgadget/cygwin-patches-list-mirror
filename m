Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id 7E39B3858D35
 for <cygwin-patches@cygwin.com>; Fri, 10 Dec 2021 10:21:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7E39B3858D35
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 1BAAKdTS022064;
 Fri, 10 Dec 2021 19:20:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 1BAAKdTS022064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639131639;
 bh=5fGRtY8s+pKAvDz8zsOYGEYIwG+rS7B/tfP2GM+2ZfY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bjbw8yRPUZnSIquBLSeGRfHvxdbfZVgwi7S2euWYMVqq+B/YJfsU4x1lIZOOl5Dsw
 wU8NDRcj6a+53a585PJcmr/SJOMh/RVdaZtPuBulnStESbDYaVx6bKS6SAtz5O/JpY
 No8j+1Ly++YT994Hy0YaDqHaXampi0+6KY4IP6m/YC4hObFZsinifSSkCoaURMoPe1
 s7aY63Q52hX0duea26TF6pGgJU9HaAqeDq7rLVnGVU9yGBz8Igzpu4e8ffaGTBb+AX
 yHfa4quR03G7a2wlJGRrvVIFpCjFvzP9QwhYYHl9bZPyEKHRoCkEJIa9RJH5P3cfAN
 xTVhGVZ/pmjYQ==
X-Nifty-SrcIP: [110.4.221.123]
Date: Fri, 10 Dec 2021 19:20:40 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Reduce unecessary input transfer.
Message-Id: <20211210192040.71f88b263b8c20f2f61db310@nifty.ne.jp>
In-Reply-To: <nycvar.QRO.7.76.6.2112092345060.90@tvgsbejvaqbjf.bet>
References: <20210211090942.3955-1-takashi.yano@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2112092345060.90@tvgsbejvaqbjf.bet>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 10 Dec 2021 10:21:10 -0000

On Fri, 10 Dec 2021 00:05:27 +0100 (CET)
Johannes Schindelin wrote:
> sorry for responding to a patch you sent almost 10 months ago... but... I
> am struggling with it.
> 
> First of all, let me describe the problem I am seeing (see also
> https://github.com/git-for-windows/git/issues/3579): after upgrading the
> MSYS2 runtime to v3.3.3 in Git for Windows, whenever I ask `git.exe` to
> spawn `vim.exe` to edit any file, after quitting `vim` I see spurious ANSI
> sequences being "ghost-typed" into the terminal (which is a MinTTY running
> under `TERM=xterm`).
> 
> Apparently the ANSI sequences report the cursor position and the
> foreground/background color in response to a CSI [ 6n sent from `vim`.
> 
> Clearly, those sequences should go to `vim.exe`, but they mostly don't
> arrive there (but in MinTTY instead, as if I had typed them). Sometimes,
> the foreground/background color seems to arrive in the `vim` process, but
> the cursor position almost always does not. I suspect that it is important
> that `git.exe` is a non-MSYS2 process whereas `vim.exe` is an MSYS2
> process, and something inside the MSYS2 runtime is at fault.
> 
> I've bisected this incorrect behavior to the patch I am replying to.
> 
> I tried to trigger the same bug in pure Cygwin (as opposed to MSYS2),
> specifically using `disable_pcon` (because MSYS2 defaults to not using the
> pseudo console support because I ran into too many issues to be confident
> enough in it yet), but I think that Cygwin's `vim` is too old and
> therefore might not even send that CSI [ 6n (although `:h t_RV` _does_
> show the expected help).
> 
> Now, the patch which I am responding to is completely obscure to me. It is
> very, very unclear to me whether it really tries to only do one thing
> (namely to transfer the input no longer in `read()` but in `setpgid()`),
> or rather does many things at once. Even worse, I have not the faintest
> clue how this patch is trying to accomplish what the commit message
> describes (_because_ it does so many things at once), nor how that could
> be related to the observed incorrect behavior, and as a consequence I have
> no idea how I can hope to fix said observed incorrect behavior.
> 
> Could you help shed some light into the problem?

Thanks for the report.
Could you please test if the following patch solves the issue?


diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index f523dafed..ba282b897 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1239,10 +1239,13 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool mask, bool xfer)
   else if (InterlockedDecrement (&num_reader) == 0)
     CloseHandle (slave_reading);
 
+  bool need_xfer =
+    get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->pcon_activated;
+
   /* In GDB, transfer input based on setpgid() does not work because
      GDB may not set terminal process group properly. Therefore,
      transfer input here if isHybrid is set. */
-  if (isHybrid && !!masked != mask && xfer
+  if ((isHybrid || need_xfer) && !!masked != mask && xfer
       && GetStdHandle (STD_INPUT_HANDLE) == get_handle ())
     {
       if (mask && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
@@ -1536,7 +1539,7 @@ out:
   if (ptr0)
     { /* Not tcflush() */
       bool saw_eol = totalread > 0 && strchr ("\r\n", ptr0[totalread -1]);
-      mask_switch_to_pcon_in (false, saw_eol);
+      mask_switch_to_pcon_in (false, saw_eol || len == 0);
     }
 }
 
@@ -2214,6 +2217,15 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       return len;
     }
 
+  if (to_be_read_from_pcon () && !get_ttyp ()->pcon_activated
+      && get_ttyp ()->pcon_input_state == tty::to_cyg)
+    {
+      WaitForSingleObject (input_mutex, INFINITE);
+      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
+					  get_ttyp (), input_available_event);
+      ReleaseMutex (input_mutex);
+    }
+
   line_edit_status status = line_edit (p, len, ti, &ret);
   if (status > line_edit_signalled && status != line_edit_pipe_full)
     ret = -1;

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
