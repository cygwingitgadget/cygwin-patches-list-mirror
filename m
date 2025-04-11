Return-Path: <SRS0=teM6=W5=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.128])
	by sourceware.org (Postfix) with ESMTP id 5B7BA3857350
	for <cygwin-patches@cygwin.com>; Fri, 11 Apr 2025 13:09:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5B7BA3857350
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5B7BA3857350
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.128
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744376956; cv=none;
	b=ZlmWmDgTti7oP1qgiP5UFpHk+Qr6d+lophJcaJuNKm6A3LfH9tm2TzhEiq59R6iFqJQrUEUJBPIH/pgx00XcSxn+xwRSxXy96xgF1OzyGOPPUmhsgNh5SFMdt/+WYWydbO+hfO7OoG1sSEoDoeRDZJWvnDvawEAQAXGASiuR8Cs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744376956; c=relaxed/simple;
	bh=Cz1cO/v2EFRgV0PnDj3lxlWZuhJXV+FYi1BBqjrhgd0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=D0WmdIMI+UWuxI2mpPoFIihlXPTvlW1xKMOpe+2QjC3o05st21+k38Get3XLe8nvY1aI9dNmBKttA6K9o/4+zetBVkFuA1KgoWHNM1nTJce9w0Z5H8tJVjgXmhYB850Imz5eepIfKcADmI+bV5GZVHzg2/kXueibI6pEXYEo330=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5B7BA3857350
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 67D89CAE02F8E5B4
X-Originating-IP: [81.129.146.194]
X-OWM-Source-IP: 81.129.146.194
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddukeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvdefhffhgeefjefgffeivdetueeigeffueetgfehteelgfekvdehjeehudevieeunecuffhomhgrihhnpehshihsihhnthgvrhhnrghlshdrtghomhdpshhouhhrtggvfigrrhgvrdhorhhgnecukfhppeekuddruddvledrudegiedrudelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduvdelrddugeeirdduleegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduvdelqddugeeiqdduleegrdhrrghnghgvkeduqdduvdelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdegpdhnsggprhgtphht
	thhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.194) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89CAE02F8E5B4; Fri, 11 Apr 2025 14:09:15 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/4] Cygwin: CI: Run stress-ng
Date: Fri, 11 Apr 2025 14:08:43 +0100
Message-ID: <20250411130846.3355-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250411130846.3355-1-jon.turney@dronecode.org.uk>
References: <20250411130846.3355-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 .github/workflows/cygwin.yml      |  22 +-
 winsup/testsuite/stress/cygstress | 603 ++++++++++++++++++++++++++++++
 2 files changed, 623 insertions(+), 2 deletions(-)
 create mode 100755 winsup/testsuite/stress/cygstress

diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
index 79abf3d0f..871ec3d3a 100644
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
@@ -234,8 +242,18 @@ jobs:
     # package of the just-built cygwin version and install it here, but tools
     # don't exist (yet) to let us do that...
 
-    # run tests
+    - name: Install SysInternals pskill
+      run: |
+        wget -nv https://download.sysinternals.com/files/PSTools.zip
+        unzip PSTools.zip pskill.exe -d /usr/bin
+        chmod +x /usr/bin/pskill
+        pskill -nobanner -accepteula || true
+      shell: bash --noprofile --norc -o igncr -eo pipefail '{0}'
+
+    # run stress-test
     - name: Run tests
       run: |
+        export PATH=/usr/bin:$(cygpath ${SYSTEMROOT})/system32
         uname -a
+        winsup/testsuite/stress/cygstress CI
       shell: bash --noprofile --norc -o igncr -eo pipefail '{0}'
diff --git a/winsup/testsuite/stress/cygstress b/winsup/testsuite/stress/cygstress
new file mode 100755
index 000000000..493ff3e8b
--- /dev/null
+++ b/winsup/testsuite/stress/cygstress
@@ -0,0 +1,603 @@
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
+  -k PATH   tool to stop hanging tests [default: pskill]
+  -s PATH   stress-ng executable [default: stress-ng]
+  -t N      run each test for at least N seconds [default: 5]
+  -w N      start N workers for each test [default: 2]
+
+  CI        run all tests tagged CI
+  WORK      run all tests tagged WORKS
+  FAIL      run all tests tagged FAILS
+  test...   run invidual test(s) (may require '-f')
+EOF
+  exit 1
+}
+
+# Tags:
+# WORKS: works on Cygwin (3.7.0-0.43.g779e46b5b3ee)
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
+  fcntl         # FAILS     # TODO Cygwin: "ftruncate failed, errno=21 (Is a directory)", please see:
+                            #   https://sourceware.org/pipermail/cygwin/2025-April/257871.html
+  fd-fork       # WORKS,CI
+  fd-race       # -----     # TODO stress-ng: drop Linux restriction (but then it FAILS)
+  fibsearch     # WORKS
+  fiemap        # -----
+  fifo          # WORKS
+  file-ioctl    # WORKS,CI
+  filename      # FAILS     # TODO Cygwin: creates files Cygwin cannot remove later, please see:
+                            #   https://sourceware.org/pipermail/cygwin/2024-September/256451.html
+  filename --filename-opts posix # WORKS,CI # restricts filenames to POSIX charset
+# filerace      # WORKS     # TODO this script: add in stress-ng >0.18.12
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
+  memcpy        # WORKS,CI  # (fixed in Cygwin >3.6.0: crash due to set DF in signal handler)
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
+  mprotect      # FAILS     # TODO Cygwin: crashes or hangs
+  mq            # FAILS     # TODO Cygwin: "mq_receive failed, errno=1"
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
+  pty           # FAILS     # TODO stress-ng: do not require tcdrain/tcflow/TIOCINQ for pty, or ...
+                            # ... TODO Cygwin: implement tcdrain/tcflow/TIOCINQ for pty :-)
+                            # (fixed in Cygwin 3.7.0: "No pty allocated, errno=0")
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
+  sigfd         # -----     # TODO stress-ng: drop restriction to glibc (WORKS then)
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
+  sockabuse     # WORKS
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
+  stream        # WORKS     # TODO stress-ng: get --stream-l3-size for /proc/cpuinfo
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
+  timer         # WORKS,CI
+  timerfd       # heavy     # TODO undecided: may freeze desktop
+  time-warp     # WORKS
+  tlb-shootdown # heavy
+  tmpfs         # -----     # requires tmpfs filesystem
+  touch         # WORKS
+  tree          # WORKS     # (fixed in Cygwin >3.6.0: crash due to set DF in signal handler, see also "memcpy")
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
+# SIGKILL may not work if stress-ng hangs.
+# Use Sysinternals 'pskill' as no 'killall --force' is available,
+killall_force="pskill"
+
+stress_ng="stress-ng"
+timeout=5; workers=2
+dryrun=false; force=false
+taskset=
+
+while :; do case $1 in
+  -c) shift; taskset=$1 ;;
+  -f) force=true ;;
+  -k) shift; killall_force=$1 ;;
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
+for t in "$@"; do case $t in
+  CI) run_ci=true ;;  WORK) run_work=true ;; FAIL) run_fail=true ;;
+  [a-z]*[a-z]) run_tests+=" $t" ;;
+  *) usage ;;
+esac; done
+$run_ci || $run_work || $run_fail || [ ${run_tests:+t} ] || usage
+
+command -V "$stress_ng" >/dev/null || exit 1
+command -V "$killall_force" >/dev/null || exit 1
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
+  echo '$' "$killall_force" "$stress_ng_name"
+  "$killall_force" "$stress_ng_name" ||:
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
+    echo ">>> FAILURE: $name" "$@" "(command hangs)"
+    sleep 2
+    ok=false
+  fi
+
+  local n=0 p
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
+        echo ">>> SKIPPED $name (tagged '$tag', use '-f' to override)"; echo
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

