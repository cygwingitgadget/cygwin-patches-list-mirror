Return-Path: <cygwin-patches-return-3601-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11287 invoked by alias); 19 Feb 2003 22:59:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11276 invoked from network); 19 Feb 2003 22:59:04 -0000
Date: Wed, 19 Feb 2003 22:59:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Fix testsuite failures with GCC 3.4
Message-ID: <20030219235237.V90802-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=1.1 required=6.0
	tests=CARRIAGE_RETURNS,SPAM_PHRASE_00_01
	version=2.44
X-Spam-Level: *
X-SW-Source: 2003-q1/txt/msg00250.txt.bz2


Hi,
this boring patch fixes testsuite failures caused by extra warnings when
using GCC 3.4.  There are also two hunks that remove include of obsolete
varargs.h that causes hard error with GCC 3.4.

Vaclav Haisman

2003-02-19  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
	* winsup.api/crlf.c: Fix C signed/unsigned compare warning.
	* winsup.api/mmaptest01.c: Ditto.
	* winsup.api/ltp/chmod01.c: Ditto.
	* winsup.api/ltp/fork04.c: Ditto.
	* winsup.api/ltp/lseek03.c: Ditto.
	* winsup.api/ltp/lseek06.c: Ditto.
	* winsup.api/ltp/lseek07.c: Ditto.
	* winsup.api/ltp/lseek08.c: Ditto.
	* winsup.api/ltp/mmap001.c: Ditto.
	* winsup.api/ltp/mmap02.c: Ditto.
	* winsup.api/ltp/mmap03.c: Ditto.
	* winsup.api/ltp/mmap04.c: Ditto.
	* winsup.api/ltp/mmap05.c: Ditto.
	* winsup.api/ltp/mmap06.c: Ditto.
	* winsup.api/ltp/mmap07.c: Ditto.
	* winsup.api/ltp/mmap08.c: Ditto.
	* winsup.api/ltp/pipe11.c: Ditto.
	* winsup.api/ltp/poll01.c: Ditto.
	* winsup.api/ltp/sync02.c: Ditto.
	* winsup.api/ltp/times03.c: Ditto.
	* winsup.api/ltp/umask03.c: Ditto.
	* winsup.api/ltp/getpgid01.c: Remove unused obsolete include.
	* winsup.api/ltp/getpgid02.c: Ditto.

Index: testsuite//winsup.api/crlf.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/crlf.c,v
retrieving revision 1.3
diff -p -u -r1.3 crlf.c
--- testsuite//winsup.api/crlf.c	23 Jan 2003 21:21:28 -0000	1.3
+++ testsuite//winsup.api/crlf.c	19 Feb 2003 22:25:42 -0000
@@ -156,7 +156,7 @@ int commands[] = {

 int errors = 0;

-#define num_commands (sizeof(commands)/sizeof(commands[0]))
+#define num_commands (int)(sizeof(commands)/sizeof(commands[0]))

 int pc;
 int askfor, get, expect, count, posn, whence, size;
Index: testsuite//winsup.api/mmaptest01.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/mmaptest01.c,v
retrieving revision 1.5
diff -p -u -r1.5 mmaptest01.c
--- testsuite//winsup.api/mmaptest01.c	24 Jan 2003 01:09:39 -0000	1.5
+++ testsuite//winsup.api/mmaptest01.c	19 Feb 2003 22:25:42 -0000
@@ -87,7 +87,7 @@ int main ()

   char buf3[20];

-  int i;
+  unsigned i;

   strcpy (fnam1, "mmaptest01.1.XXXXXX");
   strcpy (fnam2, "mmaptest01.2.XXXXXX");
Index: testsuite//winsup.api/ltp/chmod01.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/chmod01.c,v
retrieving revision 1.2
diff -p -u -r1.2 chmod01.c
--- testsuite//winsup.api/ltp/chmod01.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/chmod01.c	19 Feb 2003 22:25:42 -0000
@@ -96,7 +96,7 @@ main(int ac, char **av)
 	int lc;			/* loop counter */
 	const char *msg;	/* message returned from parse_opts */
 	int ind;		/* counter variable for chmod(2) tests */
-	int mode;		/* file mode permission */
+	unsigned mode;		/* file mode permission */

 	TST_TOTAL = sizeof(Modes) / sizeof(int);

Index: testsuite//winsup.api/ltp/fork04.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/fork04.c,v
retrieving revision 1.3
diff -p -u -r1.3 fork04.c
--- testsuite//winsup.api/ltp/fork04.c	24 Jan 2003 01:09:39 -0000	1.3
+++ testsuite//winsup.api/ltp/fork04.c	19 Feb 2003 22:25:42 -0000
@@ -129,7 +129,7 @@ extern int Tst_count;		/* Test Case coun

 /* list of environment variables to test */
 const char *environ_list[] = {"TERM","NoTSetzWq","TESTPROG"};
-#define NUMBER_OF_ENVIRON sizeof(environ_list)/sizeof(char *)
+#define NUMBER_OF_ENVIRON (int)(sizeof(environ_list)/sizeof(char *))
 int TST_TOTAL=NUMBER_OF_ENVIRON;		/* Total number of test cases. */

 /***************************************************************
Index: testsuite//winsup.api/ltp/getpgid01.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/getpgid01.c,v
retrieving revision 1.2
diff -p -u -r1.2 getpgid01.c
--- testsuite//winsup.api/ltp/getpgid01.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/getpgid01.c	19 Feb 2003 22:25:42 -0000
@@ -44,7 +44,6 @@

 #include <sys/types.h>
 #include <errno.h>
-#include <varargs.h>
 #include <sys/wait.h>
 #include <test.h>
 #include <usctest.h>
Index: testsuite//winsup.api/ltp/getpgid02.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/getpgid02.c,v
retrieving revision 1.2
diff -p -u -r1.2 getpgid02.c
--- testsuite//winsup.api/ltp/getpgid02.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/getpgid02.c	19 Feb 2003 22:25:42 -0000
@@ -46,7 +46,6 @@

 #include <sys/types.h>
 #include <errno.h>
-#include <varargs.h>
 #include <sys/wait.h>
 #include <test.h>
 #include <usctest.h>
Index: testsuite//winsup.api/ltp/lseek03.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/lseek03.c,v
retrieving revision 1.2
diff -p -u -r1.2 lseek03.c
--- testsuite//winsup.api/ltp/lseek03.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/lseek03.c	19 Feb 2003 22:25:43 -0000
@@ -137,7 +137,7 @@ main(int ac, char **av)
     int lc;		/* loop counter */
     const char *msg;		/* message returned from parse_opts */

-    int ind;
+    unsigned ind;
     int whence;

     TST_TOTAL=sizeof(Whences)/sizeof(int);
Index: testsuite//winsup.api/ltp/lseek06.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/lseek06.c,v
retrieving revision 1.2
diff -p -u -r1.2 lseek06.c
--- testsuite//winsup.api/ltp/lseek06.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/lseek06.c	19 Feb 2003 22:25:43 -0000
@@ -201,7 +201,7 @@ setup()
 	}

 	/* Write data into temporary file */
-	if(write(fildes, write_buf, strlen(write_buf)) != strlen(write_buf)) {
+	if(write(fildes, write_buf, strlen(write_buf)) != (int)strlen(write_buf)) {
 		tst_brkm(TBROK, cleanup, "write(2) on %s Failed, errno=%d : %s",
 			 TEMP_FILE, errno, strerror(errno));
 	}
Index: testsuite//winsup.api/ltp/lseek07.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/lseek07.c,v
retrieving revision 1.2
diff -p -u -r1.2 lseek07.c
--- testsuite//winsup.api/ltp/lseek07.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/lseek07.c	19 Feb 2003 22:25:43 -0000
@@ -149,7 +149,7 @@ main(int ac, char **av)
 			 * the current offset position.
 			 */
 			if (write(fildes, write_buf2, strlen(write_buf2)) !=
-				       strlen(write_buf2)) {
+				       (int)strlen(write_buf2)) {
 				tst_brkm(TFAIL, cleanup, "write() failed to "
 					 "write additional data, error = %d",
 					 errno);
@@ -244,7 +244,7 @@ setup()

 	/* Write data into temporary file */
 	if(write(fildes, write_buf1, strlen(write_buf1)) !=
-							strlen(write_buf1)) {
+						     (int)strlen(write_buf1)) {
 		tst_brkm(TBROK, cleanup, "write(2) on %s Failed, errno=%d : %s",
 			 TEMP_FILE, errno, strerror(errno));
 	}
Index: testsuite//winsup.api/ltp/lseek08.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/lseek08.c,v
retrieving revision 1.2
diff -p -u -r1.2 lseek08.c
--- testsuite//winsup.api/ltp/lseek08.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/lseek08.c	19 Feb 2003 22:25:43 -0000
@@ -84,7 +84,7 @@ const char *TCID="lseek03";		/* Test pro
 int TST_TOTAL=1;		/* Total number of test cases. */
 extern int Tst_count;		/* Test Case counter for tst_* routines */
 int fildes;			/* file handle for temp file */
-size_t file_size;		/* size of the temporary file */
+ssize_t file_size;		/* size of the temporary file */

 void setup();			/* Main setup function of test */
 void cleanup(void) __attribute__((noreturn));			/* cleanup function for the test */
Index: testsuite//winsup.api/ltp/mmap001.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/mmap001.c,v
retrieving revision 1.2
diff -p -u -r1.2 mmap001.c
--- testsuite//winsup.api/ltp/mmap001.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/mmap001.c	19 Feb 2003 22:25:43 -0000
@@ -90,7 +90,7 @@ int main(int argc, char * argv[])
   const char *msg;
   int i,lc;
   int fd;
-  unsigned int pages,memsize;
+  int pages,memsize;

   if ( (msg=parse_opts(argc, argv, options, help)) != (char *) NULL )
    tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
Index: testsuite//winsup.api/ltp/mmap02.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/mmap02.c,v
retrieving revision 1.2
diff -p -u -r1.2 mmap02.c
--- testsuite//winsup.api/ltp/mmap02.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/mmap02.c	19 Feb 2003 22:25:43 -0000
@@ -225,7 +225,7 @@ setup()
 	}

 	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, sizeof(tst_buff)) < sizeof(tst_buff)) {
+	if (write(fildes, tst_buff, sizeof(tst_buff)) < (int)sizeof(tst_buff)) {
 		tst_brkm(TFAIL, NULL, "write() on %s Failed, errno=%d : %s",
 			 TEMPFILE, errno, strerror(errno));
 		free(tst_buff);
Index: testsuite//winsup.api/ltp/mmap03.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/mmap03.c,v
retrieving revision 1.2
diff -p -u -r1.2 mmap03.c
--- testsuite//winsup.api/ltp/mmap03.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/mmap03.c	19 Feb 2003 22:25:43 -0000
@@ -225,7 +225,7 @@ setup()
 	}

 	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, strlen(tst_buff)) < strlen(tst_buff)) {
+	if (write(fildes, tst_buff, strlen(tst_buff)) < (int)strlen(tst_buff)) {
 		tst_brkm(TFAIL, NULL, "write() on %s Failed, errno=%d : %s",
 			 TEMPFILE, errno, strerror(errno));
 		free(tst_buff);
Index: testsuite//winsup.api/ltp/mmap04.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/mmap04.c,v
retrieving revision 1.2
diff -p -u -r1.2 mmap04.c
--- testsuite//winsup.api/ltp/mmap04.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/mmap04.c	19 Feb 2003 22:25:43 -0000
@@ -225,7 +225,7 @@ setup()
 	}

 	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, strlen(tst_buff)) < strlen(tst_buff)) {
+	if (write(fildes, tst_buff, strlen(tst_buff)) < (int)strlen(tst_buff)) {
 		tst_brkm(TFAIL, NULL, "write() on %s Failed, errno=%d : %s",
 			 TEMPFILE, errno, strerror(errno));
 		free(tst_buff);
Index: testsuite//winsup.api/ltp/mmap05.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/mmap05.c,v
retrieving revision 1.3
diff -p -u -r1.3 mmap05.c
--- testsuite//winsup.api/ltp/mmap05.c	24 Jan 2003 01:51:39 -0000	1.3
+++ testsuite//winsup.api/ltp/mmap05.c	19 Feb 2003 22:25:44 -0000
@@ -228,7 +228,8 @@ setup()
 	}

 	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, strlen(tst_buff)) != strlen(tst_buff)) {
+	if (write(fildes, tst_buff, strlen(tst_buff))
+	    != (int)strlen(tst_buff)) {
 		tst_brkm(TFAIL, NULL, "write() on %s Failed, errno=%d : %s",
 			 TEMPFILE, errno, strerror(errno));
 		free(tst_buff);
Index: testsuite//winsup.api/ltp/mmap06.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/mmap06.c,v
retrieving revision 1.2
diff -p -u -r1.2 mmap06.c
--- testsuite//winsup.api/ltp/mmap06.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/mmap06.c	19 Feb 2003 22:25:44 -0000
@@ -197,7 +197,7 @@ setup()
 	}

 	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, strlen(tst_buff)) < strlen(tst_buff)) {
+	if (write(fildes, tst_buff, strlen(tst_buff)) < (int)strlen(tst_buff)) {
 		tst_brkm(TFAIL, NULL,
 			 "write() on %s Failed, errno=%d : %s",
 			 TEMPFILE, errno, strerror(errno));
Index: testsuite//winsup.api/ltp/mmap07.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/mmap07.c,v
retrieving revision 1.2
diff -p -u -r1.2 mmap07.c
--- testsuite//winsup.api/ltp/mmap07.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/mmap07.c	19 Feb 2003 22:25:44 -0000
@@ -198,7 +198,7 @@ setup()
 	}

 	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, strlen(tst_buff)) < strlen(tst_buff)) {
+	if (write(fildes, tst_buff, strlen(tst_buff)) < (int)strlen(tst_buff)) {
 		tst_brkm(TFAIL, NULL, "write() on %s Failed, errno=%d : %s",
 			 TEMPFILE, errno, strerror(errno));
 		free(tst_buff);
Index: testsuite//winsup.api/ltp/mmap08.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/mmap08.c,v
retrieving revision 1.2
diff -p -u -r1.2 mmap08.c
--- testsuite//winsup.api/ltp/mmap08.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/mmap08.c	19 Feb 2003 22:25:44 -0000
@@ -191,7 +191,8 @@ setup()
 	}

 	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, strlen(tst_buff)) != strlen(tst_buff)) {
+	if (write(fildes, tst_buff, strlen(tst_buff))
+	    != (int)strlen(tst_buff)) {
 		tst_brkm(TFAIL, NULL, "write() on %s Failed, errno=%d : %s",
 			 TEMPFILE, errno, strerror(errno));
 		free(tst_buff);
Index: testsuite//winsup.api/ltp/pipe11.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/pipe11.c,v
retrieving revision 1.2
diff -p -u -r1.2 pipe11.c
--- testsuite//winsup.api/ltp/pipe11.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/pipe11.c	19 Feb 2003 22:25:44 -0000
@@ -203,7 +203,7 @@ setup()
 	j = 0;
 	for (i = 0; i < szcharbuf; ) {
 		wrbuf[i++] = rawchars[j++];
-		if (j >= sizeof(rawchars)) {
+		if (j >= (int)sizeof(rawchars)) {
 			j = 0;
 		}
 	}
Index: testsuite//winsup.api/ltp/poll01.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/poll01.c,v
retrieving revision 1.2
diff -p -u -r1.2 poll01.c
--- testsuite//winsup.api/ltp/poll01.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/poll01.c	19 Feb 2003 22:25:44 -0000
@@ -122,7 +122,7 @@ main(int ac, char **av)

 		/* write the message to the pipe */
 		if (write(fildes[1], write_buf, strlen(write_buf))
-						< strlen(write_buf)) {
+						< (int)strlen(write_buf)) {
 			tst_brkm(TBROK, cleanup, "write() failed on write "
 				 "to pipe, error:%d", errno);
 		}
@@ -166,7 +166,7 @@ main(int ac, char **av)

 			/* Read data from read end of pipe */
 			if (read(fildes[0], read_buf, sizeof(read_buf)) !=
-				     strlen(write_buf)) {
+				     (int)strlen(write_buf)) {
 				tst_brkm(TFAIL, NULL, "read() failed - "
 					 "error:%d", errno);
 				exit(1);
Index: testsuite//winsup.api/ltp/sync02.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/sync02.c,v
retrieving revision 1.2
diff -p -u -r1.2 sync02.c
--- testsuite//winsup.api/ltp/sync02.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/sync02.c	19 Feb 2003 22:25:44 -0000
@@ -199,7 +199,7 @@ setup()

 	/* Write the buffer data into file */
 	if (write(fildes, write_buffer, strlen(write_buffer)) != \
-				strlen(write_buffer)) {
+				(int)strlen(write_buffer)) {
 		tst_brkm(TBROK, cleanup,
 			 "write() failed to write buffer data to %s",
 			 TEMP_FILE);
Index: testsuite//winsup.api/ltp/times03.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/times03.c,v
retrieving revision 1.2
diff -p -u -r1.2 times03.c
--- testsuite//winsup.api/ltp/times03.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/times03.c	19 Feb 2003 22:25:45 -0000
@@ -88,7 +88,7 @@ main(int argc, char **argv)
 	 */
 	start_time = time(NULL);
 	for (;;) {
-		if (times(&buf1) == -1) {
+		if (times(&buf1) == (clock_t)-1) {
 			TEST_ERROR_LOG(errno);
 			tst_resm(TFAIL, "Call to times(2) "
 				 "failed, errno = %d", errno);
@@ -98,7 +98,7 @@ main(int argc, char **argv)
 			break;
 		}
 	}
-	if (times(&buf1) == -1) {
+	if (times(&buf1) == (clock_t)-1) {
 		TEST_ERROR_LOG(errno);
 		tst_resm(TFAIL, "Call to times(2) failed, "
 			 "errno = %d", errno);
@@ -145,7 +145,7 @@ main(int argc, char **argv)
 				 */
 				start_time = time(NULL);
 				for (;;) {
-					if (times(&buf2) == -1) {
+					if (times(&buf2) == (clock_t)-1) {
 						tst_resm(TFAIL,
 							"Call to times "
 							"failed, "
@@ -166,7 +166,7 @@ main(int argc, char **argv)
 				tst_resm(TFAIL, "Call to times(2) "
 						"failed in child");
 			}
-			if (times(&buf2) == -1) {
+			if (times(&buf2) == (clock_t)-1) {
 				TEST_ERROR_LOG(TEST_ERRNO);
 				tst_resm(TFAIL, "Call to times failed "
 						"errno = %d", errno);
Index: testsuite//winsup.api/ltp/umask03.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/umask03.c,v
retrieving revision 1.2
diff -p -u -r1.2 umask03.c
--- testsuite//winsup.api/ltp/umask03.c	24 Jan 2003 01:09:39 -0000	1.2
+++ testsuite//winsup.api/ltp/umask03.c	19 Feb 2003 22:25:45 -0000
@@ -67,7 +67,7 @@ main(int argc, char **argv)
 	const char *msg;

 	struct stat statbuf;
-	int mskval = 0000;
+	unsigned mskval = 0000;
 	int fildes, i;
 	unsigned low9mode;
