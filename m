Return-Path: <cygwin-patches-return-5805-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24899 invoked by alias); 9 Mar 2006 15:04:45 -0000
Received: (qmail 24887 invoked by uid 22791); 9 Mar 2006 15:04:43 -0000
X-Spam-Check-By: sourceware.org
Received: from web53006.mail.yahoo.com (HELO web53006.mail.yahoo.com) (206.190.49.36)     by sourceware.org (qpsmtpd/0.31) with SMTP; Thu, 09 Mar 2006 15:04:40 +0000
Received: (qmail 15028 invoked by uid 60001); 9 Mar 2006 15:04:23 -0000
Message-ID: <20060309150423.15026.qmail@web53006.mail.yahoo.com>
Received: from [69.141.137.97] by web53006.mail.yahoo.com via HTTP; Thu, 09 Mar 2006 07:04:23 PST
Date: Thu, 09 Mar 2006 15:04:00 -0000
From: Gary Zablackis <gzabl@yahoo.com>
Subject: Re: Patch for silent crash with Cygwin1.dll v 1.5.19-4
To: Brian Dessent <brian@dessent.net>
Cc: Cygwin Patches <cygwin-patches@cygwin.com>
In-Reply-To: <440CAE88.13DA9205@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00114.txt.bz2

--- Brian Dessent <brian@dessent.net> wrote:

> If you are trying to track down why you get a
> SIGSEGV in
> pthread_key_create while running your app in gdb you
> are wasting your
> time.  This is not a fault, it is expected and
> normal.  Search the
> archives.
> 
> Brian
> 

In this case, the fault is NOT normal: instead of
returning to pthread_key_create(),
verifyably_object_isvalid() crashes.

Normally, verifyably_object_isvalid() catches the
fault and returns INVALID_OBJECT to
pthread_key_create().

The crash I have occurs when loading a dll via
dlopen() and the cygwin dll intialization code calls
dll:init() which calls
run_ctors()  which calls (eventually) 
pthread::once() which calls 
init_routine() and init_routine() happens to be
fc_key_init().
fc_key_init() sets up the pthread_key_t object, calls 
_sigfe_pthread_key_create() which jumps into 
pthread_key_create() which calls 
verifyably_object_isvalid() and we crash.
------------------------------------------------
I think that what is happening is that if one
dlopen()s a dll that is created with -lstdc++, the dll
initialization code called by the cygwin
initialization code has a bug in it. If ANY dll which
is created with -lstdc++ is LINKED into the
executable, everything gets initialized properly and
pthread_key_create() catches the SIGSEGV and continues
normally.

Here is a simplified test to show what is going on:

------Simple script to put everything together:
#!/bin/sh
#NOTE: add -DHARDLINKTEST to ct.c compile to get
#      a non-crashing exe
#1st dll to be dlopen()ed only:
gcc -DDEBUG -gstabs+ -g3 -fno-strict-aliasing -Wall -c
CrashTest.cc -o CrashTest.o
g++ -shared  ./CrashTest.o -o CrashTest.dll -lstdc++

#2nd dll to linked directly by exe
gcc -DDEBUG -gstabs+ -g3 -fno-strict-aliasing -Wall -c
Crash2.cc -o Crash2.o
g++ -shared -Wl,--out-implib=libCrash2.dll.a
-Wl,--export-all-symbols -Wl,--enable-auto-import
-Wl,--whole-archive Crash2.o -Wl,--no-whole-archive -o
Crash2.dll -lstdc++

#3rd dll without -lstdc++
gcc -DDEBUG -gstabs+ -g3 -fno-strict-aliasing -Wall -c
OK.cc -o OK.o
g++ -shared  ./OK.o -o OK.dll -lstdc++

#exe test program
gcc -DDEBUG -gstabs+ -g3 ct.c -o ct.exe -L./ -lCrash2


------Code for exe (ct.c):
#include <windows.h>
#include <winbase.h>
#include <stdio.h>
extern void test();   /* test function in dlls */

void TestLinked(char* pszdll);
void TestLoad(char* pszdll);

int main(int argc, char** argv)
{
    int     ret;
/* NOTE: -DHARDLINKTEST in makefile if you want this 
         to run
 */
#ifdef HARDLINKTEST
    TestLinked("./Crash2.dll");
#endif
    TestLoad("./OK.dll");
    TestLoad("./CrashTest.dll");

    printf("THAT'S ALL FOLKS\n");
}


#ifdef HARDLINKTEST
void TestLinked(char* pszdll)
{
    printf("Testing build time linked %s\n", pszdll);
    _Z4testv(); /* call test() in dll - real code
would
                   have __declspec(dllexport), etc and
                   extern "C" syntactic sugar
                 */
}
#endif

typedef UINT (CALLBACK* LPFNDLLFUNC1)(DWORD,UINT);

void TestLoad(char* pszdll)
{
    printf("dlopening %s\n", pszdll);

    HANDLE  hDLL = (HANDLE)dlopen(pszdll);

    if(hDLL){
        printf("Getting proc address for test\n");

        LPFNDLLFUNC1    lpfnDllFunc1 =
(LPFNDLLFUNC1)GetProcAddress(hDLL,
                                                      
             "_Z4testv");

        if (!lpfnDllFunc1){
            // handle the error
            printf("Failed to get the function: %d\n",
GetLastError());
            FreeLibrary(hDLL);
            return;
        }
        else {
            // call the function
            printf("Calling test\n");
            UINT uReturnVal = lpfnDllFunc1(0,0);
            printf("Back from test\n");
        }
    }
    else
        printf("Error %d dlopening %s\n",
GetLastError(), pszdll);
}

------Code for 1st dll (CrashTest.cc):
#include <iostream>
using namespace std;

void test()
{
        cout << "\tCRASHTEST: This is a test." << endl
<< "Did you crash?" << endl;
}

------Code for 2nd dll (Crash2.cc):
#include <iostream>
#include "Crash2.h"
using namespace std;
void test()
{
        cout << "\tCRASH2: This is a test." << endl <<
"Did you crash?" << endl;
}
------Code for 3rd dll (OK.c):
#include <windows.h>
#include <stdio.h>
void test()
{
        printf("\tOK: This is a test.\n");
}

----------------------------------------------
NOTE: I have also tested all of this with 
      __declspec(dllexport) and
      __declspec(dllimport) 
      and everything works exactly the same

Thanks,
Gary


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
