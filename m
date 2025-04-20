Return-Path: <SRS0=ZSvf=XG=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id ECF9D385841F
	for <cygwin-patches@cygwin.com>; Sun, 20 Apr 2025 19:25:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ECF9D385841F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ECF9D385841F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745177137; cv=none;
	b=pVqzHeyOIkmeYAe4DJGnrsuPoUgwzFj1IbJbmYEzieULJDZU58uOZVxFfCo8rImf4IINveBm3BdihyQfEXs+5K+Ua5u2Hib6yI4QIouF4xpEGA4KzgVoxrxndFTuU8BhmaMXxTOjGgZrOQKp1vNzUJuZJoCbws0yOcGsddl+/X4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745177137; c=relaxed/simple;
	bh=9dDpktfCaEyAooWvHKb3VU5jbwowIt4kalIgrQ3gt9k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tM2OjVdrPPu3Lk9zjM4uUIUJeWSEoCpUPUW3CZMbvkSM8LHmZZHfvJwK7awx6ASs2RZWX5CvuKq4qXMBjKlelGZtleG81OUBbFE2Yn1bb7tQySYcV6vWXq1sQqYE6qq7XJdVXqVawFgrVgTk6ZsB1iGghNNfiIPKYQKyZbSwiTw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ECF9D385841F
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 67D89CDB041A5906
X-Originating-IP: [86.140.112.112]
X-OWM-Source-IP: 86.140.112.112
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeekjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepteehgfdutddukefhudevhfdthedugeehieffleejtdeitedvffetudeuveegiedtnecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghenucfkphepkeeirddugedtrdduuddvrdduuddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegtddrudduvddrudduvddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudduvddqudduvddrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddthedpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihi
	nhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.112.112) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89CDB041A5906; Sun, 20 Apr 2025 20:25:36 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/4] Cygwin: CI: Run stress-ng
Date: Sun, 20 Apr 2025 20:25:06 +0100
Message-ID: <20250420192510.3483-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250420192510.3483-1-jon.turney@dronecode.org.uk>
References: <20250420192510.3483-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v2:
Update comments, enable 'pty' test
Use taskkill instead of pskill
---
 .github/workflows/cygwin.yml      |  14 +-
 winsup/testsuite/stress/cygstress | 602 ++++++++++++++++++++++++++++++
 2 files changed, 614 insertions(+), 2 deletions(-)
 create mode 100755 winsup/testsuite/stress/cygstress

diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
index 79abf3d0f..7d9147977 100644
--- a/.github/workflows/cygwin.yml
+++ b/.github/workflows/cygwin.yml
@@ -201,7 +201,7 @@ jobs:
     - name: Avoid actions/checkout post-run step using Cygwin git
       run: bash -c 'rm /usr/bin/git.exe'
 
-  windows-test:
+  windows-stress-test:
     needs: windows-build
 
     runs-on: windows-latest
@@ -214,11 +214,19 @@ jobs:
     name: Windows tests ${{ matrix.pkgarch }}
 
     steps:
+    - run: git config --global core.autocrlf input
+    - uses: actions/checkout@v3
+
     # install cygwin
     - name: Install Cygwin
       uses: cygwin/cygwin-install-action@master
       with:
         platform: ${{ matrix.pkgarch }}
+        packages: |
+          procps-ng
+          stress-ng
+          unzip
+          wget
 
     # fetch the just-built cygwin installation artifact
     - name: Unpack just-built Cygwin artifact
@@ -234,8 +242,10 @@ jobs:
     # package of the just-built cygwin version and install it here, but tools
     # don't exist (yet) to let us do that...
 
-    # run tests
+    # run stress-test
     - name: Run tests
       run: |
+        export PATH=/usr/bin:$(cygpath ${SYSTEMROOT})/system32
         uname -a
+        winsup/testsuite/stress/cygstress CI
       shell: bash --noprofile --norc -o igncr -eo pipefail '{0}'
diff --git a/winsup/testsuite/stress/cygstress b/winsup/testsuite/stress/cygstress
new file mode 100755
index 000000000..21e4cb1a6
--- /dev/null
+++ b/winsup/testsuite/stress/cygstress
@@ -0,0 +1,602 @@
+#!/bin/bash
+#
+# Run stress-ng on Cygwin
+#
+# Copyright 2025 Christian Franke
+#
+# SPDX-License-Identifier: BSD-3-Clause
+#
+
+set -e -o pipefail
+
+usage()
+{
+  cat <<EOF
+Usage: ${0##*/} [OPTION...] {CI|WORK|FAIL|test...}
+
+  -n        print commands only (dry-run)
+  -f        force execution of tests tagged 'heavy' or 'admin'
+  -c LIST   set CPU affinity to LIST
+  -s PATH   stress-ng executable [default: stress-ng]
+  -t N      run each test for at least N seconds [default: 5]
+  -w N      start N workers for each test [default: 2]
+
+  CI        run all tests tagged CI
+  WORK      run all tests tagged WORKS
+  FAIL      run all tests tagged FAILS
+  test...   run individual test(s) (may require '-f')
+EOF
+  exit 1
+}
+
+# Tags:
+# WORKS: works on Cygwin (3.7.0-0.51.gd35cc82b5ec1)
+# WORKS,CI: possibly suitable subset for Cygwin CI test.
+# FAILS: fails on Cygwin, see "TODO Cygwin" for details.
+# heavy: heavy resource usage, may work, hang, freeze desktop, require reset, ...
+# admin: requires administrator, may work or not, may be 'heavy' or not.
+# -----: unsupported due to missing API, library, declaration, ...
+
+stress_tests='
+# TEST [ARGS]   # Tag       # Comment
+  access        # FAILS     # TODO undecided: "access 004 on chmod mode 400 failed: 13 (Permission denied)"
+  acl           # WORKS,CI  # (fixed in stress-ng 0.18.12)
+  affinity      # WORKS
+  af-alg        # -----     # requires AF_ALG
+  aio           # WORKS
+  aiol          # -----     # requires io_setup(2), io_submit(2), ...
+  alarm         # WORKS,CI
+  apparmor      # -----
+  atomic        # WORKS
+
+  bad-altstack  # WORKS
+  bad-ioctl     # -----
+  besselmath    # WORKS
+  bigheap       # heavy
+  binderfs      # -----
+  bind-mount    # -----
+  bitonicsort   # WORKS
+  bitops        # WORKS
+  branch        # WORKS
+  brk           # heavy     # allocates memory until OOM
+  bsearch       # WORKS
+  bubblesort    # WORKS
+
+  cache         # WORKS
+  cacheline     # WORKS
+  cachehammer   # WORKS
+  cap           # -----
+  cgroup        # -----
+  chattr        # -----
+  chdir         # WORKS,CI
+  chmod         # WORKS,CI
+  chown         # FAILS     # TODO undecided: "fchown failed, errno=22 (Invalid argument)"
+  chroot        # admin
+  clock         # WORKS,CI  # (fixed in stress-ng 0.18.12: "timer_create failed for timer ...
+                            #  ... ''CLOCK_THREAD_CPUTIME_ID'', errno=134")
+  clone         # -----
+  close         # FAILS     # TODO Cygwin: close(2) is not thread-safe
+  context       # WORKS,CI  # (fixed in Cygwin 3.6.0: signals lost after swapcontext)
+  copy-file     # -----
+  cpu           # WORKS
+  cpu-online    # -----
+  cpu-sched     # FAILS     # TODO undecided: "child died: signal 9 ''SIGKILL''"
+                            # (fixed in Cygwin 3.6.0: signals lost after SIGSTOP)
+  crypt         # WORKS     # uses libcrypt
+  cyclic        # admin
+
+  daemon        # WORKS
+  dccp          # -----
+  dekker        # WORKS
+  dentry        # WORKS
+  dev           # FAILS     # TODO Cygwin: "*** fatal error in forked process - pthread_mutex::_fixup_after_fork () ...
+                            # ... doesn''t understand PROCESS_SHARED mutex''s"
+  dev-shm       # -----
+  dfp           # WORKS
+  dir           # WORKS
+  dirdeep       # heavy     # creates deep dir tree
+  dirmany       # heavy     # creates many dirs/files
+  dnotify       # -----
+  dup           # WORKS,CI
+  dynlib        # -----
+
+  easy-opcode   # WORKS
+  eigen         # WORKS
+  efivar        # -----
+  enosys        # -----
+  env           # heavy     # creates very large environment until OOM
+  epoll         # -----
+  eventfd       # -----
+  exec          # WORKS,CI
+  exit-group    # -----
+  expmath       # WORKS
+
+  factor        # WORKS     # uses libgmp
+  fallocate     # WORKS,CI
+  fanotify      # -----
+  far-branch    # WORKS
+  fault         # WORKS
+  fcntl         # FAILS     # TODO this script: fixed in stress-ng >0.18.12: "F_SETLKW (F_WRLCK) failed: ...
+                            #                   ... errno=45 (Resource deadlock avoided)"
+                            # (fixed in Cygwin 3.6.1: "ftruncate failed, errno=21 (Is a directory)")
+  fd-fork       # WORKS,CI
+  fd-race       # -----     # TODO stress-ng: drop restriction to Linux
+                            # TODO Cygwin: close(2) is not thread-safe, see also "close"
+  fibsearch     # WORKS
+  fiemap        # -----
+  fifo          # WORKS
+  file-ioctl    # WORKS,CI
+  filename      # FAILS     # TODO Cygwin: creates files Cygwin cannot remove later, please see:
+                            #   https://sourceware.org/pipermail/cygwin/2024-September/256451.html
+  filename --filename-opts posix # WORKS,CI # restricts filenames to POSIX charset
+# filerace      # WORKS     # TODO this script: added in stress-ng >0.18.12
+  flipflop      # WORKS
+  flock         # WORKS,CI
+  flushcache    # WORKS
+  fma           # WORKS
+  fork          # WORKS,CI
+  forkheavy     # heavy     # forks until process table is full
+  fp            # WORKS,CI
+  fp-error      # WORKS,CI
+  fpunch        # FAILS     # TODO this script: fixed in stress-ng >0.18.12
+  fractal       # WORKS
+  fsize         # heavy     # creates large files until disk is full
+  fstat         # WORKS,CI
+  full          # -----     # requires pread/pwrite() working on /dev/full
+  funccall      # WORKS
+  funcret       # WORKS
+  futex         # -----
+
+  get           # WORKS
+  getdent       # -----
+  getrandom     # -----
+  goto          # WORKS
+  gpu           # -----
+
+  handle        # -----     # requires name/open_by_handle_at(2)
+  hash          # WORKS
+  hdd           # WORKS
+  heapsort      # WORKS     # uses libbsd
+  hrtimers      # WORKS,CI  # (fixed in Cygwin 3.5.7: "timer_delete failed")
+  hsearch       # WORKS
+  hyperbolic    # WORKS
+
+  icache        # WORKS
+  icmp-flood    # -----     # requires "struct icmphdr", ... in <netinet/*.h>
+  idle-page     # -----     # requires /sys/kernel/mm/page_idle/bitmap
+  inode-flags   # -----
+  inotify       # -----     # requires inotify_*(2)
+  insertionsort # WORKS
+  intmath       # WORKS
+  io            # WORKS
+  iomix         # WORKS
+  ioport        # -----
+  ioprio        # -----
+  io-uring      # -----
+  ipsec-mb      # -----     # requires libipsec-mb
+  itimer        # WORKS,CI
+
+  jpeg          # WORKS     # uses libjpeg
+  judy          # -----     # requires libJudy (ORPHANED)
+
+  kcmp          # -----
+  key           # -----
+  kill          # WORKS,CI
+  klog          # -----
+  kvm           # -----
+
+  l1cache       # -----     # requires /sys/devices/system/cpu
+  l1cache --l1cache-line-size 32768 --l1cache-ways 8 --l1cache-sets 1 # WORKS
+  landlock      # -----
+  lease         # -----
+  led           # -----
+  link          # WORKS,CI
+  list          # WORKS
+  llc-affinity  # WORKS
+  loadavg       # WORKS
+  locka         # WORKS
+  lockbus       # WORKS
+  lockf         # WORKS,CI  # (fixed in Cygwin 3.5.5: "NtCreateEvent(lock): 0xC000003" and ...
+                            #  "can''t handle more than 910 locks per file")
+  lockmix       # WORKS
+  lockofd       # -----
+  logmath       # WORKS,CI  # (fixed in Cygwin 3.5.5: signal handler destroys long double values)
+  longjmp       # WORKS,CI  # (fixed in Cygwin 3.5.5: signals lost during setjmp or longjmp)
+  loop          # -----
+  lsearch       # WORKS
+  lsm           # -----
+
+  madvise       # WORKS
+  malloc        # WORKS,CI
+  matrix        # WORKS
+  matrix-3d     # WORKS
+  mcontend      # WORKS
+  membarrier    # -----
+  memcpy        # WORKS,CI  # (fixed in Cygwin 3.6.1: crash due to set DF in signal handler)
+  memfd         # -----
+  memhotplug    # -----
+  memrate       # WORKS
+  memthrash     # WORKS
+  mergesort     # WORKS     # uses libbsd
+  metamix       # FAILS     # TODO Cygwin: "fdatasync on ./tmp-stress-ng-metamix-*/... failed, errno=13"
+  mincore       # -----
+  min-nanosleep # WORKS
+  misaligned    # WORKS
+  mknod         # -----
+  mlock         # WORKS
+  mlockmany     # heavy     # requires --pathological
+  mmap          # WORKS,CI
+  mmapaddr      # WORKS
+  mmapfork      # WORKS
+  mmapfiles     # WORKS
+  mmapfixed     # WORKS
+  mmaphuge      # -----
+  mmapmany      # WORKS
+  mmaptorture   # heavy
+  module        # -----
+  monte-carlo   # WORKS
+  mpfr          # WORKS     # uses libmpfr
+  mprotect      # FAILS     # TODO Cygwin: crashes or hangs and then ignores SIGKILL
+  mq            # FAILS     # TODO undecided: "fail: ... mq_[timed]receive failed, errno=1"
+                            # (fixed in Cygwin 3.5.6: crash on invalid mq fd)
+  mremap        # -----
+  mseal         # -----
+  msg           # WORKS
+  msync         # WORKS
+  msyncmany     # WORKS
+  mtx           # WORKS
+  munmap        # -----
+  mutex         # WORKS
+
+  nanosleep     # FAILS     # TODO undecided: "detected 1 unexpected nanosleep underruns"
+  netdev        # -----
+  netlink-proc  # -----
+  netlink-task  # -----
+  nice          # heavy     # TODO Cygwin: may change nice value of other processes
+  nop           # WORKS
+  null          # WORKS
+  numa          # -----
+
+  oom-pipe      # -----
+  opcode        # -----
+  open          # WORKS,CI
+
+  pagemove      # -----
+  pageswap      # -----
+  pci           # -----
+  personality   # -----
+  peterson      # WORKS
+  physmmap      # -----
+  physpage      # -----
+  pidfd         # -----
+  ping-sock     # -----
+  pipe          # WORKS,CI
+  pipeherd      # heavy     # many forks, may freeze desktop
+  pkey          # -----
+  plugin        # -----
+  poll          # WORKS
+  powmath       # WORKS
+  prctl         # -----
+  prefetch      # WORKS
+  prime         # WORKS     # uses libgmp
+  prio-inv      # -----     # requires <pthread_nt.h>
+  priv-instr    # FAILS     # TODO Cygwin: crashes or hangs, please see:
+                            #   https://sourceware.org/pipermail/cygwin/2025-March/257726.html
+  procfs        # -----     # TODO stress-ng: support /proc subset of Cygwin
+  pseek         # WORKS,CI  # (fixed in Cygwin 3.5.5: "pread: Bad file descriptor")
+  pthread       # WORKS,CI
+  ptr-chase     # WORKS
+  ptrace        # -----
+  pty           # WORKS,CI  # (fixed in Cygwin 3.7.0: implement tcdrain/tcflow/TIOCINQ for pty)
+                            # (fixed in Cygwin 3.6.1: "No pty allocated, errno=0")
+  qsort         # WORKS
+  quota         # -----
+
+  race-sched    # WORKS
+  radixsort     # WORKS     # uses libbsd
+  ramfs         # -----
+  rawdev        # -----
+  randlist      # WORKS
+  rawsock       # -----
+  rawpkt        # -----     # requires <linux/if_packet.h>, ...
+  rawudp        # -----
+  rdrand        # WORKS
+  readahead     # -----
+  reboot        # -----
+  regex         # WORKS
+  regs          # WORKS
+  remap         # -----
+  rename        # WORKS,CI
+  resched       # heavy
+  resources     # heavy
+  revio         # WORKS
+  ring-pipe     # WORKS
+  rlimit        # heavy
+  rmap          # WORKS
+  rotate        # WORKS
+  rseq          # -----
+  rtc           # -----     # requires /dev/rtc
+
+  schedmix      # WORKS
+  schedpolicy   # WORKS,CI
+  sctp          # -----
+  seal          # -----
+  seccomp       # -----
+  secretmem     # -----
+  seek          # WORKS,CI
+  sem           # FAILS     # TODO Cygwin: "instance 0 corrupted bogo-ops counter, 556328 vs 556327"
+  sem-sysv      # FAILS     # TODO Cygwin: "aborted early, out of system resources"
+  sendfile      # -----     # requires sendfile(2)
+  session       # WORKS
+  set           # FAILS     # TODO stress-ng: "setrlimit failed, ..., expected -EPERM, instead got errno=22 (Invalid argument)"
+  shellsort     # WORKS
+  shm           # WORKS,CI
+  shm-sysv      # -----     # requires shmat(2), smdt(2)
+  sigabrt       # WORKS,CI
+  sigbus        # FAILS     # TODO Cygwin: "ftruncate file to a single page failed, errno=13 (Permission denied)"
+  sigchld       # FAILS     # TODO Cygwin: hangs
+  sigfd         # -----     # TODO Cygwin: "stressor terminated with unexpected signal 11 ''SIGSEGV''"
+                            # (fixed in stress-ng >0.18.12: drop restriction to glibc)
+  sigfpe        # FAILS     # TODO undecided: "got SIGFPE error 15 (FPE_INTDEV), expecting 20 (FPE_FLTRES)"
+  sighup        # WORKS,CI
+  sigill        # FAILS     # TODO Cygwin: "terminated on signal: 11", possibly similar to "priv-instr"
+  sigio         # -----     # requires O_ASYNC
+  signal        # WORKS,CI
+  signest       # FAILS     # TODO Cygwin: "terminated on signal: 11"
+  sigpending    # WORKS,CI
+  sigpipe       # WORKS,CI
+  sigq          # WORKS,CI
+  sigrt         # WORKS,CI
+  sigsegv       # FAILS     # TODO Cygwin: crashes or hangs, possibly similar to "priv-instr"
+  sigsuspend    # WORKS,CI
+  sigtrap       # WORKS,CI
+  sigurg        # WORKS,CI
+  sigvtalrm     # WORKS,CI
+  sigxcpu       # FAILS     # TODO stress-ng: "setrlimit failed, errno=22 (Invalid argument)"
+  sigxfsz       # FAILS     # TODO stress-ng: "setrlimit failed, errno=22 (Invalid argument)"
+  skiplist      # WORKS
+  sleep         # WORKS,CI
+  smi           # -----
+  sock          # WORKS
+  sockabuse     # FAILS     # TODO undecided: "recv failed, errno=113 (Software caused connection abort)"
+  sockdiag      # -----
+  sockfd        # -----
+  sockmany      # heavy
+  sockpair      # WORKS
+  softlockup    # admin
+  sparsematrix  # WORKS
+  spawn         # heavy     # TODO Cygwin: "NNN spawns failed (100.00%)", may crash other processes
+  spinmem       # WORKS
+  splice        # -----
+  stack         # heavy
+  stackmmap     # WORKS
+  statmount     # -----
+  str           # WORKS
+  stream        # WORKS     # (fixed in stress-ng >0.18.12: --stream-l3-size set correctly)
+  swap          # -----
+  switch        # WORKS
+  symlink       # WORKS,CI
+  sync-file     # -----
+  syncload      # WORKS
+  sysbadaddr    # heavy
+  syscall       # FAILS     # TODO Cygwin: "terminated on signal: 11"
+  sysinfo       # WORKS
+  sysinval      # -----
+  sysfs         # -----
+
+  tee           # -----     # requires tee(2)
+  timer         # WORKS,CI  # TODO undecided: "1 timer settime calls failed"
+  timerfd       # heavy     # TODO undecided: may freeze desktop
+  time-warp     # WORKS
+  tlb-shootdown # heavy
+  tmpfs         # -----     # requires tmpfs filesystem
+  touch         # WORKS
+  tree          # WORKS     # (fixed in Cygwin 3.6.1: crash due to set DF in signal handler, see also "memcpy")
+  trig          # WORKS
+  tsc           # WORKS
+  tsearch       # WORKS
+  tun           # -----
+
+  udp           # WORKS
+  udp-flood     # -----     # requires AF_PACKET
+  umask         # WORKS
+  umount        # -----
+  unlink        # WORKS,CI
+  unshare       # -----
+  uprobe        # -----
+  urandom       # WORKS
+  userfaultfd   # -----
+  usersyscall   # -----
+  utime         # WORKS,CI
+
+  vdso          # -----
+  veccmp        # WORKS
+  vecfp         # WORKS
+  vecmath       # WORKS
+  vecshuf       # WORKS
+  vecwide       # WORKS
+  verity        # -----
+  vfork         # WORKS
+  vforkmany     # heavy     # forks until process table is full
+  vm            # WORKS,CI
+  vm-addr       # WORKS
+  vm-rw         # -----
+  vm-segv       # WORKS
+  vm-splice     # -----
+  vma           # WORKS
+  vnni          # WORKS
+
+  wait          # FAILS     # TODO Cygwin: hangs in few cases
+  waitcpu       # WORKS
+  watchdog      # -----
+  wcs           # WORKS
+  workload      # WORKS,CI  # (fixed in Cygwin 3.5.5: hang in mq_send/receive)
+
+  x86cpuid      # WORKS
+  x86syscall    # -----
+  xattr         # FAILS     # TODO Cygwin: "fsetxattr succeeded unexpectedly, created ...
+                            # "... attribute with size greater than permitted size, errno=61"
+  yield         # WORKS
+
+  zero          # WORKS,CI
+  zlib          # WORKS     # uses libz
+  zombie        # WORKS,CI
+'
+
+stress_ng="stress-ng"
+timeout=5; workers=2
+dryrun=false; force=false
+taskset=
+
+while :; do case $1 in
+  -c) shift; taskset=$1 ;;
+  -f) force=true ;;
+  -n) dryrun=true ;;
+  -s) shift; stress_ng=$1 ;;
+  -t) shift; timeout=$1 ;;
+  -w) shift; workers=$1 ;;
+  -*) usage ;;
+  *) break ;;
+esac; shift || usage; done
+
+run_ci=false; run_work=false; run_fail=false
+run_tests=
+
+while [ $# -ge 1 ]; do case $1 in
+  CI) run_ci=true ;;  WORK) run_work=true ;; FAIL) run_fail=true ;;
+  [a-z]*[a-z]) run_tests+=" $1" ;;
+  *) usage ;;
+esac; shift; done
+$run_ci || $run_work || $run_fail || [ ${run_tests:+t} ] || usage
+
+command -V "$stress_ng" >/dev/null || exit 1
+
+# SIGKILL may not work if stress-ng hangs.
+# Use Windows 'taskkill' as no 'killall --force' is available.
+command -V taskkill >/dev/null || exit 1
+
+stress_ng_name=${stress_ng##*/}
+tempdir=${TMP:-/tmp}
+
+find_stress()
+{
+  local p=$(procps -C "$stress_ng_name" -o pid,ppid,s,pri,ni,tt,start,time,args --sort pid)
+  test "$(wc -l <<< "$p")" -gt 1 || return 1
+  echo "$p"
+}
+
+stop_stress()
+{
+  echo '$' taskkill /F /T /IM "${stress_ng_name}.exe"
+  taskkill /F /T /IM "${stress_ng_name}.exe" ||:
+}
+
+total=0
+fails=0
+
+# stress TEST [OPTION...]
+stress()
+{
+  local name=$1
+  shift || return 1
+
+  local td="$tempdir/stress-ng.$$.$total.d"
+  local cmd=("$stress_ng" -v -M --oomable --timestamp --verify --temp-path "$td" -t "$timeout")
+  test -z "$taskset" || cmd+=(--taskset "$taskset")
+  cmd+=(--"$name" "$workers" "$@")
+
+  echo '$' "${cmd[@]}"
+  ! $dryrun || return 0
+
+  (
+    t=$(date +%s); : $((t += timeout + 30)); sleep 1
+    while [ "$(date +%s)" -lt "$t" ]; do sleep 1; done
+    stop_stress & # TODO: without '&', 'exit 0' below is not reached (Hmm...)
+    exit 0
+  ) &
+  local watchdog=$!
+  trap "kill $watchdog 2>/dev/null ||:; exit 130" SIGINT SIGTERM
+
+  mkdir "$td"
+  local rc=0
+  "${cmd[@]}" || rc=$?
+
+  kill $watchdog 2>/dev/null ||:
+  trap - SIGINT SIGTERM
+
+  local ok=true
+  if wait $watchdog; then
+    sleep 2
+    echo ">>> FAILURE: $name" "$@" "(command hangs)"
+    ok=false
+  fi
+
+  local p
+  if p=$(find_stress); then
+    echo ">>> FAILURE: $name" "$@" "(processes left, exit status $rc):"
+    echo "$p"
+    stop_stress
+    sleep 2
+    ok=false
+  fi
+
+  if ! rmdir "$td" 2>/dev/null; then
+    echo ">>> FAILURE: $name" "$@" "(files left in '$td', exit status $rc)"
+    ok=false
+  fi
+
+  if ! $ok; then
+    echo
+    return 1
+  fi
+  if [ $rc != 0 ]; then
+    echo ">>> FAILURE: $name" "$@" "(exit status $rc)"; echo
+    return 1
+  fi
+  echo ">>> SUCCESS: $name" "$@" ""; echo
+}
+
+if p=$(find_stress); then
+  echo "*** Other $stress_ng_name processes are still running:"
+  echo "$p"
+  $dryrun || exit 1
+fi
+
+while read; do
+  args=${REPLY#*|}
+  name=${args%% *}
+  run_this=false
+  for t in $run_tests; do if [ "$t" = "$name" ]; then
+    run_this=true; break
+  fi; done
+
+  tag=${REPLY%%|*}
+  case $tag in
+    FAILS) $run_this || $run_fail || continue ;;
+    WORKS) $run_this || $run_work || continue ;;
+    WORKS,CI) $run_this || $run_work || $run_ci || continue ;;
+    -----) $run_this || continue ;;
+    admin|heavy)
+      $run_this || continue
+      if ! $force; then
+        echo ">>> SKIPPED: $name (tagged '$tag', use '-f' to override)"; echo
+        continue
+      fi ;;
+    *) echo "*** syntax error: '$REPLY'"; exit 1 ;;
+  esac
+
+  : $((++total))
+  stress $args ||: $((++fails))
+done <<<"$(
+  sed -E \
+    -e 's/^ *([-0-9a-z]+)( +-[^#]*[^ #])? +# *(FAILS|WORKS(,CI)?|admin|heavy|-----) *(#.*)?$/\3|\1\2/' \
+    -e '/^ *(#.*)?$/d' \
+    <<<"$stress_tests"
+)"
+
+if [ $fails -ne 0 ]; then
+  echo ">>> FAILURE: $fails of $total stress test(s) failed"
+  exit 1
+fi
+echo ">>> SUCCESS: All $total stress test(s) succeeded"
+exit 0
-- 
2.45.1

