Return-Path: <cygwin-patches-return-3268-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17041 invoked by alias); 2 Dec 2002 21:56:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17032 invoked from network); 2 Dec 2002 21:56:47 -0000
Message-ID: <3DEBD6C7.2000807@ece.gatech.edu>
Date: Mon, 02 Dec 2002 13:56:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
References: <3DEB8ABD.80309@ece.gatech.edu>
Content-Type: multipart/mixed;
 boundary="------------000904020309010304010509"
X-SW-Source: 2002-q4/txt/msg00219.txt.bz2

This is a multi-part message in MIME format.
--------------000904020309010304010509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1144

ed> Question: How can one distinguish console application from GUI one?
ed> What is the best wording for the error message?

Here's an example.  If GetConsoleWindow is available (W2K or XP) it uses 
that; otherwise, it uses a different kludge.

The idea is you'd call has_console() or 
GetConsoleWindow()/GetConsoleWindow2() only once, and your app would 
cache the result.  However, since Egor's use would be to display/print 
an error message and die, I don't suppose that matters much...

works as expected in all these cases:

gcc -o has_console.exe has_console.c
gcc -mwindows -o has_console.exe has_console.c
gcc -mno-cygwin -o has_console.exe has_console.c
gcc -mno-cygwin -mwindows -o has_console.exe has_console.c

Note that all that matters is how the app was *compiled*.  If you happen 
to run an app that was compiled with -mwindows by typing its name in a 
bash shell, it still "thinks" its a GUI app, and uses MessageBox to 
display the "error" message.

If you want it to detect how it was called (e.g. exec'ed by an 
interactive bash shell, or clicked in Windows Explorer) then you've got 
to use a different solution.

--Chuck

--------------000904020309010304010509
Content-Type: text/plain;
 name="has_console.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="has_console.c"
Content-length: 2161

#include <stdio.h>
#include <math.h>
#define _WIN32_WINNT 0x0500
#include <windows.h>

int has_console(void);
HWND GetConsoleWindow2(void);

int main (int argc, char * argv[]) {
  int console = -1;
  
  console = has_console();

  if (console) {
    printf("This is a console application");
  } else {
    MessageBox(NULL, "This is a GUI application", 
	            "MessageBox", MB_ICONSTOP);
  }
  return ( 0 );
}

int has_console(void) {
  int retval = -1;
  int get_console_window_avail;
  
/* poor man's wincap */
  OSVERSIONINFO version;
  memset (&version, 0, sizeof version);
  version.dwOSVersionInfoSize = sizeof version;
  GetVersionEx (&version);
  get_console_window_avail = 0;
  if (version.dwPlatformId == VER_PLATFORM_WIN32_NT) {
    if (version.dwMajorVersion == 5) { // w2k or wxp
      get_console_window_avail = 1;
    }
  }
  get_console_window_avail = 0;
  
  if (get_console_window_avail) {
    if (GetConsoleWindow() == NULL) {
      retval = 0;
    } else {
      retval = 1;
    }
  } else {
    if (GetConsoleWindow2() == NULL) {
      retval = 0;
    } else {
      retval = 1;
    }
  }
  return ( retval );
}

HWND GetConsoleWindow2(void) {
  char *letdig = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  char consoleTitle[1024];
  char testTitle[1024];
  char randTitle[25];
  HWND retval;
  double a, b;
  int index;
  int n;
  
  if (! GetConsoleTitle(consoleTitle, 1023)) 
    return NULL;
  
  for (n=0; n < 20; n++) {
	 a = (((double) rand()) / (((double) RAND_MAX)+1)); // 0 <= a < 1
	 index = (int) floor(36.0 * a); // 0 <= index <= 35 
    randTitle[n] = letdig[index];
  }
  randTitle[20] = '\0';
  
  // Temporarily change the title of this console to something unique
  if (! SetConsoleTitle( randTitle ))
    return NULL;

  while( 1 ) {
    // wait until the console title has really changed
    if (! GetConsoleTitle(testTitle, 1023)) {
	   SetConsoleTitle(consoleTitle); // try to clean up
      return NULL;
    }
	 if (strncmp(randTitle, testTitle, 1023) == 0)
	   break;
    Sleep(50); // use Win32 Sleep() to wait 50ms
  }

  retval = FindWindow (0, randTitle);
  SetConsoleTitle( consoleTitle );
  return retval;
}

--------------000904020309010304010509--
