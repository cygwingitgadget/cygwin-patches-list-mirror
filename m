Return-Path: <cygwin-patches-return-4355-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3115 invoked by alias); 11 Nov 2003 14:44:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3099 invoked from network); 11 Nov 2003 14:44:00 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <3FB0F5A6.1050207@gmx.net>
Date: Tue, 11 Nov 2003 14:44:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] stdio initialization
References: <Pine.WNT.4.44.0311101211450.1520-200000@algeria.intern.net> <20031110135740.GA12455@redhat.com> <3FAF9A9A.3070509@gmx.net> <20031110150952.GA10851@redhat.com> <20031110153018.GA12119@redhat.com>
In-Reply-To: <20031110153018.GA12119@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q4/txt/msg00074.txt.bz2

Christopher Faylor wrote:
> 
> Actually, on poking around a little, I wonder if we should be calling
> _reclaim_reent to get back all of the stuff allocated in the REENT
> structure?
> 

I think you are right.
Here is my patch to thread.cc that i will apply if there are no objections.

diff -urp src.org/thread.cc src/thread.cc
--- src.org/thread.cc	2003-11-11 09:16:39.775574400 +0100
+++ src/thread.cc	2003-11-11 09:21:24.304707200 +0100
@@ -377,6 +377,8 @@ pthread::exit (void *value_ptr)
        mutex.unlock ();
      }

+  (_reclaim_reent) (_REENT);
+
    if (InterlockedDecrement (&MT_INTERFACE->threadcount) == 0)
      ::exit (0);
    else
@@ -1879,6 +1881,7 @@ __reent_t::init_clib (struct _reent& var
    var._stdout = _GLOBAL_REENT->_stdout;
    var._stderr = _GLOBAL_REENT->_stderr;
    var.__sdidinit = _GLOBAL_REENT->__sdidinit;
+  var.__cleanup = _GLOBAL_REENT->__cleanup;
    _clib = &var;
  };
