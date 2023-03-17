Return-Path: <SRS0=t9Gj=7J=ac.auone-net.jp=ysno@sourceware.org>
Received: from dmta0007.auone-net.jp (snd00007.auone-net.jp [111.86.247.7])
	by sourceware.org (Postfix) with ESMTPS id 5A5D538582B0
	for <cygwin-patches@cygwin.com>; Fri, 17 Mar 2023 14:44:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5A5D538582B0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=ac.auone-net.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ac.auone-net.jp
Received: from localhost.localdomain by dmta0007.auone-net.jp with ESMTP
          id <20230317144412085.DWWS.36104.localhost.localdomain@dmta0007.auone-net.jp>;
          Fri, 17 Mar 2023 23:44:12 +0900
From: YO4 <ysno@ac.auone-net.jp>
To: cygwin-patches@cygwin.com
Cc: YO4 <ysno@ac.auone-net.jp>
Subject: [PATCH 0/3] fix unlink/rename failure in hyper-v container
Date: Fri, 17 Mar 2023 23:43:43 +0900
Message-Id: <20230317144346.871-1-ysno@ac.auone-net.jp>
X-Mailer: git-send-email 2.40.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello, cygwin developers.
I am using msys2 and it is based on the cygwin codebase.
I was working inside a windows container and encountered rm.exe and mv.exe failures.
I would be honored if you could merge my patch into upstream.

How to reproduce:
Use a version of windows that supports POSIX unlink/rename semantics as a container.
In a windows container using hyper-v isolation, rm.exe and mv.exe fail on bind mounted (also volume mounted) directories.

What this patch does
This patch will disable POSIX semantics and retry on the above failures.

The strace on failure is as follows
  806  192814 [main] rm 1473 _unlink_nt: Trying to delete \??\C:\binded_dir\file_to_unlink, isdir = 0
 1236  194050 [main] rm 1473 _unlink_nt: \??\C:\binded_dir\file_to_unlink, return status = 0xC000000D
  574  194624 [main] rm 1473 seterrno_from_nt_status: /c/S/msys2-runtime/src/msys2-runtime/winsup/cygwin/syscalls.cc:1120 status 0xC000000D -> windows error 87
  490  195114 [main] rm 1473 geterrno_from_win_error: windows error 87 == errno 22
  494  195608 [main] rm 1473 unlink: -1 = unlink(C:/binded_dir/file_to_unlink), errno 22

The strace with the patch is as follows
  737  234961 [main] rm 1822 _unlink_nt: Trying to delete \??\C:\binded_dir\file_to_unlink, isdir = 0
 1277  236238 [main] rm 1822 _unlink_nt: NtSetInformationFile (\??\C:\binded_dir\file_to_unlink, FileDispositionInformationEx) returns 0xC000000D with posix semantics. Disable it and retry.
 1411  237649 [main] rm 1822 _unlink_nt: \??\C:\binded_dir\file_to_unlink, return status = 0x0
  558  238207 [main] rm 1822 unlink: 0 = unlink(C:/binded_dir/file_to_unlink)

I ran the test in Appveyor so you can view the entire log at
https://ci.appveyor.com/project/YO4/test-msys2-in-container/builds/46532757/job/qinojh64uo6el78s
strace logs are available for download as artifacts.

This issue was first discussed here
https://github.com/msys2/msys2-runtime/issues/59
This patch is first available at 
https://github.com/msys2/msys2-runtime/pull/141


YO4 (3):
  fix unlink in container
  fix rename in container
  log disabling posix semantics

 winsup/cygwin/syscalls.cc | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

-- 
2.40.0.windows.1

