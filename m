Return-Path: <cygwin-patches-return-4694-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29362 invoked by alias); 21 Apr 2004 07:18:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29347 invoked from network); 21 Apr 2004 07:18:12 -0000
Date: Wed, 21 Apr 2004 07:18:00 -0000
From: "Thomas Pfaff" <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Subject: Recent changes in pthread_create
X-Authenticated: #623905
Message-ID: <18588.1082531891@www4.gmx.net>
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00046.txt.bz2

Chris,

i am not so happy with the recent changes to pthread_create and
pthread::init_wrapper.
They remind my of a bug that i have fixed about 2 years ago:

From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] minor pthread fixes
Date: Thu, 18 Apr 2002 12:11:26 +0200
[...]
2. The InterlockedIncrement (&MT_INTERFACE->threadcount) in
  __pthread_create is misplaced. If the newly created thread terminates
  fast enough the threadcount will be decremented before it was
  incremented, which will result in an exit from __pthread_exit instead
  of an ExitThread.
[... ]

Same thing will now happen again after your change from CREATE_SUSPENDED to
0 in CreateThread.

Thomas

-- 
"Sie haben neue Mails!" - Die GMX Toolbar informiert Sie beim Surfen!
Jetzt aktivieren unter http://www.gmx.net/info
