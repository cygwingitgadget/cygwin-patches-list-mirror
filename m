Return-Path: <cygwin-patches-return-4506-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22445 invoked by alias); 15 Dec 2003 13:23:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22436 invoked from network); 15 Dec 2003 13:23:11 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 15 Dec 2003 13:23:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Error checking in init_main_thread
In-Reply-To: <Pine.WNT.4.44.0312151357380.1836-200000@algeria.intern.net>
Message-ID: <Pine.WNT.4.44.0312151422020.404-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q4/txt/msg00225.txt.bz2



On Mon, 15 Dec 2003, Thomas Pfaff wrote:

> Chris,
>
> while the cancel event creation looks good now i would make sure that
> the process is created only when the handles are valid.
>
> Thomas
>
> 2003-15-15  Thomas Pfaff  <tpfaff@gmx.net>
  2003-12-15
>
> 	* thread.cc (pthread::init_main_thread): Make sure that the
> 	main thread has valid handles.
> 	(pthread::create_cancel_event): Fix error message.
>
>
