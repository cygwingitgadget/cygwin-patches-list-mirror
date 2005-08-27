Return-Path: <cygwin-patches-return-5630-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16389 invoked by alias); 27 Aug 2005 19:59:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16370 invoked by uid 22791); 27 Aug 2005 19:58:53 -0000
Received: from green.qinip.net (HELO green.qinip.net) (62.100.30.36)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sat, 27 Aug 2005 19:58:53 +0000
Received: from buzzy-box (hmm-dca-ap03-d05-195.dial.freesurf.nl [62.100.4.195])
	by green.qinip.net (Postfix) with SMTP
	id 6166644DC; Sat, 27 Aug 2005 21:58:47 +0200 (MET DST)
Message-ID: <n2m-g.deqn2t.3vv7q2b.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] readdir_r: fix sense of error-test.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.7.0 KorrNews/4.2
To: cygwin-patches@cygwin.com
Date: Sat, 27 Aug 2005 19:59:00 -0000
X-SW-Source: 2005-q3/txt/msg00085.txt.bz2

Hi,

I'm a bit confused... Should not readdir_r be implemented as this
patch indicates? (I'm still getting errors on the following testcase after
applying this. (try 0 err=7439xxx))


A ChangeLog-entry:

2005-08-27  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	*dir.cc (readdir_r): Invert sense on error-test.


Index: src/winsup/cygwin/dir.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.91
diff -u -p -r1.91 dir.cc
--- src/winsup/cygwin/dir.cc	23 Aug 2005 03:58:04 -0000	1.91
+++ src/winsup/cygwin/dir.cc	26 Aug 2005 22:09:59 -0000
@@ -160,7 +160,7 @@ readdir_r (DIR *dir, dirent *de, dirent 
   else
     {
       *ode = NULL;
-      if (res != ENMFILE)
+      if (res == ENMFILE)
 	res = 0;
     }
   return res;


The testcase:

(On my local system, this is kept as
testsuite/winsup.api/threadsafe/readdir_r01.c

If you want to see why this really does not require a copyright-
assignment, view the diff with testsuite/winsup.api/ltp/readdir01.c,
and remove all parts which are just comments.

)

===== start testcase =====
/*
 * Copyright (c) 2004 Bas van Gompel.  All Rights Reserved.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of version 2 of the GNU General Public License as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it would be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * Further, this software is distributed without any warranty that it is
 * free of the rightful claim of any third person regarding infringement
 * or the like.  Any license provided herein, whether implied or
 * otherwise, applies only to this software file.  Patent licenses, if
 * any, provided herein do not apply to combinations of this program with
 * other software, or any other product whatsoever.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write the Free Software Foundation, Inc., 59
 * Temple Place - Suite 330, Boston MA 02111-1307, USA.
 *
 */
/* $Id */
/**********************************************************
 * 
 *    TEST IDENTIFIER	: readdir_r01
 * 
 *    EXECUTED BY	: anyone
 * 
 *    TEST TITLE	: write multiple files and try to find them with readdir_r
 * 
 *    TEST CASE TOTAL	:
 * 
 *    WALL CLOCK TIME	:
 * 
 *    CPU TYPES		: ALL
 * 
 *    AUTHOR		: Modified from readdir01.c by Bas van Gompel
 * 
 *    CO-PILOT		:
 * 
 *    DATE STARTED	: 04/16/2004
 * 
 *    TEST CASES
 * 
 * 	1.) Create n files and check that readdir_r() finds each file
 *	
 *    INPUT SPECIFICATIONS
 * 	The standard options for system call tests are accepted.
 *	(See the parse_opts(3) man page).
 * 
 *    OUTPUT SPECIFICATIONS
 * 	
 *    DURATION
 * 	Terminates - with frequency and infinite modes.
 * 
 *    SIGNALS
 * 	Uses SIGUSR1 to pause before test if option set.
 * 	(See the parse_opts(3) man page).
 *
 *    RESOURCES
 * 	None
 * 
 *    ENVIRONMENTAL NEEDS
 *      No run-time environmental needs.
 * 
 *    SPECIAL PROCEDURAL REQUIREMENTS
 * 	None
 * 
 *    INTERCASE DEPENDENCIES
 * 	None
 * 
 *    DETAILED DESCRIPTION
 *	This is a Phase I test for the readdir_r(2) system call.  It is intended
 *	to provide a limited exposure of the system call, for now.  It
 *	should/will be extended when full functional tests are written for
 *	readdir_r(2).
 * 
 * 	Setup:
 * 	  Setup signal handling.
 *	  Pause for SIGUSR1 if option specified.
 * 
 * 	Test:
 *	 Loop if the proper options are given.
 * 	  Execute system call
 *	  Check return code, if system call failed (return=-1)
 *		Log the errno and Issue a FAIL message.
 *	  Otherwise, Issue a PASS message.
 * 
 * 	Cleanup:
 * 	  Print errno log and/or timing stats if options given
 * 
 * 
 *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <dirent.h>
#include <errno.h>
#include <string.h>
#include <signal.h>
 /* test.h and usctest.h are the two header files that are required by the
  * quickhit package.  They contain function and macro declarations which you
  * can use in your test programs
  */
#include "test.h"
#include "usctest.h"

 /* The setup and cleanup functions are basic parts of a test case.  These
  * steps are usually put in separate functions for clarity.  The help function
  * is only needed when you are adding new command line options.
  */
void setup(); 
void help();
void cleanup(void) __attribute__((noreturn));

const char *TCID="readdir_r01";		/* Test program identifier.    */
int TST_TOTAL=2;    		/* Total number of test cases. */
extern int Tst_count;		/* Test Case counter for tst_* routines */
extern int Tst_nobuf;

int exp_enos[]={0, 0};

#define BASENAME	"readdir_r-file"

char Basename[255];
char Fname[255];
int Nfiles=0;

/* To add command line options you need to declare a structure to pass to
 * parse_opts().  options is the structure used in this example.  The format is
 * the string that should be added to optstring in getopt(3), an integer that
 * will be used as a flag if the option is given, and a pointer to a string that
 * should receive the optarg parameter from getopt(3).  Here we add a -N
 * option.  Long options are not supported at this time. 
 */
char *Nfilearg;
int Nflag=0;

/* for test specific parse_opts options */
option_t options[] = {
        { "N:",  &Nflag, &Nfilearg },   /* -N #files */
        { NULL, NULL, NULL }
};

/***********************************************************************
 * Main
 ***********************************************************************/
int
main(int ac, char **av)
{
    int lc;		/* loop counter */
    const char *msg;	/* message returned from parse_opts */
    int cnt;
    int nfiles, fd;
    char fname[255];
    DIR *test_dir;
    struct dirent dentr, *dptr;
    int rv;

    Tst_nobuf=1;

    /***************************************************************
     * parse standard options
     ***************************************************************/
    /* start off by parsing the command line options.  We provide a function
     * that understands many common options to control looping.  If you are not
     * adding any new options, pass NULL in place of options and &help.
     */
    if ( (msg=parse_opts(ac, av, options, &help)) ) {
	tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
	tst_exit();
    }

    if ( Nflag ) {
	if (sscanf(Nfilearg, "%i", &Nfiles) != 1 ) {
	    tst_brkm(TBROK, NULL, "--N option arg is not a number");
	    tst_exit();
	}
    }

    /***************************************************************
     * perform global setup for test
     ***************************************************************/
    /* Next you should run a setup routine to make sure your environment is
     * sane.
     */
    setup();

    /* set the expected errnos... */
    TEST_EXP_ENOS(exp_enos);

    /***************************************************************
     * check looping state 
     ***************************************************************/
    /* TEST_LOOPING() is a macro that will make sure the test continues
     * looping according to the standard command line args. 
     */
    for (lc=0; TEST_LOOPING(lc); lc++) {

	/* reset Tst_count in case we are looping. */
	Tst_count=0;

	if ( Nfiles )
	    nfiles = Nfiles;
	else
	    /* min of 10 links and max of a 100 links */
	    nfiles = (lc%90)+10;

	/* create a bunch of files to look at */
	for(cnt=0; cnt < nfiles; cnt++) {
	
	    sprintf(fname, "%s%d", Basename, cnt);
	    if ((fd = open(fname, O_RDWR|O_CREAT, 0700)) == -1) {
		tst_brkm(TBROK, cleanup,
				"open(%s, O_RDWR|O_CREAT,0700) Failed, errno=%d : %s", fname, errno, strerror(errno));
	    } else if (write(fd, "hello\n", 6) < 0) {
		tst_brkm(TBROK, cleanup,
				"write(%s, \"hello\\n\", 6) Failed, errno=%d : %s", fname, errno, strerror(errno));
	    } else if (close(fd) < 0) {
		tst_res(TWARN, "close(%s) Failed, errno=%d : %s",
				fname, errno, strerror(errno));
	    }
	}

	if ((test_dir = opendir(".")) == NULL) {
	    tst_resm(TFAIL, "opendir(\".\") Failed, errno=%d : %s",
			    errno, strerror(errno));
	} else {
	    /* count the entries we find to see if any are missing */
	    cnt = 0;
            errno = 0;
	    while ( (rv = readdir_r(test_dir, &dentr, &dptr)), dptr) {
		if (strcmp(dptr->d_name, ".") && strcmp(dptr->d_name, ".."))
		    cnt++;
	    }

	    if (rv != 0) {
		tst_resm(TFAIL, "readdir_r(test_dir) Failed on try %d, err=%d : %s",
				cnt, rv, strerror(rv));
	    }
	    if (cnt == nfiles) {
		tst_resm(TPASS, "found all %d that were created", nfiles);
	    } else if (cnt > nfiles) {
		tst_resm(TFAIL, "found more files than were created");
		tst_resm(TINFO, "created: %d, found: %d", nfiles, cnt);
	    } else {
		tst_resm(TFAIL, "found less files than were created");
		tst_resm(TINFO, "created: %d, found: %d", nfiles, cnt);
	    }
	}

	/* Here we clean up after the test case so we can do another iteration.
	 */
	for(cnt=0; cnt < nfiles; cnt++) {
        
            sprintf(fname, "%s%d", Basename, cnt);

	    if (unlink(fname) == -1) {
		tst_res(TWARN, "unlink(%s) Failed, errno=%d : %s",
			Fname, errno, strerror(errno));
	    }
	}

    }	/* End for TEST_LOOPING */

    /***************************************************************
     * cleanup and exit
     ***************************************************************/
    cleanup();

    return 0;
}	/* End main */

/***************************************************************
 * help
 ***************************************************************/
/* The custom help() function is really simple.  Just write your help message to
 * standard out.  Your help function will be called after the standard options
 * have been printed
 */
void
help()
{
    printf("  -N #files : create #files files every iteration\n");
}

/***************************************************************
 * setup() - performs all ONE TIME setup for this test.
 ***************************************************************/
void 
setup()
{
    /* You will want to enable some signal handling so you can capture
     * unexpected signals like SIGSEGV. 
     */
    tst_sig(NOFORK, DEF_HANDLER, cleanup);

    /* Pause if that option was specified */
    /* One cavet that hasn't been fixed yet.  TEST_PAUSE contains the code to
     * fork the test with the -c option.  You want to make sure you do this
     * before you create your temporary directory.
     */
    TEST_PAUSE;

    /* If you are doing any file work, you should use a temporary directory.  We
     * provide tst_tmpdir() which will create a uniquely named temporary
     * directory and cd into it.  You can now create files in the current
     * directory without worrying.
     */
    tst_tmpdir();

    sprintf(Basename, "%s_%d.", BASENAME, getpid());
}

/***************************************************************
 * cleanup() - performs all ONE TIME cleanup for this test at
 *		completion or premature exit.
 ***************************************************************/
void 
cleanup()
{
    /*
     * print timing stats if that option was specified.
     * print errno log if that option was specified.
     */
    TEST_CLEANUP;

    /* If you use a temporary directory, you need to be sure you remove it. Use
     * tst_rmdir() to do it automatically.  
     */
    tst_rmdir();

    /* exit with return code appropriate for results */
    tst_exit();
}

===== end testcase =====


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
