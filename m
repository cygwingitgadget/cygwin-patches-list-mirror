Return-Path: <cygwin-patches-return-2052-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27329 invoked by alias); 12 Apr 2002 08:02:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27278 invoked from network); 12 Apr 2002 08:02:53 -0000
Date: Fri, 12 Apr 2002 01:02:00 -0000
From: Pavel Tsekov <ptsekov@syntrex.com>
Reply-To: Pavel Tsekov <ptsekov@syntrex.com>
Organization: Syntrex, Inc.
X-Priority: 3 (Normal)
Message-ID: <1461548706.20020412100237@syntrex.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] setutp.exe issue was Re[3]: Cygwin 1.3.10 Setup.exe 2.194.2.22 Install Problems With MSVCRT.DLL and source code on Win98
In-Reply-To: <08165371.20020410120613@syntrex.com>
References: <000401c1e033$e5bce3c0$0301a8c0@kc.rr.com>
 <1921297856.20020410101146@syntrex.com> <08165371.20020410120613@syntrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00036.txt.bz2

No comments on this at all ?

PT> Ok, found it - its canonicalize_version() in version.cc. There is
PT> a pointer 'v' which is modified and then delete[]'d.

PT> A trivial patch is attached :)

PT> 2002-04-10  Pavel Tsekov  <ptsekov@gmx.net>

PT>             * version.cc (canonicalize_version): Fix a call delete[]
PT>             to delete.
