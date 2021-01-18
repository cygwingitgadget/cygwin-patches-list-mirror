Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id E7F01386F47D
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 13:04:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E7F01386F47D
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MhDIw-1lfVmZ1Fgo-00eIbO for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 14:04:21 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E09AAA80988; Mon, 18 Jan 2021 14:04:20 +0100 (CET)
Date: Mon, 18 Jan 2021 14:04:20 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 02/11] syscalls.cc: Deduplicate _remove_r
Message-ID: <20210118130420.GE59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-3-ben@wijen.net>
 <20210118105603.GS59030@calimero.vinschen.de>
 <6de2f124-c5dd-34cb-1914-4eb0454b41d8@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6de2f124-c5dd-34cb-1914-4eb0454b41d8@wijen.net>
X-Provags-ID: V03:K1:qSU9ehm72rlAWN3+5R26uJCv5QI5Yo+AxHqUbOTxOy7ZnXE4eJV
 nnayQl3iNEQfe7wy8dJ3DI90qU//1jfXaMydzWNzRVgymhKywDugw9Fql/8IfGXxcurOYbZ
 dFygFg2xFDjArCOzzBt0RycCbFhB+SzPUG6T9JjNq+ayGubMefrwrIW1tfNitFL5xrJ0Vvx
 1rDO7TGjhwRqs10ZDB+bA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lT/M6FJydXQ=:bbhcoW9CaeJNnVFhaXUX6W
 LFkffkczJFjoqDCGdIUb+EIWaKv87LCjnUGoJgipHCLeJ1AFdKPQvLPhCXxGhiyiBG9AvszMW
 S9ROyTlQIR49fMJX1IKIYuEsOwMa7qrUQ1eqjLtBPpzHGyENi/0k1z2QtPvZmV1dSdpqSqltq
 GCThg8ONy1TjDMU4w91emZQHBZEknAljpCZwCWOYVLxSK01RJpNUdAvK8aUCqbTpp8Jk8ob/j
 h3Lbz/7VbJxP8HrFAqnfxoPDvE2slAkZMVAeaiYLHn5AvIsG1Mwxya6SMR7BSdGriYMNkwMRZ
 T/8vzYVt0Ao0Y6nw+iLoI3OTbAP2YPcNSW/HSWvBUMObkenIjPU87aB2edkrDAYfI+/tHXzxa
 9jP2rObM8l1nSZLlKxlJ6o0+RUvhYv60fuju52G3Qk2SYKHnQLvlLRIdC/GyNXdqAGjlg6Ypb
 skPM5FvC5A==
X-Spam-Status: No, score=-107.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Mon, 18 Jan 2021 13:04:27 -0000

On Jan 18 13:40, Ben wrote:
> On 18-01-2021 11:56, Corinna Vinschen via Cygwin-patches wrote:
> > Hmm, you're adding another function call to the call stack.  Doesn't
> > that slow down _remove_r rather than speeding it up?  Ok, this function
> > is called from _tmpfile_r/_tmpfile64_r only, so dedup may trump speed
> > here...
> > 
> > What's your stance?
> > 
> While I could do without:
> In an earlier version I had changed remove and missed remove_r.
> 
> So, this commit is more about de-duplication rather than speed.

What about this instead?  It should be better optimizable:

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 4742c665339c..2d8acb4c1052 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1133,24 +1133,15 @@ _remove_r (struct _reent *, const char *ourname)
       return -1;
     }
 
-  return win32_name.isdir () ? rmdir (ourname) : unlink (ourname);
+  int res = win32_name.isdir () ? rmdir (ourname) : unlink (ourname);
+  syscall_printf ("%R = remove(%s)", res, ourname);
+  return res;
 }
 
 extern "C" int
 remove (const char *ourname)
 {
-  path_conv win32_name (ourname, PC_SYM_NOFOLLOW);
-
-  if (win32_name.error)
-    {
-      set_errno (win32_name.error);
-      syscall_printf ("-1 = remove (%s)", ourname);
-      return -1;
-    }
-
-  int res = win32_name.isdir () ? rmdir (ourname) : unlink (ourname);
-  syscall_printf ("%R = remove(%s)", res, ourname);
-  return res;
+  return _remove_r (_GLOBAL_REENT, ourname);
 }
 
 extern "C" pid_t



Corinna
