Return-Path: <cygwin-patches-return-2894-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22339 invoked by alias); 30 Aug 2002 17:36:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22325 invoked from network); 30 Aug 2002 17:36:39 -0000
Date: Fri, 30 Aug 2002 10:36:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <87198041378.20020830213538@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: Re: more robust tty_list::allocate_tty
In-Reply-To: <20020830160429.GA3580@redhat.com>
References: <E17knsZ-0005L4-00@diver.doc.ic.ac.uk>
 <20020830160429.GA3580@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00342.txt.bz2

Hi!

Friday, 30 August, 2002 Christopher Faylor cgf@redhat.com wrote:

CF> On Fri, Aug 30, 2002 at 03:40:10PM -0000, Chris January wrote:

CF> This is a nice change, but the preferred way of doing this is to use
CF> autoload functionality.  Then we don't have to worry about adding a new
CF> capability every time there is a new OS release.

CF> I've checked in a modified version of this patch which does this.

CF> I've wanted something like this in cygwin for a while.  I appreciate
CF> your researching this.

GetConsoleWindow() has no parameters.

Index: autoload.cc
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/autoload.cc,v
retrieving revision 1.54
diff -u -p -2 -r1.54 autoload.cc
--- autoload.cc 30 Aug 2002 16:03:52 -0000      1.54
+++ autoload.cc 30 Aug 2002 17:27:48 -0000
@@ -495,5 +495,5 @@ LoadDLLfuncEx (CancelIo, 4, kernel32, 1)
 LoadDLLfuncEx (CreateHardLinkA, 12, kernel32, 1)
 LoadDLLfuncEx (CreateToolhelp32Snapshot, 8, kernel32, 1)
-LoadDLLfuncEx (GetConsoleWindow, 4, kernel32, 1)
+LoadDLLfuncEx (GetConsoleWindow, 0, kernel32, 1)
 LoadDLLfuncEx2 (IsDebuggerPresent, 0, kernel32, 1, 1)
 LoadDLLfuncEx (Process32First, 8, kernel32, 1)

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
