Return-Path: <SRS0=Pl6r=5H=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-043.btinternet.com (mailomta5-re.btinternet.com [213.120.69.98])
	by sourceware.org (Postfix) with ESMTPS id 58358385B529
	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2023 16:37:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 58358385B529
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20230110163740.XMPS21016.re-prd-fep-043.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 10 Jan 2023 16:37:40 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 61A69BAC3ED8A398
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrledvgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 61A69BAC3ED8A398; Tue, 10 Jan 2023 16:37:40 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/8] Cygwin: testsuite: Fix compilation warnings
Date: Tue, 10 Jan 2023 16:37:04 +0000
Message-Id: <20230110163709.16265-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110163709.16265-1-jon.turney@dronecode.org.uk>
References: <20230110163709.16265-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fix the warnings the previous change surfaces.

See ltp commit d5c2112f for mmap fixes.
---
 winsup/testsuite/libltp/include/usctest.h  |  2 +-
 winsup/testsuite/winsup.api/ltp/execv01.c  |  2 +-
 winsup/testsuite/winsup.api/ltp/execve01.c |  2 +-
 winsup/testsuite/winsup.api/ltp/execvp01.c |  2 +-
 winsup/testsuite/winsup.api/ltp/mmap02.c   | 10 ++++------
 winsup/testsuite/winsup.api/ltp/mmap03.c   | 10 ++++------
 winsup/testsuite/winsup.api/ltp/mmap04.c   | 10 ++++------
 winsup/testsuite/winsup.api/ltp/mmap05.c   | 10 +++++-----
 winsup/testsuite/winsup.api/ltp/mmap06.c   |  8 +++++---
 winsup/testsuite/winsup.api/ltp/mmap07.c   |  8 +++++---
 winsup/testsuite/winsup.api/ltp/mmap08.c   |  8 +++++---
 winsup/testsuite/winsup.api/mmaptest03.c   |  2 +-
 winsup/testsuite/winsup.api/systemcall.c   |  2 +-
 winsup/testsuite/winsup.api/user_malloc.c  |  4 ++--
 14 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/winsup/testsuite/libltp/include/usctest.h b/winsup/testsuite/libltp/include/usctest.h
index fef349d04..637635a25 100644
--- a/winsup/testsuite/libltp/include/usctest.h
+++ b/winsup/testsuite/libltp/include/usctest.h
@@ -210,7 +210,7 @@ extern void STD_opts_help();
  *	SCALL = system call and parameters to execute
  *
  ***********************************************************************/
-#define TEST(SCALL) TEST_RETURN = SCALL;  TEST_ERRNO=errno;
+#define TEST(SCALL) TEST_RETURN = (long) SCALL;  TEST_ERRNO=errno;
 
 /***********************************************************************
  * TEST_VOID: calls a system call
diff --git a/winsup/testsuite/winsup.api/ltp/execv01.c b/winsup/testsuite/winsup.api/ltp/execv01.c
index f59f29702..dca62c523 100644
--- a/winsup/testsuite/winsup.api/ltp/execv01.c
+++ b/winsup/testsuite/winsup.api/ltp/execv01.c
@@ -130,7 +130,7 @@ int exp_enos[]={0, 0};		/* Zero terminated list of expected errnos */
 
 int pid;		/* process id from fork */
 int status;		/* status returned from waitpid */
-const char * const args[2]={"/usr/bin/test", 0};	/* argument list for execv call */
+char * const args[2]={"/usr/bin/test", 0};	/* argument list for execv call */
 
 int
 main(int ac, char **av)
diff --git a/winsup/testsuite/winsup.api/ltp/execve01.c b/winsup/testsuite/winsup.api/ltp/execve01.c
index 2584bdf05..eb5073d31 100644
--- a/winsup/testsuite/winsup.api/ltp/execve01.c
+++ b/winsup/testsuite/winsup.api/ltp/execve01.c
@@ -133,7 +133,7 @@ int exp_enos[]={0, 0};		/* Zero terminated list of expected errnos */
 
 int pid;			/* process id from fork */
 int status;			/* status returned from waitpid */
-const char *const args[2]={"/usr/bin/test", 0};	/* argument list for execve call */
+char *const args[2]={"/usr/bin/test", 0};	/* argument list for execve call */
 extern char **environ;		/* pointer to this processes env, to pass along */
 
 int
diff --git a/winsup/testsuite/winsup.api/ltp/execvp01.c b/winsup/testsuite/winsup.api/ltp/execvp01.c
index 8a1726a21..1473ccf66 100644
--- a/winsup/testsuite/winsup.api/ltp/execvp01.c
+++ b/winsup/testsuite/winsup.api/ltp/execvp01.c
@@ -133,7 +133,7 @@ int exp_enos[]={0, 0};		/* Zero terminated list of expected errnos */
 
 int pid;		/* process id from fork */
 int status;		/* status returned from waitpid */
-const char *const args[2]={"/usr/bin/test", 0};	/* argument list for execvp call */
+char *const args[2]={"/usr/bin/test", 0};	/* argument list for execvp call */
 
 int
 main(int ac, char **av)
diff --git a/winsup/testsuite/winsup.api/ltp/mmap02.c b/winsup/testsuite/winsup.api/ltp/mmap02.c
index b96bdb452..ca9f4d956 100644
--- a/winsup/testsuite/winsup.api/ltp/mmap02.c
+++ b/winsup/testsuite/winsup.api/ltp/mmap02.c
@@ -118,11 +118,12 @@ main(int ac, char **av)
 		 * Call mmap to map the temporary file 'TEMPFILE'
 	 	 * with read access.
 		 */
-		TEST(mmap(0, page_sz, PROT_READ,
-			    MAP_FILE|MAP_SHARED, fildes, 0));
+		errno = 0;
+		addr = mmap(0, page_sz, PROT_READ,
+			    MAP_FILE|MAP_SHARED, fildes, 0);
 
 		/* Check for the return value of mmap() */
-		if (TEST_RETURN == (int)MAP_FAILED) {
+		if (addr == MAP_FAILED) {
 			tst_resm(TFAIL, "mmap() Failed on %s, errno=%d : %s",
 				 TEMPFILE, errno, strerror(errno));
 			continue;
@@ -132,9 +133,6 @@ main(int ac, char **av)
 		 * executed without (-f) option.
 		 */
 		if (STD_FUNCTIONAL_TEST) {
-			/* Get the mmap return value */
-			addr = (char *)TEST_RETURN;
-
 			/*
 			 * Read the file contents into the dummy
 			 * string.
diff --git a/winsup/testsuite/winsup.api/ltp/mmap03.c b/winsup/testsuite/winsup.api/ltp/mmap03.c
index fba512c28..5de5435d3 100644
--- a/winsup/testsuite/winsup.api/ltp/mmap03.c
+++ b/winsup/testsuite/winsup.api/ltp/mmap03.c
@@ -121,11 +121,12 @@ main(int ac, char **av)
 		 * Call mmap to map the temporary file 'TEMPFILE'
 	 	 * with execute access.
 		 */
-		TEST(mmap(0, page_sz, PROT_EXEC,
-			    MAP_FILE|MAP_SHARED, fildes, 0));
+		errno = 0;
+		addr = mmap(0, page_sz, PROT_EXEC,
+			    MAP_FILE|MAP_SHARED, fildes, 0);
 
 		/* Check for the return value of mmap() */
-		if (TEST_RETURN == (int)MAP_FAILED) {
+		if (addr == MAP_FAILED) {
 			tst_resm(TFAIL, "mmap() Failed on %s, errno=%d : %s",
 				 TEMPFILE, errno, strerror(errno));
 			continue;
@@ -135,9 +136,6 @@ main(int ac, char **av)
 		 * executed without (-f) option.
 		 */
 		if (STD_FUNCTIONAL_TEST) {
-			/* Get the mmap return value */
-			addr = (char *)TEST_RETURN;
-
 			/*
 			 * Read the file contents into the dummy
 			 * variable.
diff --git a/winsup/testsuite/winsup.api/ltp/mmap04.c b/winsup/testsuite/winsup.api/ltp/mmap04.c
index dbe25aefd..e69d15a97 100644
--- a/winsup/testsuite/winsup.api/ltp/mmap04.c
+++ b/winsup/testsuite/winsup.api/ltp/mmap04.c
@@ -121,11 +121,12 @@ main(int ac, char **av)
 		 * Call mmap to map the temporary file 'TEMPFILE'
 	 	 * with read and execute access.
 		 */
-		TEST(mmap(0, page_sz, PROT_READ|PROT_EXEC,
-			    MAP_FILE|MAP_SHARED, fildes, 0));
+		errno = 0;
+		addr = mmap(0, page_sz, PROT_READ|PROT_EXEC,
+			    MAP_FILE|MAP_SHARED, fildes, 0);
 
 		/* Check for the return value of mmap() */
-		if (TEST_RETURN == (int)MAP_FAILED) {
+		if (addr == MAP_FAILED) {
 			tst_resm(TFAIL, "mmap() Failed on %s, errno=%d : %s",
 				 TEMPFILE, errno, strerror(errno));
 			continue;
@@ -136,9 +137,6 @@ main(int ac, char **av)
 		 * executed without (-f) option.
 		 */
 		if (STD_FUNCTIONAL_TEST) {
-			/* Get the mmap return value */
-			addr = (char *)TEST_RETURN;
-
 			/*
 			 * Read the file contents into the dummy
 			 * variable.
diff --git a/winsup/testsuite/winsup.api/ltp/mmap05.c b/winsup/testsuite/winsup.api/ltp/mmap05.c
index 6e75ee222..600cd761e 100644
--- a/winsup/testsuite/winsup.api/ltp/mmap05.c
+++ b/winsup/testsuite/winsup.api/ltp/mmap05.c
@@ -125,12 +125,12 @@ main(int ac, char **av)
 		 * Call mmap to map the temporary file 'TEMPFILE'
 	 	 * with no access.
 		 */
-		
-		TEST(mmap(0, page_sz, PROT_NONE,
-			  MAP_FILE|MAP_SHARED, fildes, 0));
+		errno = 0;
+		addr = mmap(0, page_sz, PROT_NONE,
+			    MAP_FILE|MAP_SHARED, fildes, 0);
 
 		/* Check for the return value of mmap() */
-		if (TEST_RETURN == (int)MAP_FAILED) {
+		if (addr == MAP_FAILED) {
 			tst_resm(TFAIL, "mmap() Failed on %s, errno=%d : %s",
 				 TEMPFILE, errno, strerror(errno));
 			continue;
@@ -264,7 +264,7 @@ setup()
  *   is not accessible.
  */
 void
-sig_handler(sig)
+sig_handler(int sig)
 {
 	if (sig == SIGSEGV) {
 		/* set the global variable and jump back */
diff --git a/winsup/testsuite/winsup.api/ltp/mmap06.c b/winsup/testsuite/winsup.api/ltp/mmap06.c
index c099f8c33..d089f900b 100644
--- a/winsup/testsuite/winsup.api/ltp/mmap06.c
+++ b/winsup/testsuite/winsup.api/ltp/mmap06.c
@@ -121,11 +121,13 @@ main(int ac, char **av)
 		 * Call mmap to map the temporary file 'TEMPFILE'
 	 	 * with read access.
 		 */
-		TEST(mmap(0, page_sz, PROT_READ,
-			    MAP_FILE|MAP_SHARED, fildes, 0));
+		errno = 0;
+		addr = mmap(0, page_sz, PROT_READ,
+			    MAP_FILE|MAP_SHARED, fildes, 0);
+		TEST_ERRNO = errno;
 
 		/* Check for the return value of mmap() */
-		if (TEST_RETURN != (int)MAP_FAILED) {
+		if (addr != MAP_FAILED) {
 			tst_resm(TFAIL, "mmap() returned invalid value, "
 				 "expected: -1");
 			/* Unmap the mapped memory */
diff --git a/winsup/testsuite/winsup.api/ltp/mmap07.c b/winsup/testsuite/winsup.api/ltp/mmap07.c
index 6e3bb5112..4be6129e6 100644
--- a/winsup/testsuite/winsup.api/ltp/mmap07.c
+++ b/winsup/testsuite/winsup.api/ltp/mmap07.c
@@ -122,11 +122,13 @@ main(int ac, char **av)
 		 * Call mmap to map the temporary file 'TEMPFILE'
 	 	 * with write access.
 		 */
-		TEST(mmap(0, page_sz, PROT_WRITE,
-			    MAP_FILE|MAP_PRIVATE, fildes, 0));
+		errno = 0;
+		addr = mmap(0, page_sz, PROT_WRITE,
+			    MAP_FILE|MAP_PRIVATE, fildes, 0);
+		TEST_ERRNO = errno;
 
 		/* Check for the return value of mmap() */
-		if (TEST_RETURN != (int)MAP_FAILED) {
+		if (addr != MAP_FAILED) {
 			tst_resm(TFAIL, "mmap() returned invalid value, "
 				 "expected: -1");
 			/* Unmap the mapped memory */
diff --git a/winsup/testsuite/winsup.api/ltp/mmap08.c b/winsup/testsuite/winsup.api/ltp/mmap08.c
index 543c5397b..49b6471e5 100644
--- a/winsup/testsuite/winsup.api/ltp/mmap08.c
+++ b/winsup/testsuite/winsup.api/ltp/mmap08.c
@@ -117,11 +117,13 @@ main(int ac, char **av)
 		 * Call mmap to map the temporary file 'TEMPFILE'
 	 	 * which is already closed. so, fildes is not valid.
 		 */
-		TEST(mmap(0, page_sz, PROT_WRITE,
-			    MAP_FILE|MAP_SHARED, fildes, 0));
+		errno = 0;
+		addr = mmap(0, page_sz, PROT_WRITE,
+			    MAP_FILE|MAP_SHARED, fildes, 0);
+		TEST_ERRNO = errno;
 
 		/* Check for the return value of mmap() */
-		if (TEST_RETURN != (int)MAP_FAILED) {
+		if (addr != MAP_FAILED) {
 			tst_resm(TFAIL, "mmap() returned invalid value, "
 				 "expected: -1");
 			/* Unmap the mapped memory */
diff --git a/winsup/testsuite/winsup.api/mmaptest03.c b/winsup/testsuite/winsup.api/mmaptest03.c
index 8046f0bf8..e28e0f251 100644
--- a/winsup/testsuite/winsup.api/mmaptest03.c
+++ b/winsup/testsuite/winsup.api/mmaptest03.c
@@ -145,7 +145,7 @@ main(int argc, char **argv)
       unlink ("y.txt");
       if (!WIFEXITED (status) || WEXITSTATUS (status))
 	{
-	  printf ("forked process exited with status %p\n", (char *) status);
+	  printf ("forked process exited with status %x\n", status);
 	  return 1;
 	}
     }
diff --git a/winsup/testsuite/winsup.api/systemcall.c b/winsup/testsuite/winsup.api/systemcall.c
index 91dd748c0..d10c9825c 100644
--- a/winsup/testsuite/winsup.api/systemcall.c
+++ b/winsup/testsuite/winsup.api/systemcall.c
@@ -61,7 +61,7 @@ main (int argc, char **argv)
     }
   if (n != 0)
     {
-      fprintf (stderr, "system() call returned %p\n", (void *) n);
+      fprintf (stderr, "system() call returned %x\n", n);
       exit (1);
     }
   exit (0);
diff --git a/winsup/testsuite/winsup.api/user_malloc.c b/winsup/testsuite/winsup.api/user_malloc.c
index 8685f86ab..e2b1e0a92 100644
--- a/winsup/testsuite/winsup.api/user_malloc.c
+++ b/winsup/testsuite/winsup.api/user_malloc.c
@@ -133,11 +133,11 @@ ull * current = buffer;
 
 static int is_valid (void * ptr)
 {
-  unsigned int iptr = (unsigned int) ptr;
+  uintptr_t iptr = (uintptr_t) ptr;
   ull * ullptr = (ull *) ptr;
 
   iptr = (iptr / sizeof(ull)) * sizeof(ull);
-  if (iptr != (int) ptr)
+  if (iptr != (uintptr_t) ptr)
     return 0;
   if (--ullptr < buffer || ullptr[0] > SIZE || ullptr  + ullptr[0]  > current)
     return 0;
-- 
2.39.0

