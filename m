Return-Path: <cygwin-patches-return-5506-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16788 invoked by alias); 3 Jun 2005 22:58:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16764 invoked by uid 22791); 3 Jun 2005 22:58:12 -0000
Received: from nat.electric-cloud.com (HELO main.electric-cloud.com) (63.82.0.114)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 03 Jun 2005 22:58:12 +0000
Received: from fulgurite.electric-cloud.com (fulgurite.electric-cloud.com [192.168.1.58])
	(authenticated bits=0)
	by main.electric-cloud.com (8.12.9/8.12.9) with ESMTP id j53Mw9M2027773
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <cygwin-patches@cygwin.com>; Fri, 3 Jun 2005 15:58:09 -0700
Subject: [Patch] Loading cygwin1.dll from MinGW and MSVC
From: Max Kaehn <slothman@electric-cloud.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain
Message-Id: <1117839489.5031.23.camel@fulgurite>
Mime-Version: 1.0
Date: Fri, 03 Jun 2005 22:58:00 -0000
Content-Transfer-Encoding: 7bit
X-Spam-Not-Checked:  Messages over 100K or from internal Electric Cloud machines are not checked
X-SW-Source: 2005-q2/txt/msg00102.txt.bz2

This patch contains the changes to make it possible to dynamically load
cygwin1.dll from MinGW and MSVC applications.  The changes to dcrt0.cc are
minimal and only affect cygwin_dll_init().  I've also added a MinGW test
program to testsuite and a FAQ so people will be able to locate the
test program easily.

I wrote how-cygtls-works.txt because it took me a while to figure out how it
was storing the information, and I hope I can save someone else the effort in
the future.  (I had no idea Windows was still using segment registers!)
I hope I got the copyright message right for it.

Rose Naftaly has received my copyright assignment form, and I expect
Corinna will post "Copyright assignment received for Max Kaehn"
as soon as she gets back from vacation. :-)

---
ChangeLog for winsup/cygwin:

2005-05-27  Max Kaehn <slothman@electric-cloud.com>

	* dcrt0.cc (cygwin_dll_init):  Now initializes main_environ
	and cygtls.  Comment to explain the caveats of this method.
	* how-cygtls-works.txt:  New file.
---
ChangeLog for winsup/doc:

2005-05-27  Max Kaehn <slothman@electric-cloud.com>

	* how-programming.texinfo:  Add "How do I load cygwin1.dll
	dynamically from a Visual Studio or MinGW application?"
---
ChangeLog for winsup/testsuite:

2005-05-27  Max Kaehn <slothman@electric-cloud.com>

	* Makefile:  now tests cygload.
	* cygload:  New directory.
	* cygload/cygload.cpp:  New file.
	* cygload/cygload.h:  Ditto.
	* cygload/Makefile:  Ditto.
	* cygload/README:  Ditto.
	* cygload/cygload.exp:  Ditto.

---
Index: winsup/cygwin/dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.242
diff -u -p -r1.242 dcrt0.cc
--- winsup/cygwin/dcrt0.cc	1 Jun 2005 03:46:55 -0000	1.242
+++ winsup/cygwin/dcrt0.cc	1 Jun 2005 19:39:34 -0000
@@ -955,7 +955,15 @@ dll_crt0 (per_process *uptr)
   _dll_crt0 ();
 }
 
-/* This must be called by anyone who uses LoadLibrary to load cygwin1.dll */
+/* This must be called by anyone who uses LoadLibrary to load cygwin1.dll.
+ * You must have CYGTLS_PADSIZE bytes reserved at the bottom of the stack
+ * calling this function, and that storage must not be overwritten until you
+ * unload cygwin1.dll, as it is used for _my_tls.  It is best to load
+ * cygwin1.dll before spawning any additional threads in your process.
+ *
+ * See winsup/testsuite/cygload for an example of how to use cygwin1.dll
+ * from MSVC and non-cygwin MinGW applications.
+ */
 extern "C" void
 cygwin_dll_init ()
 {
@@ -974,6 +982,9 @@ cygwin_dll_init ()
   user_data->envptr = &envp;
   user_data->fmode_ptr = &_fmode;
 
+  main_environ = user_data->envptr;
+  *main_environ = NULL;
+  initialize_main_tls((char *)&_my_tls);
   dll_crt0_1 (NULL);
 }
 
Index: winsup/doc/how-programming.texinfo
===================================================================
RCS file: /cvs/src/src/winsup/doc/how-programming.texinfo,v
retrieving revision 1.39
diff -u -p -r1.39 how-programming.texinfo
--- winsup/doc/how-programming.texinfo	8 May 2005 19:43:35 -0000	1.39
+++ winsup/doc/how-programming.texinfo	1 Jun 2005 19:39:35 -0000
@@ -269,6 +269,22 @@ then generate import libraries for the M
 Thanks to Alastair Growcott (alastair dot growcott at bakbone dot co
 dot uk) for this tip.
 
+@subsection How do I load @samp{cygwin1.dll} dynamically from a Visual Studio or MinGW application?
+
+Read @code{how-cygtls-works.txt} and the sample code in
+@code{winsup/testsuite/cygload} if you want to understand how this works.
+The short version is:
+
+@enumerate
+@item Make sure you have 4K of scratch space at the bottom of your stack.
+@item Invoke @code{cygwin_dll_init()}:
+@example
+HMODULE h = LoadLibrary("cygwin1.dll");
+void (*init)() = GetProcAddress(h, "cygwin_dll_init");
+init();
+@end example
+@end enumerate
+
 @subsection How do I link against a @samp{.lib} file?
 
 If your @samp{.lib} file is a normal static or import library with
Index: winsup/testsuite/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/Makefile.in,v
retrieving revision 1.19
diff -u -p -r1.19 Makefile.in
--- winsup/testsuite/Makefile.in	6 Jul 2003 21:45:21 -0000	1.19
+++ winsup/testsuite/Makefile.in	1 Jun 2005 19:39:35 -0000
@@ -186,7 +186,8 @@ check: $(TESTSUP_LIB_NAME) $(RUNTIME) cy
 	   TCL_LIBRARY=`cd .. ; cd ${srcdir}/../../tcl/library ; pwd` ; \
 	    export TCL_LIBRARY ; fi ; \
 	PATH=$(bupdir)/cygwin:$${PATH} ;\
-	$(RUNTEST) --tool winsup $(RUNTESTFLAGS)
+	$(RUNTEST) --tool winsup $(RUNTESTFLAGS) ;\
+	$(RUNTEST) --tool cygload $(RUNTESTFLAGS)
 
 cygrun.o: cygrun.c
 	$(CC) $(MINGW_CFLAGS) -o $@ -c $<
---
New file winsup/testsuite/cygload/cygload.cpp:
---
// cygload.cpp
//
// Copyright 2005, Red Hat, Inc.
//
// Written by Max Kaehn <slothman@electric-cloud.com>
//
// This software is a copyrighted work licensed under the terms of the
// Cygwin license.  Please consult the file "CYGWIN_LICENSE" for details.



// Options for this program:
// -v              Verbose output.  Normal operation is entirely silent,
//                 save for errors.
// -testsignals    Pauses the program for 30 seconds so you can demonstrate
//                 that it handles ^C properly.
// -cygwin         Name of DLL to load.  Defaults to "cygwin1.dll".

#include "cygload.h"
#include <iostream>
#include <sstream>
#include <vector>
#include <errno.h>              // for ENOENT
#include <sys/types.h>
#include <sys/stat.h>

using std::cout;
using std::cerr;
using std::endl;
using std::string;

cygwin::padding *cygwin::padding::_main = NULL;
DWORD cygwin::padding::_mainTID = 0;

// A few cygwin constants.
static const int SIGHUP = 1;
static const int SIGINT = 2;
static const int SIGTERM = 15;  // Cygwin won't deliver this one to us;
                                // expect unadorned "kill" to just kill
                                // your process.
static const int SIGSTOP = 17;  // Cygwin insists on delivering SIGSTOP to
                                // the main thread.  If your main thread
                                // is not interruptible, you'll miss the
                                // signal and ignore the request to suspend.
static const int SIGTSTP = 18;  // ^Z on a tty.
static const int SIGCONT = 19;  // Resume a stopped process.
static const int SIGUSR1 = 30;
static const int SIGUSR2 = 31;

// Using *out instead of cout.  In verbose mode, out == &cout.
static std::ostream *out = NULL;

cygwin::padding::padding()
{
    _main = this;
    _mainTID = GetCurrentThreadId();

    _end = _padding + sizeof(_padding);
    char *stackbase;
#ifdef __GNUC__
    __asm__ (
        "movl %%fs:4, %0"
        :"=r"(stackbase)
        );
#else
    __asm {
        mov eax, fs:[4];
        mov stackbase, eax;
    }
#endif
    _stackbase = stackbase;

    // We've gotten as close as we can to the top of the stack.  Even
    // subverting the entry point, though, still doesn't get us there-- I'm
    // getting 64 bytes in use before the entry point.  So we back up the data
    // there and restore it when the destructor is called:
    if ((_stackbase - _end) != 0) {
        size_t delta = (_stackbase - _end);

        _backup.resize(delta);

        memcpy(&(_backup[0]), _end, delta);
    }
}

cygwin::padding::~padding()
{
    _main = NULL;

    if (_backup.size()) {
        memcpy(_end, &(_backup[0]), _backup.size());
    }
}

void
cygwin::padding::check()
{
    if (_main == NULL)
        throw std::runtime_error("No padding declared!");
    if (_mainTID != GetCurrentThreadId())
        throw std::runtime_error("You need to initialize cygwin::connector "
                "in the same thread in which you declared the padding.");

    if (_main->_backup.size())
        *out << "Warning!  Stack base is "
             << static_cast<void *>(_main->_stackbase)
             << ".  padding ends at " << static_cast<void *>(_main->_end)
             << ".  Delta is " << (_main->_stackbase - _main->_end)
             << ".  Stack variables could be overwritten!" << endl;
}



cygwin::connector::connector(const char *dll)
{
    // This will throw if padding is not in place.
    padding::check();

    *out << "Loading " << dll << "..." << endl;

    // This should call init.cc:dll_entry() with DLL_PROCESS_ATTACH,
    // which calls dll_crt0_0().
    if ((_library = LoadLibrary(dll)) == NULL)
        throw windows_error("LoadLibrary", dll);

    *out << "Initializing cygwin..." << endl;

    // This calls dcrt0.cc:cygwin_dll_init(), which calls dll_crt0_1(),
    // which will, among other things:
    // * spawn the cygwin signal handling thread from sigproc_init()
    // * initialize the thread-local storage for this thread and overwrite
    //   the first 4K of the stack
    void (*cyginit)();
    get_symbol("cygwin_dll_init", cyginit);
    (*cyginit)();

    *out << "Loading symbols..." << endl;

    // Pick up the function pointers for the basic infrastructure.
    get_symbol("__errno", _errno);
    get_symbol("strerror", _strerror);
    get_symbol("cygwin_conv_to_full_posix_path", _conv_to_full_posix_path);
    get_symbol("cygwin_conv_to_full_win32_path", _conv_to_full_win32_path);

    // Note that you need to be running an interruptible cygwin function if
    // you want to receive signals.  You can use the standard signal()
    // mechanism if you're willing to have your main thread spend all its time
    // in interruptible cygwin functions like sleep().  Christopher Faylor
    // cautions that this solution "could be slightly racy":  if a second
    // signal comes in before the first one is done processing, the thread
    // won't be back in sigwait() to catch it.
    *out << "Spawning signal handling thread..." << endl;

    _waiting_for_signals = true;
    _signal_thread_done = false;
    InitializeCriticalSection(&_thread_mutex);

    DWORD tid;

    _signal_thread = CreateThread(
        NULL,                   // Default security.
        32768,                  // Adjust the stack size as appropriate
                                // for what your signal handler needs in
                                // order to run, and then add 4K for
                                // cygtls.
        &signal_thread,         // Function to call
        this,                   // Context
        0,                      // Flags
        &tid);                  // Thread ID

    if (_signal_thread == NULL)
        throw windows_error("CreateThread", "signal_thread");
}

cygwin::connector::~connector()
{
    try {
        // First, shut down signal handling.
        int (*raze)(int);
        int (*pthread_join)(void *, void **);

        get_symbol("raise", raze);
        get_symbol("pthread_join", pthread_join);

        // Tell the listener to shut down...
        _waiting_for_signals = false;
        int err = 0;
        EnterCriticalSection(&_thread_mutex);
        if (!_signal_thread_done)
            err = raze(SIGUSR2);
        LeaveCriticalSection(&_thread_mutex);
        if (err) cerr << error(this, "raise", "SIGUSR2").what() << endl;
        // ...and get the thread to join.
        if (!CloseHandle(_signal_thread))
            throw windows_error("CloseHandle", "signal_thread");

        // This should call init.cc:dll_entry() with DLL_PROCESS_DETACH.
        if (!FreeLibrary(_library))
            throw windows_error("FreeLibrary", "cygwin1.dll");
    }
    catch (std::exception &x) {
        cerr << x.what() << endl;
    }
}

DWORD WINAPI
cygwin::connector::signal_thread(void *param)
{
    connector *that = reinterpret_cast<connector *>(param);

    try {
        that->await_signal();
    }
    catch(std::exception &x) {
        cerr << "signal_thread caught " << x.what() << endl;
        return 1;
    }
    return 0;
}

void
cygwin::connector::await_signal()
{
    // Wait for signals.
    unsigned long sigset[32];
    int sig;
    int (*empty)(void *);
    int (*add)(void *, int);
    int (*wait)(void *, int *);

    get_symbol("sigemptyset", empty);
    get_symbol("sigaddset", add);
    get_symbol("sigwait", wait);

    empty(sigset);
    add(sigset, SIGHUP);
    add(sigset, SIGINT);
//    add(sigset, SIGSTOP);
//    add(sigset, SIGTSTP);       // I can't get this to suspend properly, so
                                // I'll leave it up to chance that the main
                                // thread is interruptible.
    add(sigset, SIGUSR1);
    add(sigset, SIGUSR2);

    while (_waiting_for_signals) {
        int err = wait(sigset, &sig);
        if (err) cerr << error(this, "sigwait").what() << endl;
        else *out << "Received signal " << sig << "." << endl;
        switch (sig) {
        case SIGUSR2:
            if(!_waiting_for_signals) {
                // SIGUSR2 is how ~connector wakes this thread
                goto done;
            }
            break;
        default:
            break;
        }
        handle_signals(sig);
    }
done:
    EnterCriticalSection(&_thread_mutex);
    _signal_thread_done = true;
    LeaveCriticalSection(&_thread_mutex);

    *out << "await_signal done." << endl;
}

cygwin::connector::signal_handler *
cygwin::connector::set_handler(int signal, signal_handler *handler)
{
    signal_handler *retval = _signal_handlers[signal];

    if (handler == NULL)
        _signal_handlers.erase(signal);
    else
        _signal_handlers[signal] = handler;

    return retval;
}

void
cygwin::connector::handle_signals(int sig)
{
    callback_list::iterator h = _signal_handlers.find(sig);

    if (h != _signal_handlers.end()) {
        try {
            signal_handler *handler = h->second;
            (*handler)(sig);
            return;
        }
        catch (std::exception &x) {
            cerr << "cygwin::connector::handle_signals caught "
                 << x.what() << "!" << endl;
            return;
        }
    }

    cerr << "No handler for signal " << sig << "!" << endl;
}

int
cygwin::connector::err_no() const
{
    int *e = (*_errno)();
    if (e == NULL) {
        return -1;
    }
    return *e;
}

string
cygwin::connector::str_error(int err_no) const
{
    string retval;

    const char *s = (*_strerror)(err_no);
    if (s != NULL) {
        retval = s;
    } else {
        std::ostringstream o;
        o << "Unexpected errno " << err_no;
        retval = o.str();
    }

    return retval;
}

string
cygwin::connector::unix_path(const string &windows) const
{
    char buf[MAX_PATH];

    _conv_to_full_posix_path(windows.c_str(), buf);

    return string(buf);
}

string
cygwin::connector::win_path(const string &unix) const
{
    char buf[MAX_PATH];

    _conv_to_full_win32_path(unix.c_str(), buf);

    return string(buf);
}

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

string cygwin::error::format(
    cygwin::connector *c,
    int err_no,
    const char *message,
    const char *detail)
{
    std::ostringstream ret;

    ret << message;
    if (detail) {
        ret << "(" << detail << ")";
    }
    ret << ":  " << c->str_error(err_no);

    return ret.str();
}

string windows_error::format(
    DWORD error,
    const char *message,
    const char *detail)
{
    std::ostringstream ret;
    char buf[512];
    DWORD bytes;

    ret << message;
    if (detail)
        ret << "(" << detail << ")";
    ret << ":  ";

    bytes = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, error,
                          MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
                          buf, sizeof(buf), 0);

    if (bytes == 0)
        ret << "Unexpected Windows error " << error;
    else {
        // Remove trailing whitespace
        char *p = buf + bytes - 1;
        while (isspace(*p)) *p-- = '\0';
        ret << buf << " (" << error << ")";
    }

    return ret.str();
}

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

extern "C" int mainCRTStartup();

// This just pushes 4K onto the stack, backs up the original stack, and
// jumps into the regular startup code.  This avoids having to worry about
// backing up argc and argv.
extern "C" int __stdcall cygloadCRTStartup()
{
    cygwin::padding padding;
    return mainCRTStartup();
}

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

static void
hangup(int sig)
{
    cout << "Hangup (" << sig << ")." << endl;
}

static void
interrupt(int sig)
{
    cerr << "Interrupt (" << sig << ")!" << endl;
    exit(0);
}

static int caught = false;

static void
catch_signal(int)
{
    *out << "Signals are working." << endl;
    caught = true;
}

int
main(int argc, char *argv[])
{
    // If you do not want to use cygloadCRTStartup() as an entry point,
    // uncomment this line, but be sure to have *everything* you want
    // from the stack below it backed up before you call the
    // constructor for cygwin::connector.
    //cygwin::padding padding;

    std::ostringstream output;
    bool verbose = false, testinterrupts = false;
    const char *dll = "cygwin1.dll";

    out = &output;

    for (int i = 1; i < argc; ++i) {
        string arg = string(argv[i]);

        if (arg == "-v") {
            verbose = true;
            out = &cout;
        } else if (arg == "-testinterrupts")
            testinterrupts = true;
        else if (arg == "-cygwin") {
            if (i+1 >= argc) {
                cerr << "Need to supply an argument with -cygwin." << endl;
                return 255;
            }
            dll = argv[++i];
        }
    }


    try {
        *out << "Connecting to cygwin..." << endl;
        cygwin::connector cygwin(dll);
        *out << "Successfully connected." << endl;

        string result = cygwin.str_error(ENOENT);

        if (result != "No such file or directory") {
            cerr << "strerror(ENOENT) returned \""
                 << result
                 << "\" instead of \"No such file or directory\"!"
                 << endl;
            return 1;
        } else if (verbose) {
            *out << "strerror(ENOENT) = " << result << endl;
        }

        // Path conversion:  from cygwin to Windows...
        result = cygwin.win_path("/usr");
        struct _stat statbuf;
        if (::_stat(result.c_str(), &statbuf) < 0) {
            cerr << "stat(\"" << result << "\") failed!" << endl;
            return 2;
        } else if (verbose) {
            *out << "/usr == " << result << endl;
        }

        // ...and back:
        char buf[MAX_PATH], scratch[256];
        GetSystemDirectory(buf, sizeof(buf));
        int (*cygstat)(const char *, void *);
        cygwin.get_symbol("stat", cygstat);

        if (cygstat(buf, scratch) < 0) {
            cerr << "cygwin stat(\"" << buf << "\") failed!" << endl;
            return 3;
        } else if (verbose) {
            *out << buf << " == " << cygwin.unix_path(buf) << endl;
        }

        // Test error handling.  This should output
        // "open(/potrzebie/furshlugginer):  No such file or directory"
        {
            int (*cygopen)(const char *, int);
            cygwin.get_symbol("open", cygopen);

            if (cygopen("/potrzebie/furshlugginer", 0 /* O_RDONLY */) < 0) {
                int err = cygwin.err_no();
                if (err != ENOENT) {
                    cerr << "cygwin open(\"/potrzebie/furshlugginer\", "
                            "O_RDONLY):  expected to fail with ENOENT, got "
                         << err << "!" << endl;
                    return 4;
                }
                if (verbose)
                    *out << cygwin::error(&cygwin, "open",
                            "/potrzebie/furshlugginer").what()
                         << endl;
            } else {
                cerr << "/potrzebie/furshlugginer should not exist!"
                     << endl;
                return 5;
            }
        }

        // And signal handling:
        std::pointer_to_unary_function<int,void> h1(&hangup);
        std::pointer_to_unary_function<int,void> h2(&interrupt);
        std::pointer_to_unary_function<int,void> h3(&catch_signal);
        cygwin.set_handler(SIGHUP, &h1);
        cygwin.set_handler(SIGINT, &h2);
        cygwin.set_handler(SIGUSR1, &h3);

        // Make sure the signal handler thread has had time to start...
        Sleep(100);
        // Send a test signal to set "caught" to true...
        int (*raze)(int);
        cygwin.get_symbol("raise", raze);
        raze(SIGUSR1);
        // And give the thread time to wait for the shutdown signal.
        Sleep(100);

        if (testinterrupts) {
            // This is a worst case scenario for testing interrupts:  the
            // main thread is in a long-duration Windows API call.  This
            // makes the main thread uninterruptible; cygwin will retry
            // 20 times, with a low_priority_sleep(0) between each try.
            cout << "Sleeping for 30 seconds, waiting for a signal..." << endl;
            Sleep(30000);
            cout << "Done waiting." << endl;
        }
    }
    catch (std::exception &x) {
        cerr << x.what() << endl;
        return 2;
    }

    if (caught)
        return 0;
    else {
        cerr << "Never received SIGUSR1." << endl;
        return 1;
    }
}
---
New file winsup/testsuite/cygload/cygload.h:
---
// cygload.h                                      -*- C++ -*-
//
// Copyright 2005, Red Hat, Inc.
//
// Written by Max Kaehn <slothman@electric-cloud.com>
//
// This software is a copyrighted work licensed under the terms of the
// Cygwin license.  Please consult the file "CYGWIN_LICENSE" for details.


// This file contains the basic infrastructure for connecting an MSVC
// process to Cygwin.

#ifndef __CYGLOAD_H__
#define __CYGLOAD_H__

#include <windows.h>            // for GetProcAddress()
#include <functional>           // for pointer_to_unary_function
#include <stdexcept>            // for runtime_error
#include <string>
#include <map>
#include <vector>

// Convert GetLastError() to a human-readable STL exception.
class windows_error : public std::runtime_error {
public:
    windows_error(const char *message, const char *detail = NULL)
        : runtime_error(format(GetLastError(), message, detail)) { }
    windows_error(DWORD error, const char *message, const char *detail = NULL)
        : runtime_error(format(error, message, detail)) { }

    static std::string format(DWORD error, const char *message,
            const char *detail);
};

namespace cygwin {

    // Cygwin keeps important thread-local information at the top of the
    // stack.  Its DllMain-equivalent will do the right thing for any threads
    // you spawn, but you need to declare one of these as the very first thing
    // in your main() function so horrible things won't happen when cygwin
    // overwrites your stack.  This will back up the data that will be
    // overwritten and restore it when the destructor is called.
    class padding {
    public:
        padding();
        ~padding();

        // Verifies that padding has been declared.
        static void check();

    private:
        std::vector<char> _backup;
        char *_stackbase, *_end;

        // gdb reports sizeof(_cygtls) == 3964 at the time of this writing.
        // This is at the end of the object so it'll be toward the bottom
        // of the stack when it gets declared.
        char _padding[4096];

        static padding *_main;
        static DWORD _mainTID;
    };

    // This hooks your application up to cygwin:  it loads cygwin1.dll,
    // initializes it properly, grabs some important symbols, and
    // spawns a thread to let you receive signals from cygwin.
    class connector {
    public:
        connector(const char *dll = "cygwin1.dll");
        ~connector();

        // A wrapper around GetProcAddress() for fetching symbols from the
        // cygwin DLL.  Can throw windows_error.
        template <class T> void get_symbol(const char *name, T &fn) const;

        // Wrappers for errno() and strerror().
        int err_no() const;
        std::string str_error(int) const;

        // Converting between the worlds of Windows and Cygwin.
        std::string unix_path(const std::string &windows) const;
        std::string win_path(const std::string &unix) const;

    private:
        HMODULE _library;

        int *(*_errno)();
        const char *(*_strerror)(int);
        void (*_conv_to_full_posix_path)(const char *, char *);
        void (*_conv_to_full_win32_path)(const char *, char *);

    public:
        // The constructor will automatically hook you up for receiving
        // cygwin signals.  Just specify a signal and pass in a signal_handler.
        typedef std::pointer_to_unary_function<int,void> signal_handler;
        signal_handler *set_handler(int signal, signal_handler *);

    private:
        // Cygwin signals can only be received in threads that are calling
        // interruptible functions or otherwise ready to intercept signals, so
        // we spawn a thread that does nothing but call sigwait().

        // This is the entry point:
        static DWORD WINAPI signal_thread(void *);
        // It runs this:
        void await_signal();
        // And will execute this on receipt of any signal for which it's
        // registered:
        void handle_signals(int);

        HANDLE _signal_thread;
        bool _waiting_for_signals, _signal_thread_done;
        CRITICAL_SECTION _thread_mutex;

        typedef std::map<int, signal_handler *> callback_list;
        callback_list _signal_handlers;
    };

    template <class T> void connector::get_symbol(const char *name,
        T &symbol) const
    {
        FARPROC retval = NULL;

        retval = GetProcAddress(_library, name);

        if (retval == NULL)
            throw windows_error("GetProcAddress", name);

        symbol = reinterpret_cast<T>(retval);
    }

    // cygwin::error converts errno to a human-readable exception.
    class error : public std::runtime_error {
    public:
        error(connector *c, const char *function, const char *detail = NULL)
            : runtime_error(format(c, c->err_no(), function, detail)) { }
        error(connector *c, int err_no, const char *function,
                const char *detail = NULL)
            : runtime_error(format(c, err_no, function, detail)) { }

        static std::string format(connector *c, int err_no,
                const char *message, const char *detail);
    };
}

#endif // __CYGLOAD_H__
---
New file winsup/testsuite/cygload/Makefile:
---
# Makefile for cygload

###
### MinGW options
###
CC = gcc
CFLAGS = -mno-cygwin -Wall
LINKFLAGS = -lstdc++ -Wl,-e,_cygloadCRTStartup@0

###
### MSVC options
###
ifndef MSVCDir
MSVCDir = C:/cygwin/usr/local/tools/i686_win32/vc7/Vc7
endif

CL = $(MSVCDir)/bin/cl
# If you want to look at the assembly, add "/Famsvc-cygload.asm /FAs".
MSVCCFLAGS = /nologo /GX /MDd /Zi /W4
MSVCINCLUDES = /I $(MSVCDir)/include /I $(MSVCDir)/PlatformSDK/Include
# Using /ENTRY seems to automatically invoke /NODEFAULTLIBS.
MSVCLIBS = /link /LIBPATH:$(MSVCDir)/lib /LIBPATH:$(MSVCDir)/PlatformSDK/lib \
	/ENTRY:cygloadCRTStartup uuid.lib msvcprtd.lib msvcrtd.lib \
	oldnames.lib kernel32.lib

all:	mingw-cygload.exe

mingw-cygload.exe:	cygload.cpp cygload.h
	$(CC) $(CFLAGS) $< -o $@ $(LINKFLAGS)

msvc-cygload.exe:	cygload.cpp cygload.h
	$(CL) $(MSVCCFLAGS) $(MSVCINCLUDES) $< /o $@ $(MSVCLIBS)

clean:
	rm -f msvc-cygload.exe msvc-cygload.ilk mscv-cygload.obj \
		msvc-cygload.pdb vc70.pdb mingw-cygload.exe
---
New file winsup/testsuite/cygload/README:
---
cygload demonstrates how to dynamically load cygwin1.dll.  The default
build uses MinGW to compile it; the Makefile also shows how to build
it using the Microsoft compiler.

By default, the program will silently test basic functionality:
        * Making space on the stack for cygtls
        * Loading and initializing cygwin1.dll
        * Path translation
        * Error handling
        * Signal handling

Command line parameters are:

    -v                 Verbose output
    -testinterrupts    Pause for 30 seconds to allow testing command line
                       interrupts (^C)
    -cygwin xxx        Specifies an alternative DLL to load instead of
                       cygwin1.dll.
---
New file winsup/testsuite/cygload/cygload.exp:
---
source "site.exp"

if { ! [isnative] } {
    verbose "skipping cygload because it's not native \"$target_triplet\" != \"$build_triplet\""
    return
}

proc ws_spawn {cmd args} {
    global rv
    verbose "running $cmd\n"
    set rv {}
    # First item in rv is the return code, second item is the message
    lappend rv [catch "exec $cmd" message] $message
    verbose send "catchCode = $rv\n"
}

ws_spawn "gcc -mno-cygwin $srcdir/$subdir/cygload.cpp -o mingw-cygload.exe -lstdc++ -Wl,-e,_cygloadCRTStartup@0"

if { $rv != {0 {}} } {
    verbose -log "$rv"
    fail "cygload (compile)"
} else {
    if { $verbose } {
        set redirect_output "./mingw-cygwin.log"
    } else {
        set redirect_output /dev/null
    }
    set windows_runtime_root [exec cygpath -m $runtime_root]
    ws_spawn "./mingw-cygload.exe -cygwin $windows_runtime_root/cygwin0.dll > $redirect_output"
    if { $rv != {0 {}} } {
        verbose -log "cygload: $rv"
        fail "cygload (execute)"
    } else {
        pass "cygload"
    }
    catch { file delete "mingw-cygload.exe" } err
    if { $err != "" } {
        note "error deleting mingw-cygload.exe: $err"
    }
}
---
New file winsup/cygwin/how-cygtls-works.txt:
---
Copyright 2005 Red Hat Inc., Max Kaehn

All cygwin threads have separate context in an object of class _cygtls.  The
storage for this object is kept on the stack in the bottom CYGTLS_PADSIZE
bytes.  Each thread references the storage via the Thread Environment Block
(aka Thread Information Block), which Windows maintains for each user thread
in the system, with the address in the FS segment register.  The memory
is laid out as in the NT_TIB structure from <w32api/winnt.h>:

typedef struct _NT_TIB {
	struct _EXCEPTION_REGISTRATION_RECORD *ExceptionList;
	PVOID StackBase;
	PVOID StackLimit;
	PVOID SubSystemTib;
	_ANONYMOUS_UNION union {
		PVOID FiberData;
		DWORD Version;
	} DUMMYUNIONNAME;
	PVOID ArbitraryUserPointer;
	struct _NT_TIB *Self;
} NT_TIB,*PNT_TIB;

Cygwin sees it like this:

extern exception_list *_except_list asm ("%fs:0");      // exceptions.cc
extern char *_tlsbase __asm__ ("%fs:4");                // cygtls.h
extern char *_tlstop __asm__ ("%fs:8");                 // cygtls.h

And accesses cygtls like this:

#define _my_tls (((_cygtls *) _tlsbase)[-1])            // cygtls.h


Initialization always goes through _cygtls::init_thread().  It works
in the following ways:

* In the main thread, _dll_crt0() provides CYGTLS_PADSIZE bytes on the stack
  and passes them to initialize_main_tls(), which calls _cygtls::init_thread().
  It then calls dll_crt0_1(), which terminates with cygwin_exit() rather than
  by returning, so the storage never goes out of scope.

  If you load cygwin1.dll dynamically from a non-cygwin application, it is
  vital that the bottom CYGTLS_PADSIZE bytes of the stack are not in use
  before you call cygwin_dll_init().  See winsup/testsuite/cygload for
  more information.

* Threads other than the main thread receive DLL_THREAD_ATTACH messages
  to dll_entry() (in init.cc).
  - dll_entry() calls munge_threadfunc(), which grabs the function pointer
    for the thread from the stack frame and substitutes threadfunc_fe(),
  - which then passes the original function pointer to _cygtls::call(),
  - which then allocates CYGTLS_PADSIZE bytes on the stack and hands them
    to call2(),
  - which allocates an exception_list object on the stack and hands it to
    init_exceptions() (in exceptions.cc), which attaches it to the end of
    the list of exception handlers, changing _except_list (aka
    tib->ExceptionList), then passes the cygtls storage to init_thread().
    call2() calls ExitThread() instead of returning, so the storage never
    goes out of scope.

Note that the padding isn't necessarily going to be just where the _cygtls
structure lives; it just makes sure there's enough room on the stack when the
CYGTLS_PADSIZE bytes down from there are overwritten.


Debugging

You can examine the segment registers in gdb via "info w32 selector $fs"
(which is using GetThreadSelectorEntry()) to get results like this:

    Selector $fs
    0x03b: base=0x7ffdd000 limit=0x00000fff 32-bit Data (Read/Write, Exp-up)
    Priviledge level = 3. Byte granular.

"x/3x 0x7ffdd000" will give you _except_list, _tlsbase, and _tlstop.

---

