Return-Path: <cygwin-patches-return-1496-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 27891 invoked by alias); 15 Nov 2001 11:26:27 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 27875 invoked from network); 15 Nov 2001 11:26:22 -0000
Date: Thu, 11 Oct 2001 11:46:00 -0000
From: egor duda <deo@logos-m.ru>
X-Mailer: The Bat! (v1.53 RC/4)
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <17285934467.20011115142602@logos-m.ru>
To: "Robert Collins" <robert.collins@itdomain.com.au>
CC: cygwin-patches@cygwin.com
Subject: Re: PTHREAD_COND_INITIALIZER support
In-Reply-To: <92602986318.20011109105819@logos-m.ru>
References: 
 <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F28E@itdomain002.itdomain.net.au>
 <92602986318.20011109105819@logos-m.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2001-q4/txt/msg00028.txt.bz2

Hi!

Friday, 09 November, 2001 egor duda deo@logos-m.ru wrote:

ed> well, since it's "feature added" rather than "bug fixed" kind of patch
ed> i think it should wait after 1.3.5 release.

done.

RC>> Have you got a test case for pthread_cond_initializer support
RC>> currently?

ed> yes. i'm going to add a bunch of pthread tests after this checkin.

done too.

Robert, can you please take a look at winsup.api/pthread/condvar3_1.c
test? it looks like when condition variable is signalled, two threads
wake on it instead of one. it's quite stable effect, so i don't think
we have a race here.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
