Return-Path: <cygwin-patches-return-2601-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8862 invoked by alias); 5 Jul 2002 06:50:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8846 invoked from network); 5 Jul 2002 06:50:45 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Thu, 04 Jul 2002 23:50:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] pthread_key patch
Message-ID: <Pine.WNT.4.44.0207050848100.224-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00049.txt.bz2



If somebody is interested why if find this patch neccessary with a posix
threaded gcc could read
http://cygwin.com/ml/cygwin-patches/2002-q2/msg00214.html

At least the changes in pthread_key::get should be applied, peoble would
be very surprised if the value of errno or Win32LastError will be set to 0
behind her back.

Thomas

Changelog:

2002-07-05  Thomas Pfaff  <tpfaff@gmx.net>

	* init.cc (dll_entry): Run the pthread_key destructors on thread
	and process detach. This will make sure that regardless a thread
	is created with pthread_create or CreateThread its eh context
	will be freed.
	* thread.cc: Moved #define MT_INTERFACE from thread.cc to
	thread.h.
	(pthread_key_destructor_list::IterateNull): Run
	destructor only if value is not NULL.
	(pthread_key::get): Save and restore WIN32 LastError to avoid
	that Lasterror is cleared in the exception handling code.
	set_errno (0) removed.
	(__pthread_exit): Removed IterateNull call. This will be done
	during thread detach.
	* thread.h (pthread::cleanup_stack): Moved #define MT_INTERFACE
	user_data->threadinterface from thread.cc to this location.


