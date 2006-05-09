Return-Path: <cygwin-patches-return-5848-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12366 invoked by alias); 9 May 2006 22:14:09 -0000
Received: (qmail 12355 invoked by uid 22791); 9 May 2006 22:14:07 -0000
X-Spam-Check-By: sourceware.org
Received: from vms042pub.verizon.net (HELO vms042pub.verizon.net) (206.46.252.42)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 09 May 2006 22:14:06 +0000
Received: from PHUMBLETXP ([12.6.244.2])  by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep  9 2005)) with ESMTPA id <0IZ000864R3CLX62@vms042.mailsrvcs.net> for  cygwin-patches@cygwin.com; Tue, 09 May 2006 17:14:00 -0500 (CDT)
Date: Tue, 09 May 2006 22:14:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Addition to the testsuite & cygwin patch
To: <cygwin-patches@cygwin.com>
Message-id: <00ab01c673b5$969108c0$280010ac@wirelessworld.airvananet.com>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: multipart/mixed;  boundary="----=_NextPart_000_00A8_01C67394.0AFFAD00"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00036.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_00A8_01C67394.0AFFAD00
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Content-length: 1253

The main purpose of this patch is to contribute the attached file to
testsuite/winsup.api. It checks that Cygwin can support a user
supplied version of malloc.
However the patch below is required to make it work and to
support versions of malloc that don't call sbrk.

Pierre

2006-05-09  Pierre Humblet  Pierre.Humblet@ieee.org

    * winsup.api/malloc.c: New file

2006-05-09  Pierre Humblet  Pierre.Humblet@ieee.org

 * heap.cc (heap_init): Only commit if allocsize is not zero.

Index: heap.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/heap.cc,v
retrieving revision 1.52
diff -u -p -b -r1.52 heap.cc
--- heap.cc     13 Mar 2006 21:10:14 -0000      1.52
+++ heap.cc     9 May 2006 21:47:40 -0000
@@ -83,7 +83,7 @@ heap_init ()
                   reserve_size, allocsize, page_const);
       if (p != cygheap->user_heap.base)
        api_fatal ("heap allocated at wrong address %p (mapped) != %p 
(expected)", p, cygheap->user_heap.base);
-      if (!VirtualAlloc (cygheap->user_heap.base, allocsize, MEM_COMMIT, 
PAGE_READWRITE))
+      if (allocsize && !VirtualAlloc (cygheap->user_heap.base, allocsize, 
MEM_COMMIT, PAGE_READWRITE))
        api_fatal ("MEM_COMMIT failed, %E");
     }

------=_NextPart_000_00A8_01C67394.0AFFAD00
Content-Type: application/octet-stream;
	name="malloc.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="malloc.c"
Content-length: 5805

/* Test of external malloc, calloc, realloc and free capability */=0A=
=0A=
#if 1=0A=
#include "test.h"=0A=
#include "usctest.h"=0A=
#else=0A=
enum {TPASS, TFAIL, TBROK, TINFO};=0A=
#define tst_resm(xxx, yyy...) printf(yyy), printf(" RES %d\n", xxx)=0A=
#define tst_brkm(xxx, yyy, zzz...) printf(zzz), printf(" RES %d\n", xxx)=0A=
#define tst_exit()=0A=
int Tst_count;=0A=
#endif=0A=
=0A=
#include <stdlib.h>=0A=
#include <stdio.h>=0A=
#include <strings.h>=0A=
#include <errno.h>=0A=
#include <unistd.h>=0A=
#include <sys/wait.h>=0A=
=0A=
const char *TCID =3D "malloc";    /* Test program identifier. */=0A=
int TST_TOTAL =3D 2;              /* Total number of test cases. */=0A=
extern int Tst_count;           /* Test Case counter for tst_* routines */=
=0A=
=0A=
/* Main test.=0A=
   Verbose mode if argc > 0=0A=
   Note that malloc and friends are also called by Cygwin before main,=0A=
   and that malloc can call getenv. */=0A=
=0A=
int malloc_error =3D 0, realloc_error =3D 0, free_error =3D 0;=20=0A=
int calloc_count =3D 0, malloc_count =3D 0, realloc_count =3D 0, free_count=
 =3D 0;=0A=
=0A=
void=0A=
cleanup (void)=0A=
{=0A=
  tst_exit();=20=0A=
}=0A=
=0A=
int=0A=
syncwithchild (pid_t pid, int expected_exit_status)=0A=
{=0A=
  int status;=0A=
=0A=
  if (waitpid (pid, &status, 0) !=3D pid)=0A=
    {=0A=
      tst_brkm (TBROK, cleanup, "Wait for child: %s", strerror (errno));=0A=
      return 1;=0A=
    }=0A=
  if (!WIFEXITED (status))=0A=
    {=0A=
      tst_brkm (TBROK, cleanup, "Child had abnormal exit");=0A=
      return 1;=0A=
    }=0A=
  if (WEXITSTATUS (status) !=3D expected_exit_status)=0A=
    {=0A=
      tst_brkm (TFAIL, cleanup, "Child had exit status %d !=3D %d",=0A=
		WEXITSTATUS (status), expected_exit_status);=0A=
      return 1;=0A=
    }=0A=
  return 0;=0A=
}=0A=
=0A=
#if 0=0A=
void * mallocX (size_t size);=0A=
void * callocX (size_t nmemb, size_t size);=0A=
void * reallocX (void * ptr, size_t size);=0A=
void freeX(void *);=0A=
=0A=
#define malloc mallocX=0A=
#define calloc callocX=0A=
#define realloc reallocX=0A=
#define free freeX=0A=
#endif=0A=
=0A=
int main (int argc, char * argv[])=0A=
{=20=0A=
  void * ptr;=0A=
  int error =3D 0;=0A=
  pid_t pid;=0A=
=0A=
  Tst_count =3D 0;=0A=
=0A=
  tst_resm(TINFO, "Testing if external malloc works. ppid %d", getppid());=
=0A=
=0A=
  ptr =3D malloc (16);=0A=
  ptr =3D calloc (1, 16);=0A=
  ptr =3D realloc (ptr, 24);=0A=
  free (ptr);=0A=
=0A=
  error =3D (malloc_count =3D=3D 0 || calloc_count =3D=3D 0 || realloc_coun=
t =3D=3D 0 || free_count =3D=3D 0);=0A=
=0A=
  if (error || argc > 1)=0A=
    {=0A=
      printf ("malloc_count %d, calloc_count %d, realloc_count %d, free_cou=
nt %d\n",=20=0A=
	      malloc_count, calloc_count, realloc_count, free_count);=0A=
      printf ("malloc_error %d, realloc_error %d, free_error %d\n",=0A=
	      malloc_error, realloc_error, free_error);=0A=
    }=0A=
  tst_resm (!error ? TPASS : TFAIL, "Running in pid %d", getpid());=0A=
=0A=
  /* If run from Windows, run also from Cygwin */=0A=
  if (getppid() =3D=3D 1)=0A=
    {=0A=
      tst_resm(TINFO, "Ready to test if malloc works from Cygwin");=0A=
=0A=
      if ((pid =3D fork()) =3D=3D 0)=0A=
	{=0A=
	  tst_resm(TINFO, "Ready to exec with pid %d\n", getpid());=0A=
	  error =3D execl(argv[0], argv[0], argc > 1? argv[1]:NULL, NULL);=0A=
	  exit(error);=0A=
	}=0A=
      else if (pid < 0)=0A=
	tst_brkm (TBROK, cleanup, "Fork failed: %s", strerror (errno));=0A=
      else=0A=
	{=0A=
	  error =3D syncwithchild (pid, 0);=0A=
	  tst_resm (!error ? TPASS : TFAIL, "Running in pid %d", pid);=0A=
	}=0A=
    }=0A=
=0A=
  tst_exit ();=0A=
}=0A=
=0A=
/****************************************=0A=
Actual malloc & friends implementation=20=0A=
****************************************/=0A=
=0A=
typedef unsigned long long ull;=0A=
=20=0A=
#define SIZE (1024*1024ULL) /* long long */=20=0A=
ull buffer[SIZE];=20=0A=
ull * current =3D buffer;=0A=
=0A=
static int is_valid (void * ptr)=0A=
{=0A=
  unsigned int iptr =3D (unsigned int) ptr;=0A=
  ull * ullptr =3D (ull *) ptr;=0A=
=0A=
  iptr =3D (iptr / sizeof(ull)) * sizeof(ull);=0A=
  if (iptr !=3D (int) ptr)=0A=
    return 0;=0A=
  if (--ullptr < buffer || ullptr[0] > SIZE || ullptr  + ullptr[0]  > curre=
nt)=0A=
    return 0;=0A=
  return 1;=0A=
}=0A=
=0A=
void * malloc (size_t size)=0A=
{=0A=
  ull llsize =3D (size + 2 * sizeof (ull) - 1) / sizeof (ull);=0A=
  static char * envptr;=0A=
  void * ret;=0A=
=20=20=0A=
  /* Make sure getenv works */=0A=
  if (!envptr)=0A=
    envptr =3D getenv ("PATH");=0A=
=0A=
  malloc_count++;=0A=
  if (current + llsize >=3D buffer + SIZE)=20=0A=
    {=0A=
      malloc_error++;=0A=
      errno =3D ENOMEM;=0A=
      return NULL;=0A=
    }=0A=
  *current =3D llsize;=0A=
  ret =3D (void *) (current + 1);=0A=
  current +=3D llsize;=0A=
=0A=
  return ret;=0A=
}=0A=
=0A=
void * calloc (size_t nmemb, size_t size)=20=0A=
{=0A=
  calloc_count++;=0A=
  void * ptr =3D malloc (nmemb * size);=0A=
  malloc_count--;=0A=
  if (ptr)=0A=
    memset(ptr, 0, nmemb * size);=0A=
  return ptr;=0A=
}=0A=
=0A=
void * realloc (void * ptr, size_t size)=0A=
{=0A=
  const ull ullsize =3D (size + 2 * sizeof (ull) - 1) / sizeof (ull);=0A=
  ull * const ullptr =3D (ull *) ptr;=0A=
  void * newptr;=0A=
=20=20=0A=
  realloc_count++;=0A=
=20=20=0A=
  if (ptr)=0A=
    {=0A=
      if (!is_valid (ptr))=0A=
	{=0A=
	  realloc_error++;=0A=
	  errno =3D ENOMEM;=0A=
	  return NULL;=0A=
	}=20=20=0A=
      if (ullptr[-1] >=3D ullsize)=0A=
	return ptr;=0A=
    }=0A=
=0A=
  newptr =3D malloc (size);=0A=
  malloc_count--;=0A=
=20=20=0A=
  if (ptr && newptr)=0A=
    memcpy (newptr, ptr, size);=0A=
=20=20=0A=
  return newptr;=0A=
}=0A=
=0A=
void free (void * x)=0A=
{=0A=
  free_count++;=0A=
  if (x && ! is_valid (x))=0A=
      free_error++;=0A=
}=0A=
=0A=

------=_NextPart_000_00A8_01C67394.0AFFAD00--
